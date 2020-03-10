import 'package:equatable/equatable.dart';
import 'package:iremember/data/models/TodoModel.dart';
import 'package:meta/meta.dart';

abstract class TodosEvent extends Equatable {}

class LoadTodos extends TodosEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AddTodo extends TodosEvent {

  TodoModel todoModel;

  AddTodo({@required this.todoModel});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DeleteTodo extends TodosEvent {

  TodoModel todoModel;

  DeleteTodo({@required this.todoModel});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

// to update a single note
class UpdateTodo extends TodosEvent {

  TodoModel todoModel;

  UpdateTodo({@required this.todoModel});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

// when todos list gets upadted
class TodosUpdated extends TodosEvent {

  List<TodoModel> list;

  TodosUpdated({@required this.list});

  @override
  // TODO: implement props
  List<Object> get props => null;
}