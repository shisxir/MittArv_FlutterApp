import 'package:flutter/material.dart';
import 'package:mitt_arv_shishir/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> _user = {};

  @override
  void initState() {
    super.initState();          //Initiates each state it creates
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId') ?? 0;
    if (userId != 0) {
      final user = await DBHelper.getUserById(userId);  //function to load user
      if (user != null) {                               //through usedId
        setState(() {
          _user = user;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(25.00),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/profilelogo.png',
              width: 300,
              height: 305,                    //Image that depicts the word Profile
              scale: 1,
            ),
            const SizedBox(height: 20),
            Text('Name: ${_user['name'] ?? ''}'),
            const SizedBox(height: 10),
            Text('Age: ${_user['age'] ?? ''}'),
            const SizedBox(height: 10),
            Text('Gender: ${_user['gender'] ?? ''}'),
            const SizedBox(height: 10),
            Text('Country: ${_user['country'] ?? ''}'),
            const SizedBox(height: 10),
            Text('Hobbies: ${_user['hobbies'] ?? ''}'),
            const SizedBox(height: 10),
            Text('Children: ${_user['children'] ?? ''}'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                SharedPreferences prefs =
                await SharedPreferences.getInstance();      //Logout button
                await DBHelper.deleteAllUsers();          // keeps the app unique to 1
                await prefs.remove('userId');

                Navigator.pushNamedAndRemoveUntil(context, 'welcome', (route) => false);
              },
              child: const Text('LOG OUT TO RESTART'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: ()                         //post button
                {                                     //allows user to post rtf
                  Navigator.pushNamed(context, 'post');
                }, child: const Text('POST')
            )
          ],
        ),
        ),
      ),
    );
  }
}
