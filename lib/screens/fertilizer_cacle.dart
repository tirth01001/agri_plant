import 'package:agriplant/main.dart';
import 'package:agriplant/widgets/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FertilizerCalculatorScreen(),
  ));
}

class FertilizerCalculatorScreen extends StatefulWidget {
  @override
  _FertilizerCalculatorScreenState createState() => _FertilizerCalculatorScreenState();
}

class _FertilizerCalculatorScreenState extends State<FertilizerCalculatorScreen> {
  final TextEditingController _areaController = TextEditingController();
  String _selectedCrop = 'Wheat';
  String _selectedFertilizer = 'Urea';
  double _requiredFertilizer = 0.0;

  final Map<String, double> fertilizerRates = {
    'Urea': 100,
    'DAP': 50,
    'NPK': 70,
    'Potash': 40,
    'Zinc Sulfate': 10,
  };

  final List<String> crops = [
    'Wheat', 'Rice', 'Corn', 'Sugarcane', 'Soybean', 'Cotton', 'Barley', 'Tomato'
  ];

  void calculateFertilizer() {
    double area = double.tryParse(_areaController.text) ?? 0.0;
    double rate = fertilizerRates[_selectedFertilizer] ?? 0.0;
    setState(() {
      _requiredFertilizer = area * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fertilizer Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Crop", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade300
                  )
                ),
                child: DropdownButton<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  borderRadius: BorderRadius.circular(8),
                  underline: const SizedBox(),
                  value: _selectedCrop,
                  onChanged: (value) {
                    setState(() {
                      _selectedCrop = value!;
                    });
                  },
                  items: crops.map((crop) {
                    return DropdownMenuItem(value: crop, child: Text(crop));
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              Text("Enter Land Area (Hectares)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              InputForm(
                controller: _areaController,
                keyboardType: TextInputType.number,
                hint: "Enter area in hectares",
                padding: const EdgeInsets.only(),
              ),
              SizedBox(height: 16),
              Text("Select Fertilizer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade300
                  )
                ),
                child: DropdownButton<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  borderRadius: BorderRadius.circular(8),
                  underline: const SizedBox(),
                  value: _selectedFertilizer,
                  onChanged: (value) {
                    setState(() {
                      _selectedFertilizer = value!;
                    });
                  },
                  items: fertilizerRates.keys.map((fertilizer) {
                    return DropdownMenuItem(value: fertilizer, child: Text(fertilizer));
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: maxW-40,
                child: ElevatedButton(
                  onPressed: calculateFertilizer,
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.green,
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  // ),
                  child: Text("Calculate", style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Required Fertilizer: $_requiredFertilizer kg",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                ),
              ),
              SizedBox(height: 20),
              Text("Fertilizer Recommendations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("- Urea: Nitrogen-rich fertilizer for leaf growth"),
              Text("- DAP: Good for root development"),
              Text("- NPK: Balanced mix for overall crop growth"),
              Text("- Potash: Improves disease resistance"),
              Text("- Zinc Sulfate: Helps in plant enzyme function"),
            ],
          ),
        ),
      ),
    );
  }
}