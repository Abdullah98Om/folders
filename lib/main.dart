import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tree_data_structer/classes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My Folder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> data = {
    "data": [
      {
        "name": "folder1",
        "children": [
          {
            "name": "folder11",
            "children": [
              {"name": "file11", "children": null},
              {"name": "file12", "children": null}
            ]
          },
          {
            "name": "folder12",
            "children": [
              {
                "name": "file21",
                "children": [
                  {"name": "file31", "children": null},
                  {"name": "file32", "children": null}
                ]
              },
              {"name": "file22", "children": null}
            ]
          }
        ]
      }
    ]
  };

  Tree myTree;

  Map<String, dynamic> myJson;
  TextEditingController _controller = TextEditingController();
  String error = "";

  void convertJsonTofolder() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        error = "";
      });

      try {
        myJson = jsonDecode(_controller.text);
        print(myJson);
        if (myJson.length > 0) {
          setState(() {
            data = {
              "data": [myJson]
            };
          });
        } else {
          setState(() {
            error = "check your json ..";
          });
        }
      } catch (ex) {
        setState(() {
          error = "error with your json text ..";
        });
      }
    } else {
      setState(() {
        error = "Your Json is empty , Enter your json text ..";
      });
    }
  }

  Widget inital() {
    myTree = Tree();

    try {
      myTree.createTree(data["data"][0]);

      print("object ==== ${myTree.root.name}");
      return myTree.tile(myTree.root);
    } catch (ex) {
      setState(() {
        error =
            "error check your json : keys name inside json only : (name , children). for example => {  \"name\": \"folder1\", \"children\": [ { \"name\": \"folder11\", \"children\": [ ] }, ] }";
      });
    }
  }

  @override
  void initState() {
    // inital();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "keys name inside json only : (name , children)",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                controller: _controller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter Your Json text ..",
                ),
              ),
            ),
            InkWell(
              onTap: convertJsonTofolder,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "Convert",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "$error",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            Container(
                child:
                    // myJson != null ?
                    inital()
                // : Container(),

                ),
          ],
        ),
      ),
    );
  }
}
