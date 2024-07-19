import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String taskText;
  final Function onDelete;

  TaskItem({required this.taskText, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taskText),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete this task?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),),
                TextButton(
                  onPressed: () {
                    onDelete();
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(taskText),
      ),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<String> tasks = ['Task 1', 'Task 2', 'Task 3'];

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(
            taskText: tasks[index],
            onDelete: () => _deleteTask(index),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TaskListScreen(),
  ));
}