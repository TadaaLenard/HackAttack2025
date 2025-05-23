import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/navigation/route.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final paddingval = 20.0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(paddingval),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hi, Welcome!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: paddingval,
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
                LabeledTextField(
                  label: 'Password',
                  placeholder: 'must be 8 characters',
                  controller: passwordController,
                  isPrivate: true,
                ),
                SizedBox(
                  height: paddingval,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CheckButton(),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Remember Me'),
                      ],
                    ),
                    CustomTextButton(
                      label: 'Forgot Password?',
                      destinationRoute: AppRoutes.forgetpassword,
                      textColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: paddingval,
                ),
                const GreenElevatedButton(
                    text: 'Log in', navigateTo: AppRoutes.login),
                SizedBox(
                  height: paddingval,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                      ),
                    ),
                    Text('  Or Login with  '),
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingval),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ThirdPartyElevatedButton(label: 'facebook'),
                    ThirdPartyElevatedButton(label: 'google'),
                    ThirdPartyElevatedButton(label: 'apple')
                  ],
                ),
                SizedBox(height: paddingval),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      CustomTextButton(
                        label: 'Sign up',
                        fontSize: 17,
                        destinationRoute: AppRoutes.signup,
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
