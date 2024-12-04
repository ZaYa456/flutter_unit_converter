import 'package:flutter/material.dart';
import '/components/other/input_section.dart';

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  TextEditingController _fromController = TextEditingController();

  // The following variable is for the decimal parts of the conversion results in the ListView
  int _decimalPlaces = 2;
  final List<int> _decimalOptions = [1, 2, 3, 4, 5];

  String _fromUnit = 'C';

  // This map works like the "if else if" logic
  final Map<String, Map<String, double Function(double)>> _conversionFunctions =
      {
    'C': {
      'C': (value) => value,
      'F': (value) => (value * 9 / 5) + 32,
      'K': (value) => value + 273.15,
    },
    'F': {
      'C': (value) => (value - 32) * 5 / 9,
      'F': (value) => value,
      'K': (value) => ((value - 32) * 5 / 9) + 273.15,
    },
    'K': {
      'C': (value) => value - 273.15,
      'F': (value) => ((value - 273.15) * 9 / 5) + 32,
      'K': (value) => value,
    },
  };

  Map<String, double> _convertValues(String value) {
    double inputValue = double.tryParse(value) ?? 0.0;

    // Check if _fromUnit is valid
    if (!_conversionFunctions.containsKey(_fromUnit)) {
      throw Exception('Invalid fromUnit');
    }

    // Retrieve the appropriate conversion map for the selected _fromUnit
    final conversionMap = _conversionFunctions[_fromUnit];

    if (conversionMap == null) {
      throw Exception("No conversion functions available for unit: $_fromUnit");
    }

    // Convert input value to all target units
    return conversionMap.map((unit, func) {
      return MapEntry(unit, func(inputValue));
    });
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
            units: _conversionFunctions.keys.toList(),
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
              children: _conversionFunctions.keys.map((unit) {
                String formula = '';
                if (_fromUnit != unit) {
                  if (_fromUnit == 'C') {
                    if (unit == 'F') {
                      formula = '(0C * 9/5) + 32 = 32F)';
                    } else if (unit == 'K') {
                      formula = '(0C + 273.15 = 273.15K)';
                    }
                  } else if (_fromUnit == 'F') {
                    if (unit == 'C') {
                      formula = '(0F - 32) * 5/9 = -17.78C)';
                    } else if (unit == 'K') {
                      formula = '(0F - 32) * 5/9) + 273.15 = 255.372K)';
                    }
                  } else if (_fromUnit == 'K') {
                    if (unit == 'C') {
                      formula = '(0K - 273.15 = -273.1C)';
                    } else if (unit == 'F') {
                      formula = '(0K - 273.15) * 9/5 + 32 = -459.7F)';
                    }
                  }
                }
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
