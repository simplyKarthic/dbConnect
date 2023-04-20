import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _age;
  bool _hasAgreedToTerms = false;
  String _selectedGender;
  String _selectedCountry;

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('Name: $_name');
      print('Age: $_age');
      print('terms: $_hasAgreedToTerms');
      print('Gender: $_selectedGender');
      print('Country: $_selectedCountry');
      _clearForm();
    }
  }

  void _clearForm() {
    setState(() {
      _name = null;
      _age = null;
      _hasAgreedToTerms = false;
      _selectedGender = null;
      _selectedCountry = null;
    });
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value);
                },
              ),
              SizedBox(height: 16.0),
              CheckboxListTile(
                title: Text('I agree to the terms and conditions'),
                value: _hasAgreedToTerms,
                onChanged: (value) {
                  setState(() {
                    _hasAgreedToTerms = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Gender'),
              Row(
                children: [
                  Radio(
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Male'),
                  Radio(
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Country',
                  hintText: 'Select your country',
                ),
                value: _selectedCountry,
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'usa',
                    child: Text('USA'),
                  ),
                  DropdownMenuItem(
                    value: 'canada',
                    child: Text('Canada'),
                  ),
                  DropdownMenuItem(
                    value: 'uk',
                    child: Text('UK'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Please select your country';
                  }
                  return null;
                },
                onSaved: (value) {
                  _selectedCountry = value;
                },
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _clearForm, child: Text("Reset")),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(onPressed: _submitForm, child: Text("Submit"))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
