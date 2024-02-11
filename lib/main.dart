import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CarbonFootprintCalculator(),
    debugShowCheckedModeBanner: false,
  ));
}

class CarbonFootprintCalculator extends StatefulWidget {
  @override
  _CarbonFootprintCalculatorState createState() =>
      _CarbonFootprintCalculatorState();
}

class _CarbonFootprintCalculatorState extends State<CarbonFootprintCalculator> {
  String _selectedMode = 'Car';
  double _distance = 0.0;
  double _result = 0.0;

  Map<String, double> _modeFactors = {
    'Car': 0.2, // CO2 emissions per mile for a car in kg
    'Bus': 0.1,
    'Train': 0.05,
    'Bike': 0.0,
  };

  void _calculateFootprint() {
    setState(() {
      _result = _distance * (_modeFactors[_selectedMode] ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Footprint Calculator'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Distance (miles)'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _distance = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Select Mode of Transport:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: _modeFactors.keys.map((String mode) {
                    return RadioListTile<String>(
                      title: Text(mode),
                      value: mode,
                      groupValue: _selectedMode,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedMode = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _calculateFootprint,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Carbon Footprint: $_result kg CO2',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}