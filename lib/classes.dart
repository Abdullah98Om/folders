import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Node {
  String name;
  Node parent;
  // List<Node> children;
  // List<Map<String, dynamic>> children;
  List<dynamic> children;

  Node({this.children, this.parent, this.name});
}

class Tree {
  Node root;
  int size = 0;

  void createTree(Map<String, dynamic> map) {
    print(map);
    Queue<Node> queue = Queue<Node>();
    // Map<String, dynamic> mymap = map;
    List<Map<String, dynamic>> childrenRoot = [];
    for (Map<String, dynamic> i in map["children"]) {
      childrenRoot.add(i);
    }
    root = Node(name: map["name"], parent: null, children: childrenRoot);
    queue.add(root);

    while (queue.length > 0) {
      Node node = queue.removeFirst();
      size++;
      print(node.name);

      if (node.children != null) {
        List<Node> listChildren = [];
        for (Map<String, dynamic> i in node.children) {
          Node n = Node(name: i["name"], parent: node, children: i["children"]);
          queue.add(n);
          listChildren.add(n);
        }
        node.children = listChildren;
      }
    }
    
    
    
    print("size : $size");
    print("===root=== > ${root.name}");


  }


  // void createDepthTree() {
  //   print("===================== show Tree ====================");

  //   List<Node> stack = List<Node>(size);
  //   int top = 0;

  //   // print("size : ${stack.length}");

  //   for (int i = 0; i < size; i++) {
  //     stack[i] = Node();
  //   }

  //   Node current = root;
  //   stack[top] = current;
  //   top++;


  //   while (top < stack.length) {
  //     while (current.children != null) {
  //       int countChildren = 0;
  //       for (Node i in current.children) {
  //         countChildren++;
  //         bool exist = false;

  //         for (int j = 0; j < top; j++) {
  //           if (i.name == stack[j].name) {
  //             exist = true;
  //             break;
  //           }
  //         }

  //         if (!exist) {
  //           stack[top] = i;
  //           top++;
  //           current = i;
  //           print("add item to stack ==== ");
  //           // flag=true;
  //           break;
  //         } else if (exist && current.children.length == countChildren) {
  //           current = current.parent;
  //         }
  //       }
  //       // current=current.parent;

  //     }
      
  //     current = current.parent;
  //   }

    

  //   // stack.forEach((element) {
  //   //   // print(element.name);

      
      
  //   // });
    
    
  // }




Widget tile(Node node){
  // counter++;
  if( node.children == null ){
    return ListTile(title: Text(node.name));}



  return ExpansionTile (
    title: Text(node.name),
    children:node.children.map((e){ 
      print("e: ${e.name}");
      return tile(e); 
    //  return ListTile(title: Text(e.name));
      }).toList(),
  
  );

}

}



