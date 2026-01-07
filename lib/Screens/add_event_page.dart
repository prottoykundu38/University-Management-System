import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';
  String date = '';
  String time = '';
  String? category; // Initially null
  bool notify = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _categories = ['CSE', 'ML', 'AI', 'Textile', 'SWE', 'Random'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF4A2A11)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        date = DateFormat('yyyy-MM-dd').format(picked);
        _dateController.text = date;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF4A2A11)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      time = DateFormat('hh:mm a').format(dt);
      _timeController.text = time;
    }
  }

  void resetForm() {
    setState(() {
      title = '';
      description = '';
      category = null;
      date = '';
      time = '';
      notify = false;
      _dateController.clear();
      _timeController.clear();
      _descriptionController.clear();
    });
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create Event',
          style: TextStyle(
            color: const Color.fromARGB(255, 63, 43, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/main_logo.png', height: 32),
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Rounds all four corners
          child: Container(color: const Color(0xFFD1A170)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Title', (value) => title = value),
                const SizedBox(height: 16),
                _buildCategoryDropdown(),
                const SizedBox(height: 16),
                _buildDateSelector(),
                const SizedBox(height: 16),
                _buildTimeSelector(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: notify,
                      activeColor: const Color(0xFF4A2A11),
                      onChanged: (bool? newValue) {
                        setState(() {
                          notify = newValue ?? false;
                        });
                      },
                    ),
                    const Text(
                      'Set Notification',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1A170),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle saving the event here

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Event Added Successfully!'),
                          ),
                        );
                        resetForm();
                      }
                    },
                    child: const Text(
                      'Add Event',
                      style: TextStyle(fontSize: 16, color: Color(0xFF4A2A11)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: const TextStyle(color: Color(0xFF4A2A11)),
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF4A2A11)),
        ),
      ),
      onChanged: onChanged,
      validator: (value) => value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: category,
      hint: const Text('Select Category'),
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(color: Color(0xFF4A2A11)),
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF4A2A11)),
        ),
      ),
      items: _categories
          .map((String cat) => DropdownMenuItem(value: cat, child: Text(cat)))
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          category = newValue;
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Please select a category' : null,
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _dateController,
          decoration: InputDecoration(
            labelText: 'Select Date',
            floatingLabelStyle: const TextStyle(color: Color(0xFF4A2A11)),
            filled: true,
            fillColor: Colors.black12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF4A2A11)),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Please select a date' : null,
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _timeController,
          decoration: InputDecoration(
            labelText: 'Select Time',
            floatingLabelStyle: const TextStyle(color: Color(0xFF4A2A11)),
            filled: true,
            fillColor: Colors.black12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF4A2A11)),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Please select a time' : null,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 5,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        labelText: 'Description',
        alignLabelWithHint: true,
        floatingLabelStyle: const TextStyle(color: Color(0xFF4A2A11)),
        filled: true,
        fillColor: Colors.black12,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF4A2A11)),
        ),
      ),
      onChanged: (value) => description = value,
      validator: (value) => value == null || value.isEmpty ? 'Enter Description' : null,
    );
  }
}
