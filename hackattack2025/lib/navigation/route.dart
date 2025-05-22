import 'package:flutter/material.dart';
import 'package:hackattack2025/roleselection.dart';
import 'package:hackattack2025/authentication/authentication_module.dart';

class AppRoutes {
  //Role Selection route
  static const String roleselection = '/Roleselection';

  //Authentication route
  static const String userentry = '/Userentry';
  static const String signup = '/Signup';

  //Normal User UI route

  //Industry UI route

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //Role Selection route
      roleselection: (context) => const Roleselection(),

      //Authentication route
      userentry: (context) => const Userentry(),
      signup: (context) => const Signup(),

      //Normal User UI route

      //Industry UI route
    };
  }
}
