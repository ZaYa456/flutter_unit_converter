import 'package:flutter/material.dart';
import '/components/other/input_section.dart';

class TimeConverter extends StatefulWidget {
  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  TextEditingController _fromController = TextEditingController();
  // The following variable is for the decimal parts of the conversion results in the ListView
  int _decimalPlaces = 2;
  final List<int> _decimalOptions = [1, 2, 3, 4, 5];

  String _fromUnit = 'seconds';
  final Map<String, double> _unitMultiplier = {
    'seconds': 1.0,
    'minutes': 60.0,
    'hours': 3600.0,
  };

  Map<String, double> _convertValues(String value) {
    double inputValue = double.tryParse(value) ?? 0.0;
    double baseValue = inputValue * (_unitMultiplier[_fromUnit] ?? 1.0);
    return _unitMultiplier
        .map((unit, multiplier) => MapEntry(unit, baseValue / multiplier));
  }

  @override
  void dispose() {
    _fromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> convertedValues = _convertValues(_fromController.text);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputSection(
            selectedUnit: _fromUnit,
            units: _unitMultiplier.keys.toList(),
            onUnitChanged: (newValue) {
              setState(() {
                _fromUnit = newValue ?? _fromUnit;
              });
            },
            controller: _fromController,
            onValueChanged: (value) {
              setState(() {});
            },
            decimalPlaces: _decimalPlaces,
            decimalOptions: _decimalOptions,
            onDecimalPlacesChanged: (newValue) {
              setState(() {
                _decimalPlaces = newValue ?? _decimalPlaces;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: _unitMultiplier.keys.map((unit) {
                String formula = _fromUnit == unit
                    ? ''
                    : '(1 $_fromUnit = ${(_unitMultiplier[_fromUnit]! / _unitMultiplier[unit]!).toStringAsFixed(_decimalPlaces)} $unit)';
                return ListTile(
                  title: Text('$unit'),
                  subtitle: Text(
                      '${convertedValues[unit]!.toStringAsFixed(_decimalPlaces)} $formula'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
