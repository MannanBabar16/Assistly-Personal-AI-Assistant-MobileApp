import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true; // To toggle password visibility

  signInWithEmailAndPassword()async{

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user not found");
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found for that email"),),);

      } else if (e.code == 'wrong-password') {
        print("wrong password");
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Wrong password provided for that user"),),);

      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView( // To prevent overflow when keyboard appears
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40), // Horizontal padding
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center all content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center all content horizontally
                children: [
                  // App Name
                  Text(
                    'Assistly',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // Space between app name and heading

                  // Login Heading
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40), // Space between heading and input fields

                  // Email Field
                  TextFormField(
                    controller: _email,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Email is empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Email",
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Space between fields

                  // Password Field
                  TextFormField(
                    controller: _password,
                    obscureText: _obscureText, // Toggle password visibility
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Password is empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText; // Toggle the obscure text
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Space before the login button

                  // Login Button
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signInWithEmailAndPassword();
                          print("Validation is done");

                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 20), // Space before the signup button

                  // Text Button for Signup
                  TextButton(
                    onPressed: () {
                      // Navigate to the Signup page
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
