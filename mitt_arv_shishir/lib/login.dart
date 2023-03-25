import 'package:flutter/material.dart';
import 'package:mitt_arv_shishir/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState(); // new instance created
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();     // controllers
  final TextEditingController _age = TextEditingController();      // for  text
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _hobbies = TextEditingController();
  final TextEditingController _children = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(25.0),
          alignment: Alignment.center,

          child: SingleChildScrollView(   //to create scrollable widget
                                          // avoids pixel overflow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/loginlogo.png',
                  scale: 1,                           //Setting up Image
                  width: 300,
                  height: 250,
                ),
                Form(                                 //creates a form
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        TextFormField(
                          controller: _name,
                          decoration: const InputDecoration(
                              labelText: 'Name'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name';   //validation
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _age,
                          decoration: const InputDecoration(
                              labelText: 'Age'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Age';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _gender,
                          decoration: const InputDecoration(
                              labelText: 'Gender'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Gender'; //validation
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _country,
                          decoration: const InputDecoration(
                              labelText: 'Country'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your country';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _hobbies,
                          decoration: const InputDecoration(
                              labelText: 'Hobbies'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your hobbies';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _children,
                          decoration: const InputDecoration(
                              labelText: 'Number of children'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the number of children';
                            }                            //validation
                            return null;
                          },
                        )
                      ],
                    )

                ),

                const SizedBox(height: 60),     //to give a little gap

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,      //button styling
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final Map<String, dynamic> user = {
                        'name': _name.text,
                        'age': int.tryParse(_age.text) ?? 0,
                        'gender': _gender.text,          //entering field data
                        'country': _country.text,         // to table
                        'hobbies': _hobbies.text,
                        'children': int.tryParse(_children.text) ?? 0,
                      };
                      int result = await DBHelper.addUser(user); //calling function
                      user['id'] = result;
                      _name.clear();
                      _age.clear();
                      _gender.clear();
                      _country.clear();
                      _hobbies.clear();
                      _children.clear();

                      if (result != -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Registered Successfully'),
                          ),
                        );
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('userId', user['id']);
                        Navigator.pushNamed(context, 'profile');
                      }

                    }
                  },
                  child: const Text('SUBMIT'),
                )
              ]
          )
          ),
        )

    );
  }
}