import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Decllaring hive boxe
  late Box taskBox;
  late Box pointsBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('tasks');
    pointsBox = Hive.box('points');

    // If Hive box is empty, add default tasks
    if (taskBox.isEmpty) {
      taskBox.putAll({
        0: {'task': 'Plant a tree', 'completed': false},
        1: {'task': 'Pick up litter', 'completed': false},
        2: {'task': 'Conserve water for a day', 'completed': false},
      });
    }

    // Initialize points if not stored
    if (!pointsBox.containsKey('points')) {
      pointsBox.put('points', 0);
    }
  }

  int get points => pointsBox.get('points', defaultValue: 0);

  void completeTask(int index) {
    final task = taskBox.get(index);
    if (!task['completed']) {
      taskBox.put(index, {'task': task['task'], 'completed': true});
      pointsBox.put('points', points + 10);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade300,
              const Color.fromARGB(255, 79, 218, 102),
            ],
            stops: [0.1, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Image.asset(
                      "assets/babyEarth.png",
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "BabyEarth",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: pointsBox.listenable(),
                    builder: (context, Box box, _) {
                      return Text(
                        "Points: ${box.get('points', defaultValue: 0)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: taskBox.listenable(),
                builder: (context, Box box, _) {
                  if (box.isEmpty) {
                    return Center(
                        child: Text("No tasks available",
                            style: TextStyle(color: Colors.white)));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final task = box.get(index);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 16),
                        child: ListTile(
                          title: Text(
                            task['task'],
                            style: TextStyle(
                              decoration: task['completed']
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Checkbox(
                            value: task['completed'],
                            onChanged: (value) {
                              completeTask(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
