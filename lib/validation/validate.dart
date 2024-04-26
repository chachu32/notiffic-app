import 'package:flutter/material.dart';

class PinPage extends StatefulWidget {
  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  TextEditingController _pinController = TextEditingController();

  String _errorMessage = '';

  // Replace this with your correct PIN
 final String _correctPin = '0000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter PIN',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
             const SizedBox(height: 10),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
             const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_pinController.text == _correctPin) {
                    Navigator.pushReplacementNamed(context, '/upload');
                  } else {
                    setState(() {
                      _errorMessage = 'Incorrect PIN. Please try again.';
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
