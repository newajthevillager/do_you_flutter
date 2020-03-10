import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iremember/blocs/todo_bloc/todos_bloc.dart';
import 'package:iremember/blocs/todo_bloc/todos_event.dart';
import 'package:iremember/blocs/todo_bloc/todos_state.dart';
import 'package:iremember/data/models/TodoModel.dart';

import 'add.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodosBloc todosBloc;

  @override
  void initState() {
    super.initState();
    todosBloc = BlocProvider.of<TodosBloc>(context);
    todosBloc.add(LoadTodos());
  }

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
          child: Stack(
            children: <Widget>[
              BlocBuilder<TodosBloc, TodosState>(
                builder: (context, state) {
                  if (state is TodosLoading) {
                    return buildLoadingUi();
                  } else if (state is TodosLoaded) {
                    return buildTodoListUi(state.todos);
                  } else if (state is TodosLoadingFailed) {
                    return buildErrorUi(state.message);
                  }
                  
                },
              ),
              Positioned(
                bottom: 10.0,
                right: 10.0,
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    navigateToAddPage(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void navigateToAddPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddPage();
    }));
  }

  Widget buildTodoListUi(List<TodoModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, position) {
        TodoModel model = list[position];
        return ListTile(
          leading: CircleAvatar(
            child: model.imageUrl != null
                ? Image.network(model.imageUrl)
                : FlutterLogo(size: 20.0),
          ),
          title: Text(model.title),
          subtitle: Text(model.description),
        );
      },
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
