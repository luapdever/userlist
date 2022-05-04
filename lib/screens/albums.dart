import 'package:userlist/Album.dart';
import 'package:userlist/Https/network.dart';
import 'package:flutter/material.dart';
import 'package:userlist/components/appbar.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {

  Future<Album>? futureAlbum;

  @override
  void initState() {
    super.initState();

    setState(() {
      futureAlbum = HTTPNetwork.fetchAlbum();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: BaseAppBar(titlePage: "Albums", context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const Text(
                      "Album Title",
                      style: TextStyle(
                        fontSize: 30
                      )
                    ),
                    Text(snapshot.data!.title)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
