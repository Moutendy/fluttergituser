import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_hub_mobile_app/pagedart/repositories.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<UsersPage> {
  String query = "";
  late bool novisible = false;
  TextEditingController queryTextEditingController =
      new TextEditingController();
  dynamic data;
  int currentPage = 0;
  int totalPages = 0;
  int pageSize = 20;
  ScrollController scrollController = new ScrollController();
  List<dynamic> items = [];
  void _search(String query) {
    String url =
        "https://api.github.com/search/users?q=${query}&per_page=$pageSize&page=$currentPage";

    http.get(Uri.parse(url)).then((response) {
      setState(() {
        this.data = json.decode(response.body);
        this.items.addAll(data['items']);
        if (data['total_count'] % pageSize == 0) {
          this.totalPages = this.data['total_count'] ~/ pageSize;
        } else {
          this.totalPages = (this.data['total_count'] ~/ pageSize).floor() + 1;
        }
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          if (currentPage < totalPages - 1) {
            ++currentPage;
            _search(query);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users=>${query}=>$currentPage/ $totalPages'),
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: novisible,
                  onChanged: (value) {
                    setState(() {
                      this.query = value;
                    });
                  },
                  controller: queryTextEditingController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              novisible = !novisible;
                            });
                          },
                          icon: Icon(novisible == true
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      contentPadding: EdgeInsets.only(left: 25),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide:
                              BorderSide(width: 1, color: Colors.deepOrange))),
                ),
              )),
              IconButton(
                onPressed: () {
                  setState(() {
                    items = [];
                    currentPage = 0;
                    this.query = queryTextEditingController.text;
                    if (this.query != "") {
                      _search(query);
                    } else {
                      String vide = "vide";
                      _search(vide);
                    }
                  });
                },
                icon: Icon(Icons.search),
                color: Colors.deepOrange,
              )
            ],
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        height: 2,
                        color: Colors.deepOrange,
                      ),
                  controller: scrollController,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GitRepositoriesPage(
                                      login: this.items[index]['login'],
                                      avatarUrl: this.items[index]
                                          ['avatar_url'],
                                    )));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(items[index]['avatar_url']),
                                radius: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("${items[index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${items[index]['score']}"),
                          )
                        ],
                      ),
                    );
                  })),
        ],
      )),
    );
  }
}

class $ {}
