import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedCategory;
  final String? taskName;
  final String? description;

  EditPage({
    this.startDate,
    this.endDate,
    this.selectedCategory,
    this.taskName,
    this.description,
  });

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCategory;
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisez les contrôleurs et les variables avec les valeurs fournies
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    _selectedCategory = widget.selectedCategory;
    _taskNameController.text = widget.taskName ?? '';
    _descriptionController.text = widget.description ?? '';
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la tâche'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for date selection buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context, true),
                  child: Text(_startDate == null
                      ? 'Date début'
                      : DateFormat.yMd().format(_startDate!)),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context, false),
                  child: Text(_endDate == null
                      ? 'Date fin'
                      : DateFormat.yMd().format(_endDate!)),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Row for category selection
            Wrap(
              spacing: 16.0,
              children: ['Travail', 'Loisirs', 'Idée']
                  .map(
                    (category) => ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),
            // Task name input field
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(labelText: 'Nom de la tâche'),
            ),
            SizedBox(height: 16),
            // Task description input field
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description de la tâche'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            // Save task button
            ElevatedButton(
              onPressed: () {
                // Logique pour sauvegarder les modifications
                Navigator.pop(
                    context); // Remplacer par la navigation vers la liste des tâches
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
