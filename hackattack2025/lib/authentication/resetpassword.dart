import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/navigation/route.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final paddingval = 20.0;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                'Reset password',
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
                'Please type something you’ll remember.',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: paddingval,
            ),
            LabeledTextField(
              label: 'New password',
              placeholder: 'must be 8 characters',
              controller: passwordController,
              isPrivate: true,
            ),
            SizedBox(
              height: paddingval,
            ),
            LabeledTextField(
              label: 'Confirm password',
              placeholder: 'repeat password',
              controller: confirmPasswordController,
              isPrivate: true,
            ),
            SizedBox(
              height: paddingval,
            ),
            const GreenElevatedButton(
              text: 'Reset Password',
              navigateTo: AppRoutes.resetsuccess,
            ),
            SizedBox(
              height: paddingval,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Already have an account?',
                style: TextStyle(),
              ),
              CustomTextButton(
                label: 'Log in',
                destinationRoute: AppRoutes.login,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class Resetsuccess extends StatelessWidget {
  const Resetsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Password changed',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your password has been changed succesfully.',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              GreenElevatedButton(
                text: 'Back to login',
                navigateTo: AppRoutes.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
