import 'package:flutter/material.dart';
import 'components/converters/temperature_converter.dart';
import 'components/converters/time_converter.dart';
import 'components/converters/weight_converter.dart';
import 'components/converters/length_converter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Length'),
            Tab(text: 'Weight'),
            Tab(text: 'Temperature'),
            Tab(text: 'Time'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LengthConverter(),
          WeightConverter(),
          TemperatureConverter(),
          TimeConverter(),
        ],
      ),
    );
  }
}
