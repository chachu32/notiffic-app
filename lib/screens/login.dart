import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (_rememberMe) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
        prefs.setBool('rememberMe', _rememberMe);
      }

      // Navigate to another screen after successful login
      Navigator.pushReplacementNamed(context, '/valid');
      print('Successfully logged in: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      // Handle login errors
    } catch (e) {
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 91, 91),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://e1.pxfuel.com/desktop-wallpaper/345/300/desktop-wallpaper-100-indian-police-indian-police-officer.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 238, 220, 211)),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 238, 220, 211)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  Text('Remember Me',style: TextStyle(color: Colors.white),),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('New member? Sign up here',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
