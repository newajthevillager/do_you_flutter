import 'package:flutter/material.dart';

import 'add.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: Icon(Icons.home),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigateToAddPage(context);
          },
        ),
      ) 
    );
  }

  void navigateToAddPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AddPage();
      }
    ));
  }

}
