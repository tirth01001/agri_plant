import 'package:agriplant/main.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EditLocationScreen extends StatefulWidget {
  @override
  _EditLocationScreenState createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  // Controllers for each form field
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController(text: globalUserAccount.userAddress[0]);
  final _cityController = TextEditingController(text: globalUserAccount.userAddress[1]);
  final _stateController = TextEditingController(text: globalUserAccount.userAddress[2]);
  final _zipCodeController = TextEditingController(text: globalUserAccount.userAddress[3]);
  final _countryController = TextEditingController(text: globalUserAccount.userAddress[4]);

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process form data
      print('Street: ${_streetController.text}');
      print('City: ${_cityController.text}');
      print('State: ${_stateController.text}');
      print('Zip Code: ${_zipCodeController.text}');
      print('Country: ${_countryController.text}');
      // You can now save this data or update it to a database
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location Updated!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Street Name TextField
                
                InputForm(
                  controller: _streetController,
                  hint: 'Street Address', 
                  prefix: Icon(IconlyLight.location),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the street address';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 20),

                // City TextField
                InputForm(
                  controller: _cityController,
                  hint: 'City',
                  prefix: Icon(Icons.location_city),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 20),

                // State TextField
                InputForm(
                  controller: _stateController,
                  hint: 'State',
                  prefix: Icon(Icons.flag),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the state';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 20),

                // Zip Code TextField
                InputForm(
                  controller: _zipCodeController,
                  hint: 'Zip Code',
                  prefix: Icon(Icons.code),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the zip code';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 20),

                // Country TextField
                InputForm(
                  controller: _countryController,
                  hint: 'Country',
                  prefix: Icon(Icons.public),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),

                // Submit Button
                SizedBox(
                  width: maxW-40,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      // primary: Colors.blueAccent,
                    ),
                    child: const Text('Update Location'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditLocationScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
