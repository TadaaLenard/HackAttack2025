import 'package:flutter/material.dart';
import 'package:hackattack2025/IndustryUI/homepage.dart';
import 'package:hackattack2025/roleselection.dart';
import 'package:hackattack2025/authentication/authentication_module.dart';

class AppRoutes {
  //Role Selection route
  static const String roleselection = '/Roleselection';

  //Authentication route
  static const String userentry = '/Userentry';
  static const String signup = '/Signup';
  static const String suaddress = '/SUaddress';
  static const String login = '/Login';
  static const String forgetpassword = '/Forgetpassword';
  static const String fpcode = '/Fpcode';
  static const String resetpassword = '/Resetpassword';
  static const String resetsuccess = '/Resetsuccess';

  //Normal User UI route

  //Industry UI route
  static const String industryhomepage = '/Industryhomepage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //Role Selection route
      roleselection: (context) => const Roleselection(),

      //Authentication route
      userentry: (context) => const Userentry(),
      signup: (context) => const Signup(),
      suaddress: (context) => const SUaddress(),
      login: (context) => const Login(),
      forgetpassword: (context) => const Forgetpassword(),
      fpcode: (context) => const Fpcode(),
      resetpassword: (context) => const Resetpassword(),
      resetsuccess: (context) => const Resetsuccess(),

      //Normal User UI route

      //Industry UI route
      industryhomepage: (context) => const Industryhomepage(),
    };
  }
}
