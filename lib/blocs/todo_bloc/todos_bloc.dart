import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:iremember/blocs/todo_bloc/todos_event.dart';
import 'package:iremember/blocs/todo_bloc/todos_state.dart';
import 'package:iremember/data/repositories/todo_repository.dart';
import 'package:meta/meta.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodoRepositoryImpl todoRepositoryImpl;
  StreamSubscription todosSubscription;

  TodosBloc() {
    todoRepositoryImpl = TodoRepositoryImpl();
  }

  @override
  TodosState get initialState => TodosLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    print("IN stream");
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is TodosUpdated) {
      yield TodosLoaded(todos: event.list);
    } else if (event is AddTodo) {
      print("IN addtodo");
      yield AddingTodos();
      print("IN add todoloading");
      try {
        todoRepositoryImpl.addTodo(event.todoModel);
        print("IN added");
        yield TodoAdded();
      } catch (e) {
        yield TodoAdditionFailed(message: e.toString());
      }
    } else if (event is DeleteTodo) {
      todoRepositoryImpl.deleteTodo(event.todoModel);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    todosSubscription?.cancel();
    todosSubscription = todoRepositoryImpl.getTodos().listen(
      (todosList) {
        add(TodosUpdated(
          list: todosList,
        ));
      },
    );
  }
}
