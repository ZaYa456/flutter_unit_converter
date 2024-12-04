import 'package:flutter/material.dart';

Widget inputSection({
  required String selectedUnit,
  required List<String> units,
  required Function(String?) onUnitChanged,
  required Function(String?) onValueChanged,
  required TextEditingController controller,
  required int decimalPlaces,
  required List<int> decimalOptions,
  required Function(int?) onDecimalPlacesChanged,
}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DropdownButton<String>(
                value: selectedUnit,
                isExpanded:
                    true, // Allow the dropdown to use the full available width
                onChanged: onUnitChanged,
                items: units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: DropdownButton<int>(
                value: decimalPlaces,
                isExpanded: true,
                items: decimalOptions.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value Decimal Place${value > 1 ? 's' : ''}'),
                  );
                }).toList(),
                onChanged: onDecimalPlacesChanged,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Enter value'),
          onChanged: onValueChanged,
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}
