import 'package:flutter/material.dart';
import 'package:todo/add_tasks_screen.dart';
import 'package:todo/menu-drawer.dart';
import 'package:todo/navigation-bar.dart';

class AllTaskScreen extends StatefulWidget {
  @override
  _AllTaskScreenState createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  List<Map<String, String>> _todoItems = [];

  void _addTodoItem(String title, String priority, String completeBy) {
    setState(() {
      _todoItems.add({
        'title': title,
        'priority': priority,
        'completeBy': completeBy,
      });
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _searchTodoItems(String query) {
    // Implement search logic here
    // For simplicity, let's filter tasks by title containing the query
    setState(() {
      _todoItems =
          _todoItems.where((task) => task['title']!.contains(query)).toList();
    });
  }

  void _sortTodoItemsByPriority() {
    setState(() {
      _todoItems.sort((a, b) {
        return _priorityToInt(a['priority']!)
            .compareTo(_priorityToInt(b['priority']!));
      });
    });
  }

  int _priorityToInt(String priority) {
    switch (priority) {
      case 'High':
        return 0;
      case 'Medium':
        return 1;
      case 'Low':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    _sortTodoItemsByPriority(); // Sort the todo items by priority
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Tasks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 35, 8, 78),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              // Implement search functionality
              showSearch(
                context: context,
                delegate: SearchBarDelegate(items: _todoItems),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _todoItems.length,
          itemBuilder: (context, index) {
            final task = _todoItems[index];
            return Dismissible(
              key: Key(task['title']!),
              onDismissed: (direction) {
                _deleteTodoItem(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(task['title']!),
                subtitle: Text(
                    'Priority: ${task['priority']!}\nComplete By: ${task['completeBy']!}'),
                onTap: () {
                  // Handle tapping on the task item (if needed)
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTasksScreen()),
          );
          if (newTask != null) {
            _addTodoItem(
              newTask['title']!,
              newTask['priority']!,
              newTask['completeBy']!,
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> items;

  SearchBarDelegate({required this.items});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<Map<String, String>> filteredItems = items
        .where((item) =>
            item['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final task = filteredItems[index];
        return ListTile(
          title: Text(task['title']!),
          subtitle: Text(
              'Priority: ${task['priority']!}\nComplete By: ${task['completeBy']!}'),
          onTap: () {
            close(context, task['title']!);
          },
        );
      },
    );
  }
}
