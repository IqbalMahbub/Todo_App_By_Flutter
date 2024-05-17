import 'package:flutter/material.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(task: task, isDone: false));
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].isDone = !_todoItems[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        leading: Icon(Icons.home),
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 30,
              children: [
                Text(_todoItems[index].task),
                ElevatedButton(onPressed: (){
                  _removeTodoItem(index);
                }, child: Icon(Icons.delete))
              ]

            ),
            value: _todoItems[index].isDone,
            onChanged: (bool? isChecked) {
              _toggleTodoItem(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _promptAddTodoItem(context);
        },
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _promptAddTodoItem(BuildContext context) {
    String task = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new task'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              task = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                _addTodoItem(task);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class TodoItem {
  String task;
  bool isDone;

  TodoItem({required this.task, required this.isDone});
}
