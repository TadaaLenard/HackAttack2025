import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/navigation/route.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final paddingval = 20.0;
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(paddingval, 100, paddingval, paddingval),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot password?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Don’t worry! It happens. Please enter the email associated with your account.',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: paddingval,
            ),
            LabeledTextField(
              label: 'Email',
              placeholder: 'example@gmail.com',
              controller: emailController,
            ),
            SizedBox(
              height: paddingval,
            ),
            SizedBox(
              height: paddingval,
            ),
            const GreenElevatedButton(
              text: 'Send code',
              navigateTo: AppRoutes.fpcode,
            ),
            SizedBox(
              height: paddingval,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Remember password?',
                style: TextStyle(),
              ),
              CustomTextButton(
                label: 'Log in',
                destinationRoute: AppRoutes.login,
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class Fpcode extends StatefulWidget {
  const Fpcode({super.key});

  @override
  State<Fpcode> createState() => _FpcodeState();
}

class _FpcodeState extends State<Fpcode> {
  final paddingval = 20.0;
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(paddingval, 100, paddingval, paddingval),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot password?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'We’ve sent a code to helloworld@gmail.com',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: paddingval,
            ),
            KeypadInputField(length: 4, controller: codeController),
            SizedBox(
              height: paddingval,
            ),
            SizedBox(
              height: paddingval,
            ),
            const GreenElevatedButton(
                text: 'Verify', navigateTo: AppRoutes.resetpassword),
            SizedBox(
              height: paddingval,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Send code again',
                style: TextStyle(),
              ),
              CustomTextButton(
                label: '00.00',
                destinationRoute: AppRoutes.login,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
