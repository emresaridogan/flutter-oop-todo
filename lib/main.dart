import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}

class Todo {
  String title;
  bool isCompleted;

  Todo({required this.title, this.isCompleted = false});
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todoList = [];

  final TextEditingController _titleEditingController = TextEditingController();

  void _addTodo() {
    setState(() {
      String newTitle = _titleEditingController.text;
      _todoList.add(Todo(title: newTitle));
      _titleEditingController.clear();
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _toggleComplete(int index) {
    setState(() {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
    });
  }

  void _editTodoTitle(int index, String newTitle) {
    setState(() {
      _todoList[index].title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Todo List'),
      ),
      body: Container(
        color: Colors.black.withOpacity(0.1),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        fillColor: MaterialStateProperty.all(Colors.black),
                        checkColor: Colors.white,
                        value: _todoList[index].isCompleted,
                        onChanged: (_) => _toggleComplete(index),
                      ),
                      title: _todoList[index].isCompleted
                          ? Text(
                              _todoList[index].title,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : TextField(
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              controller: TextEditingController(
                                  text: _todoList[index].title),
                              onSubmitted: (newTitle) =>
                                  _editTodoTitle(index, newTitle),
                            ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onPressed: () => _deleteTodo(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.black,
                controller: _titleEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      )),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      )),
                  labelText: 'Add Todo',
                  labelStyle: const TextStyle(color: Colors.black),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTodo,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget controlTextField(int index) {
    if (_todoList[index].isCompleted) {
      return Text(_todoList[index].title,
          style: const TextStyle(
            decoration: TextDecoration.lineThrough,
          ));
    } else {
      return TextField(
        cursorColor: Colors.black,
        decoration: const InputDecoration(border: InputBorder.none),
        controller: TextEditingController(text: _todoList[index].title),
        onSubmitted: (newTitle) => _editTodoTitle(index, newTitle),
      );
    }
  }
}
