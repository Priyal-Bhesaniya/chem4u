import 'package:chemlab_flutter_project/Controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String? _otpError;
  bool _isResendEnabled = true; // A flag to enable/disable the Resend button
  int _resendCooldown = 30; // Cooldown time for resend (in seconds)
  Timer? _timer; // Timer for the cooldown countdown
  String otp = ""; // Variable to store OTP input

  // Validate OTP in real-time (assuming a 6-digit OTP)
  void _validateOTP(String otpInput) {
    RegExp otpRegEx = RegExp(r'^\d{6}$'); // OTP must be 6 digits

    setState(() {
      if (!otpRegEx.hasMatch(otpInput)) {
        _otpError = "OTP must be 6 digits!";
      } else {
        _otpError = null;
      }
    });
  }

  void _validateInput() {
    if (otp.isEmpty || otp.length != 6) {
      setState(() {
        _otpError = "Please enter a valid 6-digit OTP!";
      });
      return;
    }

    if (_otpError == null) {
      OtpController.instance.verifyOTP(otp); // Call OTP verification logic
      print('OTP is valid: $otp');
    } else {
      print('Invalid OTP');
    }
  }

  void _resendOtp() {
    if (_isResendEnabled) { // Ensure button is enabled before resending
      setState(() {
        _isResendEnabled = false;
        _resendCooldown = 30; // Reset cooldown
        _otpError = null; // Clear any previous error
      });
      print('OTP Resent');

      // Start a countdown for the resend button
      _startCooldownTimer();
    }
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
              SizedBox(height: 30),
              // OtpTextField (for entering OTP)
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onCodeChanged: (code) {
                  _validateOTP(code); // Validate OTP as the user types
                },
                onSubmit: (code) {
                  otp = code; // Store the OTP entered
                  _validateOTP(otp); // Final validation on submission
                  _validateInput(); // Proceed with OTP verification
                  print('OTP from OtpTextField: $otp');
                },
              ),
              if (_otpError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _otpError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 30),
              // Submit Button (Validate OTP)
              Container(
                width: 290,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateInput, // Button press to validate and submit OTP
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
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
