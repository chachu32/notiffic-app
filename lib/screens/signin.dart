import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to login page after successful signup
      Navigator.pushReplacementNamed(context, '/login');
     // print('Successfully signed up: ${userCredential.user!.uid}');
      _showSuccessDialog(); // Show dialog on successful signup
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       // print('The password provided is too weak.');
        _showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
       // print('The account already exists for that email.');
        _showSnackBar('The account already exists for that email.');
      }
    } catch (e) {
     // print('Failed to sign up: $e');
      _showSnackBar('Failed to sign up: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signup Successful'),
          content: const Text('You have successfully signed up!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }
   void _navigateToLoginPageA() {
    Navigator.pushReplacementNamed(context, '/Alogin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Sign Up',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255,67,91,91),
      ),
      body: Container(
         decoration:const BoxDecoration(
    image: DecorationImage(
      image: NetworkImage('https://e1.pxfuel.com/desktop-wallpaper/345/300/desktop-wallpaper-100-indian-police-indian-police-officer.jpg'),
      fit: BoxFit.cover,
    ),
  ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                 TextField(
                decoration:  InputDecoration(labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                
        borderSide: const BorderSide(
         // Set the border color
          width: 4.0, // Increase the border thickness
        ),
         borderRadius: BorderRadius.circular(10.0), // Set border radius
            ),),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration:  InputDecoration(labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
         // Set the border color
          width: 4.0, // Increase the border thickness
        ),
         borderRadius: BorderRadius.circular(10.0), // Set border radius
            ),),
                
              ),
             const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration:  InputDecoration(labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
                
                border: OutlineInputBorder(
                
        borderSide: const BorderSide(
          color: Colors.white,
         // Set the border color
          width: 4.0, // Increase the border thickness
        ),
         borderRadius: BorderRadius.circular(10.0), // Set border radius
            ),),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text('Sign Up'),
              ),
             const SizedBox(height: 16.0),
              TextButton(
                onPressed: _navigateToLoginPage,
                child: const Text('Already a member? Login here',style: TextStyle(color: Colors.white),),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
