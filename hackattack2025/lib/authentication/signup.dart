import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/navigation/route.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final paddingval = 20.0;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                    'Sign Up',
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
                Row(
                  children: [
                    Expanded(
                      child: LabeledTextField(
                        label: 'First Name',
                        placeholder: 'John',
                        controller: firstNameController,
                      ),
                    ),
                    SizedBox(
                      width: paddingval,
                    ),
                    Expanded(
                      child: LabeledTextField(
                        label: 'Last Name',
                        placeholder: 'Doe',
                        controller: lastNameController,
                      ),
                    ),
                  ],
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
                  label: 'Create a password',
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
                    text: 'Proceed', navigateTo: AppRoutes.suaddress),
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
                    Text('  Or Register with  '),
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
        ),
      ),
    );
  }
}

class SUaddress extends StatefulWidget {
  const SUaddress({super.key});

  @override
  State<SUaddress> createState() => _SUaddressState();
}

class _SUaddressState extends State<SUaddress> {
  final paddingval = 20.0;
  final TextEditingController companyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

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
                    'Sign Up - Address',
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
                LabeledTextField(
                  label: 'Company Name',
                  placeholder: 'Industry Sdn Bhd',
                  controller: companyController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Address',
                  placeholder: 'Location of the company',
                  controller: addressController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Postcode',
                  placeholder: 'Postcode',
                  controller: postcodeController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'State',
                  placeholder: 'State',
                  controller: stateController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                const GreenElevatedButton(
                    text: 'Sign Up', navigateTo: AppRoutes.signup),
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
                    Text('  Or Register with  '),
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
        ),
      ),
    );
  }
}
