import 'package:flutter/material.dart';
import 'package:to_do_tasks/data/firebase-utils.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Todo",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "title",
                        labelStyle: Theme.of(context).textTheme.headline2),
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "please enter the title ";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "description",
                        labelStyle: Theme.of(context).textTheme.headline2),
                    onChanged: (text) {
                      description = text;
                    },
                    minLines: 4,
                    maxLines: 4,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "please enter the description ";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Text("date", style: Theme.of(context).textTheme.headline2),
            InkWell(
              onTap: () {
                showDateIndicator();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year} ",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTodo();
                  addTodoToFirebase(title, description, selectedDate).then(
                    (value) {
                      Navigator.pop(context);
                    },
                  ).onError((error, stackTrace) {
                    print(error);
                  }).timeout(Duration(seconds: 10), onTimeout: () {
                    //show can't connect to server}
                  });
                },
                child: Icon(Icons.add))
          ],
        ));
  }

  void addTodo() {
    //1- get title and description
    //2-select date
    //2-add to databade
    if (!formKey.currentState!.validate()) {
      return;
    }
    // if valid then insert to new todo item
  }

  void showDateIndicator() async {
    var newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (newSelectedDate != null) selectedDate = newSelectedDate;
    setState(() {});
  }
}
