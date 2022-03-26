import 'package:flutter/material.dart';
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/sql_db/sql_helper.dart';


class MySearchDelegate extends SearchDelegate<String> {
  List<Map<String, dynamic>> _list = [];
  List<Map> _history = [];

  Iterable<Map> _searchInList(String search) {
    return _list.where((user) {
      return User.getFullName(user).toString().contains(RegExp(query, caseSensitive: false));
    });
  }

  MySearchDelegate() : super() {
    SQLHelper.getItems().then((value) {
      _list = value;
    });
    _history = [];
  }

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, '');
      },
    );
  }


  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    final results = _searchInList(this.query).toList();
    if(results.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text("No result")),
      );
    }

    return buildSuggestions(context);
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<Map> suggestions = this.query.isEmpty
        ? _history
        : _searchInList(query);

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (Map suggestion) {
        this.query = User.getFullName(suggestion);
        this._history.insert(0, suggestion);
        Navigator.of(context).pushNamed(
          "user",
          arguments: UserArguments(suggestion["id"], User.getFullName(suggestion))
        );
      },
    );
  }
// Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            this.query = 'TODO: implement voice input';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions,
      required this.query,
      required this.onSelected});

  final List<Map> suggestions;
  final String query;
  final ValueChanged<Map> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1!;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final Map user = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(Icons.person),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: User.getFullName(user).substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: User.getFullName(user).substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          trailing: const Icon(Icons.remove_red_eye_outlined),
          onTap: () {
            Navigator.of(context).pushNamed(
              "user",
              arguments: UserArguments(user["id"], User.getFullName(user))
            );
          },
        );
      },
    );
  }
}