
class User {
  final _users = [
    {
      "id" : 1,
      "first_name" : "Luap",
      "name" : "Dever",
      "birthday" : DateTime.now(),
      "adress" : "Ad058 Est",
      "phone" : "22951486388",
      "mail" : "example@gmail.com",
      "gender" : "masculin",
      "picture" : "https://all-my-files.000webhostapp.com/uploads/articles/images/48LC97aj1VBCN7bOwbUBry7W3rxm1rwUaJSUu6nh.jpg",
      "citation" : "Take more courage for flying high"
    },
    {
      "id" : 2,
      "first_name" : "Luap 2",
      "name" : "Dever",
      "birthday" : DateTime.now(),
      "adress" : "Ad058 Est",
      "phone" : "22951486388",
      "mail" : "example@gmail.com",
      "gender" : "masculin",
      "picture" : "https://all-my-files.000webhostapp.com/uploads/articles/images/48LC97aj1VBCN7bOwbUBry7W3rxm1rwUaJSUu6nh.jpg",
      "citation" : "Take more courage for flying high"
    },
    {
      "id" : 1,
      "first_name" : "Luap 3",
      "name" : "Dever",
      "birthday" : DateTime.now(),
      "adress" : "Ad058 Est",
      "phone" : "22951486388",
      "mail" : "example@gmail.com",
      "gender" : "masculin",
      "picture" : "https://all-my-files.000webhostapp.com/uploads/articles/images/48LC97aj1VBCN7bOwbUBry7W3rxm1rwUaJSUu6nh.jpg",
      "citation" : "Take more courage for flying high"
    },
  ];

  get_list() {
    return _users;
  }

  Map<String, Object> get_user(int id) {
    return _users.firstWhere((element) => element["id"] == id);
  }

  User();
}