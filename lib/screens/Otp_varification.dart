import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _otpController = TextEditingController();
  String? _otpError;

  @override
  void initState() {
    super.initState();

    // Add listener for real-time OTP validation
    _otpController.addListener(() {
      _validateOTP();
    });
  }

  // OTP validation
  void _validateOTP() {
    String otp = _otpController.text;
    RegExp otpRegEx = RegExp(r'^\d{6}$'); // 6-digit OTP

    setState(() {
      if (!otpRegEx.hasMatch(otp)) {
        _otpError = "OTP must be 6 digits!";
      } else {
        _otpError = null;
      }
    });
  }

  void _validateInput() {
    // Final validation when the button is pressed
    _validateOTP();

    // If OTP is valid, navigate to the login page
    if (_otpError == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Scientist image at the top
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/Login_page.png'),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 30),

                // "Enter OTP" text
                Text(
                  'Enter OTP',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // OTP input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      hintText: 'Enter OTP',
                      errorText: _otpError,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Submit button
                ElevatedButton(
                  onPressed: _validateInput,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    backgroundColor: Color(0xFF2FA0B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Submit',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
