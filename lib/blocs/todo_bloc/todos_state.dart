import 'package:equatable/equatable.dart';
import 'package:iremember/data/models/TodoModel.dart';
import 'package:meta/meta.dart';

abstract class TodosState extends Equatable {}

class TodosLoading extends TodosState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TodosLoaded extends TodosState {
  List<TodoModel> todos;

  TodosLoaded({@required this.todos});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TodosLoadingFailed extends TodosState {
  String message;

  TodosLoadingFailed({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TodoAdded extends TodosState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AddingTodos extends TodosState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TodoAdditionFailed extends TodosState {

  String message;

  TodoAdditionFailed({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}
