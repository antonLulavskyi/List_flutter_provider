import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class Data extends ChangeNotifier {
  var list = ['First item','Second item'];

  void addItemToTheList(String newItem) {
    list.add(newItem);
    notifyListeners();

  }

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Column(
            children: [
              List(),
              Level1(),

            ],

          ),
        ),
      ),
    );
  }
}

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text('List - Provider', style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),),
          Container(
            height: 500.0,
            child: ListView.builder(
              itemCount: Provider.of<Data>(context).list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${Provider.of<Data>(context).list[index]}'),
                );
              },
            ),
          ),
        ],
      )

    );
  }
}

class Level1 extends StatefulWidget {
  @override
  _Level1State createState() => _Level1State();
}

class _Level1State extends State<Level1> {

  String newItem;
  var textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: textEditingController,
            onChanged: (newValue) {
              setState(() {
                newItem = newValue;
              });

            },
          ),
        ),
        SizedBox(height: 20.0,),
        FloatingActionButton(
          child: Text('Add'),
          onPressed: () {
            if (newItem != null) {
              Provider.of<Data>(context, listen: false).addItemToTheList(newItem);
              textEditingController.clear();
              newItem = null;
            }

          },)
      ],
    );
  }
}
