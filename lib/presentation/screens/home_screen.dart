import 'package:flutter/material.dart';
import 'package:to_do_tasks/constants/my_themes.dart';
import 'package:to_do_tasks/presentation/screens/settings_tab.dart';
import 'package:to_do_tasks/presentation/screens/task_tab.dart';
import 'package:to_do_tasks/presentation/widgets/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("To do "),
        centerTitle: false,
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        child: Icon(Icons.add),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        onPressed: () {
          addTask();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Screens[currentIndex],
    );
  }

  void addTask() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddTask();
        });
  }

  List<Widget> Screens = [
    TaskTap(),
    SettingsTap(),
  ];
}
