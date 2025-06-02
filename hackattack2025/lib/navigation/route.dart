import 'package:flutter/material.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/IndustryUI/homepage/homepage.dart';
import 'package:hackattack2025/UserUI/homepage.dart';
import 'package:hackattack2025/roleselection.dart';
import 'package:hackattack2025/authentication/authentication_module.dart';
import 'package:hackattack2025/IndustryUI/industry_module.dart';
import 'package:hackattack2025/UserUI/favourite_industry.dart';
import 'package:hackattack2025/UserUI/api_service_page.dart';

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
  static const String userhomepage = '/Userhomepage';
  static const String favouriteindustry = '/favouriteIndustry';
  static const String apiservicepage = '/apiServicePage';
  //Industry UI route
  static const String industryhomepage = '/Industryhomepage';
  static const String airlocationlist = '/Airlocationlist';
  static const String airlocationstats = '/Airlocationstats';
  static const String airlocationdetails = '/Airlocationdetails';
  static const String airsensordata = '/Airsensordata';

  static const String sensorlist = '/Sensorlist';
  static const String addsensor = '/Addsensor';

  static const String schedulelist = '/Schedulelist';
  static const String scheduleinfo = '/Scheduleinfo';
  static const String addschedule = '/Addschedule';

  static const String sensorshoplist = '/Sensorshoplist';
  static const String sensorcart = '/Sensorcart';

  static const String industrychatbot = '/Industrychatbot';

  static const String industrynoti = '/Industrynoti';

  static const String industryprofilelist = '/Industryprofilelist';
  static const String industryeditprofile = '/Industryeditprofile';

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
      userhomepage: (context)=>const Userhomepage(),
      favouriteindustry: (context)=>const FavouriteIndustryPage(),
      apiservicepage: (context)=>const ApiServicePage(),
      //Industry UI route
      industryhomepage: (context) => const Industryhomepage(),
      airlocationlist: (context) => const Airlocationlist(),
      airlocationstats: (context) {
        final args = ModalRoute.of(context)!.settings.arguments;
        String label = '';
        if (args is String) {
          label = args;
        }
        return Airlocationstats(label: label);
      },
      airlocationdetails: (context) {
        final args = ModalRoute.of(context)!.settings.arguments;
        List<DaySchedule> schedules = [];
        if (args is List<DaySchedule>) {
          // Assuming you pass a list of DaySchedule
          schedules = args;
        }
        return Locationdetails(dummySchedules: schedules);
      },
      // In your routes configuration (e.g., in main.dart or app_routes.dart)

      airsensordata: (context) {
        final args = ModalRoute.of(context)!.settings.arguments;
        final SensorData sensordata = (args is SensorData)
            ? args
            : const SensorData(
                sensorId:
                    'Error', // Provide default/placeholder values for safety
                sensorType: 'Unknown Sensor',
                lastReading: 'N/A',
                location: 'Unknown Location',
              );

        return Airsensordata(sensorData: sensordata);
      },

      sensorlist: (context) => const Sensorlist(),
      addsensor: (context) {
        // Retrieve arguments, which could be null or a SensorData object
        final SensorData? sensorData =
            ModalRoute.of(context)!.settings.arguments as SensorData?;
        return Addsensor(sensorData: sensorData);
      },

      schedulelist: (context) => const Schedulelist(),
      scheduleinfo: (context) {
        // Retrieve arguments, which could be null or a SensorData object
        final ScheduleData? scheduleData =
            ModalRoute.of(context)!.settings.arguments as ScheduleData?;
        return Scheduleinfo(scheduleData: scheduleData);
      },
      addschedule: (context) {
        // Retrieve arguments, which could be null or a SensorData object
        final ScheduleData? scheduleData =
            ModalRoute.of(context)!.settings.arguments as ScheduleData?;
        return Addschedule(scheduleData: scheduleData);
      },

      sensorshoplist: (context) => const Sensorshoplist(),
      sensorcart: (context) => const Sensorcart(),

      industrychatbot: (context) => const Industrychatbot(),
      industrynoti: (context) => const Industrynoti(),

      industryprofilelist: (context) => const Industryprofilelist(),
      industryeditprofile: (context) {
        // Retrieve arguments, which should be a UserProfile object
        final args = ModalRoute.of(context)!.settings.arguments;
        final UserProfile userProfile = (args is UserProfile)
            ? args
            : UserProfile(
                // Provide a default UserProfile for safety
                name: 'Guest User',
                email: 'guest@example.com',
                username: 'guestuser', // Provide a default username
                address: '',
              );
        return Industryeditprofile(userProfile: userProfile);
      },
    };
  }
}
