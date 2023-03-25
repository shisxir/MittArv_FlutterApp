import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mitt_arv_shishir/welcome.dart';
import 'package:mitt_arv_shishir/login.dart';
import 'package:mitt_arv_shishir/profile.dart';
import 'package:mitt_arv_shishir/post_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId');        //Checking for an active state

  runApp(MittArv(
      initialRoute: userId != null ? 'profile' : 'welcome' // If no active state,
  )                                                        // then to welcome page
  );                                                       // else to profile.
}

class MittArv extends StatelessWidget {
  final String initialRoute;

  const MittArv({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        'welcome': (context) => const WelcomePage(),      //Route to
        'login': (context) => const LoginPage(),          //All the pages
        'profile': (context) => const ProfilePage(),      //in the app
        'post': (context) => const PostPage(),            //through context
      },
    );
  }
}











