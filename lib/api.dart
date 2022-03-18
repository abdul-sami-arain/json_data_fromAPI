import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

List<User> users = [];

class _ApiState extends State<Api> {
  getuser() async {
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));

    var jsondata = jsonDecode(response.body);

    for (var i in jsondata) {
      User user = User(i['id'], i['name'], i['email']);
      users.add(user);
    }
    print(users);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FutureBuilder(
                future: getuser(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    );
                  } else
                    return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text(users[index].id.toString()),
                            title: Text(users[index].name.toString()),
                            subtitle: Text(users[index].email.toString()),
                          );
                        });
                })));
  }
}

class User {
  int? id;
  String? name;
  String? email;
  User(this.id, this.name, this.email);
}
