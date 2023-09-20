import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories(
      {super.key,
      required this.categories,
      required this.changeCategory,
      required this.addCategory});
  final List<String> categories;
  final void Function(String category) changeCategory;
  final void Function(String category) addCategory;

  @override
  State<StatefulWidget> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.categories[0];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.2),
            width: 1.0,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            for (var category in widget.categories)
              Container(
                  decoration: category == _selectedCategory
                      ? BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: colorScheme.primary, // 下線の色
                              width: 2.0, // 下線の太さ
                            ),
                          ),
                        )
                      : null,
                  child: TextButton(
                    onPressed: () {
                      widget.changeCategory(category);
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Text(
                      category,
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  )),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddCategoryDialog();
              },
            ),
          ]),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('カテゴリーの追加'),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                widget.addCategory(value);
                Navigator.pop(context);
              },
            ),
          );
        });
  }
}
