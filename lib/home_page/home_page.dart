import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/home_page/task_create_modal.dart';
import 'package:task_manager/home_page/task_state.dart';
import 'appbar.dart';
import 'categories.dart';
import 'task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categories = [];
  final Map<String, List<TaskState>> _tasks = {};
  String currentCategory = '';
  bool isModalOpen = false; //なぜかボタンが被ってしまうので、モーダルが開いているかどうかを管理する

  @override
  void initState() {
    super.initState();
    _addCategory('やること');
    currentCategory = _categories[0];
  }

  // カテゴリーを追加する
  void _addCategory(String category) {
    setState(() {
      _categories.add(category);
      _tasks[category] = [];
    });
  }

  // タスクを追加する
  void _addTask(TaskState task) {
    setState(() {
      _tasks[currentCategory]!.add(task);
    });
  }

  // タスクの選択状態を変更する
  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[currentCategory]![index].isDone =
          !_tasks[currentCategory]![index].isDone;
    });
  }

  // 選択されているカテゴリーを変更する
  void _changeCategory(String category) {
    setState(() {
      currentCategory = category;
    });
  }

  // チェックがついたタスクを削除する
  void _deleteTask() {
    setState(() {
      for (int i = 0; i < _tasks[currentCategory]!.length; i++) {
        if (_tasks[currentCategory]![i].isDone) {
          _tasks[currentCategory]!.removeAt(i);
          i--; //要素が一つ消えるので、インデックスを一つ戻す
        }
      }
    });
  }

  void _showTaskCreateModal(BuildContext context) {
    if (isModalOpen) return;
    setState(() {
      isModalOpen = true;
    });
    try {
      showModalBottomSheet(
        context: context,
        backgroundColor: Color.fromARGB(223, 0, 0, 0),
        builder: (BuildContext context) {
          return Column(children: [
            const Spacer(),
            // 画面の下半分に表示
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: TaskCreateModal(
                addTask: _addTask,
              ),
            ),
          ]);
        },
      ).then((_) => setState(() {
            isModalOpen = false;
          }));
    } catch (e) {
      debugPrint(e.toString());
    }
    // final colorScheme = Theme.of(context).colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    final colorSchene = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const AppBarWidget()),
      body: Stack(children: [
        Center(
          child: Column(
            children: [
              Categories(
                categories: _categories,
                changeCategory: _changeCategory,
                addCategory: _addCategory,
              ),
              Expanded(
                child: TaskList(
                  tasks: _tasks[currentCategory] ?? [],
                  toggleSelected: _toggleTaskStatus,
                ),
              ),
            ],
          ),
        ),
        if (!isModalOpen)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => _showTaskCreateModal(context),
              backgroundColor: colorSchene.secondary,
              child: Icon(
                Icons.add,
                color: colorSchene.primary,
              ),
            ),
          ),
        if (!isModalOpen)
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () => _deleteTask(),
              backgroundColor: colorSchene.secondary,
              child: Icon(
                Icons.delete,
                color: colorSchene.primary,
              ),
            ),
          ),
      ]),
    );
  }
}
