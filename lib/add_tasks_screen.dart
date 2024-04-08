import 'package:flutter/material.dart';
import 'package:todo/menu-drawer.dart';
import 'package:todo/navigation-bar.dart';

class AddTasksScreen extends StatefulWidget {
  @override
  _AddTasksScreenState createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  final TextEditingController _titleController = TextEditingController();
  final ValueNotifier<String> _selectedPriority = ValueNotifier<String>('High');
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Tasks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 35, 8, 78),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedPriority.value,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: ['High', 'Medium', 'Low']
                  .map((priority) => DropdownMenuItem(
                        child: Text(priority),
                        value: priority,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority.value = value!;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Complete By',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                    }
                  },
                ),
              ),
              onTap: () {}, // to prevent keyboard from showing up
              controller: TextEditingController(
                text: _selectedDate != null
                    ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                    : '',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text;
                // Pass data back to the previous screen
                Navigator.pop(context, {
                  'title': title,
                  'priority': _selectedPriority.value,
                  'completeBy':
                      _selectedDate != null ? _selectedDate.toString() : '',
                });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}