import 'package:flutter/material.dart';

String? selectedUniversity;
String? selectedDate;
String? selectedCategory;

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? tempUniversity = selectedUniversity;
  String? tempDate = selectedDate;
  String? tempCategory = selectedCategory;

  bool get isFilterSelected =>
      tempUniversity != selectedUniversity ||
      tempDate != selectedDate ||
      tempCategory != selectedCategory;

  bool get isResetSelectable =>
      tempUniversity != null || tempDate != null || tempCategory != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Adjust the radius as needed
          ),
          child: AppBar(
            title: const Text('Filter Events'),
            backgroundColor: Color(0xFFD1A170),
            elevation: 0,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: tempUniversity,
              hint: const Text('Select University'),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  tempUniversity = newValue;
                });
              },
              items:
                  <String>[
                    'All Universities',
                    'AUST',
                    'DIU',
                    'UIU',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: tempDate,
              hint: const Text('Select Date'),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  tempDate = newValue;
                });
              },
              items:
                  <String>[
                    'All Dates',
                    '2025-04-10',
                    '2025-04-15',
                    '2025-04-20',
                    '2025-04-25',
                    '2025-04-30',
                    '2025-05-05',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: tempCategory,
              hint: const Text('Select Category'),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  tempCategory = newValue;
                });
              },
              items:
                  <String>[
                    'All Categories',
                    'Job Fair',
                    'Research',
                    'Tour',
                    'Contest',
                    'Workshop',
                    'Career',
                    'Design',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        isFilterSelected
                            ? () {
                              setState(() {
                                selectedUniversity = tempUniversity;
                                selectedDate = tempDate;
                                selectedCategory = tempCategory;
                              });
                              Navigator.pop(context); // optional, to go back

                              // Navigator.pop(context, {
                              //   'university': selectedUniversity,
                              //   'date': selectedDate,
                              //   'category': selectedCategory,
                              // });
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD1A170),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(
                        color:
                            isFilterSelected ? Colors.white : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        isResetSelectable
                            ? () {
                              setState(() {
                                tempUniversity = null;
                                tempDate = null;
                                tempCategory = null;

                                selectedUniversity = null;
                                selectedDate = null;
                                selectedCategory = null;
                              });
                              Navigator.pop(context); // optional, to go back
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isResetSelectable
                              ? const Color.fromARGB(255, 179, 39, 29)
                              : Colors.grey[400],
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color:
                            isResetSelectable ? Colors.white : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
