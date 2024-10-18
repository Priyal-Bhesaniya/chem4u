import 'package:flutter/material.dart';
import 'dart:async'; // Needed for countdown

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}):super(key: key);
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController _otpController = TextEditingController();
  String? _otpError;
  bool _isResendEnabled = true; // A flag to enable/disable the Resend button
  int _resendCooldown = 30; // Cooldown time for resend (in seconds)
  Timer? _timer; // Timer for the cooldown countdown

  // Validate OTP in real-time (assuming a 6-digit OTP)
  void _validateOTP() {
    String otp = _otpController.text;
    RegExp otpRegEx = RegExp(r'^\d{6}$'); // OTP must be 6 digits

    setState(() {
      if (!otpRegEx.hasMatch(otp)) {
        _otpError = "OTP must be 6 digits!";
      } else {
        _otpError = null;
      }
    });
  }

  void _validateInput() {
    // Final validation when submit button is pressed
    _validateOTP();

    // Proceed only if there are no errors
    if (_otpError == null) {
      // Perform OTP verification action after validation
      print('OTP is valid: ${_otpController.text}');
    }
  }

  void _resendOtp() {
    setState(() {
      _isResendEnabled = false;
      _resendCooldown = 30; // Reset cooldown
    });
    print('OTP Resent');

    // Start a countdown for the resend button
    _startCooldownTimer();
  }

  // Timer to handle the countdown for resend OTP
  void _startCooldownTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCooldown > 0) {
          _resendCooldown--;
        } else {
          _isResendEnabled = true;
          _timer?.cancel(); // Stop the timer
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // OTP TextField
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 104, 181, 198),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _validateOTP(),
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    errorText: _otpError, // Display error message if invalid OTP
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _otpError == null ? Colors.transparent : Colors.red,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Submit Button (Validate OTP)
              Container(
                width: 290,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateInput,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2FA0B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit OTP',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Resend OTP Button
              TextButton(
                onPressed: _isResendEnabled ? _resendOtp : null, // Disable the button if on cooldown
                child: Text(
                  _isResendEnabled
                      ? 'Resend OTP'
                      : 'Resend available in $_resendCooldown seconds',
                  style: TextStyle(
                    fontSize: 16,
                    color: _isResendEnabled ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
