import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/Service/Auth.service.dart';

import 'main.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

int start = 30;
bool wait = false;
String buttonname = 'Send';
bool circular = false;
TextEditingController phoneController = TextEditingController();
AuthClass authClass = AuthClass();
String verificationidFinal = '';
String smscode = '';

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 143, 59, 72),
        title: const Text("SIGNUP"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFB76E79),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              textfield(context, 'Enter Your Phone Number'),
              const SizedBox(
                height: 30,
              ),
              // textfield(context, ''),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: const Color(0xFFF0BBC3),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    )),
                    const Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(fontSize: 15, color: Color(0xFFF0BBC3)),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: const Color(0xFFF0BBC3),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    )),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              otpfield(context),
              const SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(fontSize: 15, color: Color(0xFFF0BBC3)),
                ),
                TextSpan(
                  text: "00:$start",
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFFF0BBC3)),
                ),
                const TextSpan(
                  text: " sec",
                  style: TextStyle(fontSize: 15, color: Color(0xFFF0BBC3)),
                )
              ])),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () async {
                  authClass.signInwithPhoneNumber(
                      context, verificationidFinal, smscode);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool(SAVE_KEY, true);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 231, 144, 157),
                          Color.fromARGB(255, 158, 73, 86),
                        ],
                      )),
                  child: Center(
                    child: circular
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Verify',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void starttimer() {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpfield(BuildContext context) {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 30,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: const Color(0xFFF0BBC3),
        borderColor: Colors.white,
      ),
      style: const TextStyle(
        fontSize: 17,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smscode = pin;
        });
      },
    );
  }

  Widget textfield(BuildContext context, String labeltext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: phoneController,
        cursorColor: const Color.fromARGB(255, 143, 59, 72),
        decoration: InputDecoration(
            labelText: labeltext,
            labelStyle: const TextStyle(fontSize: 17, color: Color(0xFFF0BBC3)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Color.fromARGB(255, 143, 59, 72),
              ),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              child: Text(
                '(+91)',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () async {
                      starttimer();
                      setState(() {
                        start = 30;
                        wait = true;
                        buttonname = 'Resend';
                      });
                      await authClass.verifyPhone(
                          '+91${phoneController.text}', context, setData);
                    },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
                child: Text(
                  buttonname,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: wait
                          ? const Color.fromARGB(255, 187, 183, 183)
                          : Colors.black),
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xFFF0BBC3)))),
      ),
    );
  }

  void setData(verificationid) {
    setState(() {
      verificationidFinal = verificationid;
    });
    starttimer();
  }
}
