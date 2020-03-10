import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/blocs/todo_bloc/todos_bloc.dart';
import 'package:iremember/blocs/todo_bloc/todos_event.dart';
import 'package:iremember/blocs/todo_bloc/todos_state.dart';
import 'package:iremember/data/models/TodoModel.dart';
import 'package:uuid/uuid.dart';

//TODO allow user to pick image and display the preview in UI
//TODO save new data to firestore (upload image to storage)

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String title;
  String description;
  File todoImage;
  TodosBloc todosBloc;

  Uuid uuid = Uuid();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todosBloc = BlocProvider.of<TodosBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          print("Listening");
          if (state is TodoAdded) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Added a Todo"),
            ));
          } else if (state is TodoAdditionFailed) {
            print("FAILed");
          } else if (state is AddingTodos) {}
        },
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            // BlocBuilder<TodosBloc, TodosState>(
            //   builder: (context, state) {
            //     if (state is TodoAdded) {
            //       print("Todo added");
            //     } else if (state is AddingTodos) {
            //       print("adding");
            //     } else if (state is TodosLoading) {
            //       print("loading");
            //     }
            //     return Container();
            //   },
            // ),
            Container(
              child: ClipRect(
                child: todoImage != null
                    ? Image.file(
                        todoImage,
                        width: 210.0,
                        height: 100.0,
                        fit: BoxFit.fill,
                      )
                    : Container(),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            _buildTitleField(),
            SizedBox(
              height: 20,
            ),
            _buildDescriptionField(),
            SizedBox(
              height: 20,
            ),
            _buildImgSelectButton(),
            SizedBox(
              height: 20,
            ),
            _buildSaveButton(context)
          ],
        ),
      ),
    );
  }

  TextField _buildTitleField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          title = value;
        });
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "title",
          prefixIcon: Icon(Icons.title)),
    );
  }

  TextField _buildDescriptionField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          description = value;
        });
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
    );
  }

  SizedBox _buildImgSelectButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton.icon(
        icon: Icon(Icons.camera, color: Colors.white),
        label: Text("Add Image", style: TextStyle(color: Colors.white)),
        color: Colors.blue,
        onPressed: () async {
          await pickImageFromGallery();
              print("image picked");
        },
      ),
    );
  }

  SizedBox _buildSaveButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 20.0,
      child: RaisedButton.icon(
        icon: Icon(Icons.save, color: Colors.white),
        label: Text("Save", style: TextStyle(color: Colors.white)),
        color: Colors.blue,
        onPressed: () async {
          if (title == null || description == null) {
            return;
          }
          String imageUrl =
              todoImage != null ? await uploadImageToDatabase(todoImage) : null;
          TodoModel todoModel = TodoModel(
            title: title,
            description: description,
            imageUrl: imageUrl,
          );
          todosBloc.add(
            AddTodo(
              todoModel: todoModel,
            ),
          );
        },
      ),
    );
  }

  // upload profile image
  Future<String> uploadImageToDatabase(File image) async {
    var id = uuid.v1();
    StorageReference reference =
        FirebaseStorage.instance.ref().child("images/todoPics/$id");
    StorageUploadTask uploadTask = reference.putFile(image);
    var downLoadUri = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downLoadUri.toString();
  }

  Future pickImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      todoImage = image;
    });
  }
}
