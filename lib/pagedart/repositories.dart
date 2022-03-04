import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GitRepositoriesPage extends StatefulWidget {
  var login;
  var avatarUrl;

  GitRepositoriesPage({this.login, this.avatarUrl});

  @override
  _State createState() => _State();
}

class _State extends State<GitRepositoriesPage> {
  dynamic dataRepositories;

  @override
  void initState() {
    super.initState();
    loadRepositories();
  }

  void loadRepositories() async {
    String url = "https://api.github.com/users/${widget.login}/repos";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        dataRepositories = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Repositories ${widget.login}'),
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.avatarUrl),
            )
          ],
        ),
        body: Center(
          child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text("${dataRepositories[index]['name']}"),
            ),
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.deepOrange),
            itemCount: dataRepositories == null ? 0 : dataRepositories.length,
          ),
        ));
  }
}
