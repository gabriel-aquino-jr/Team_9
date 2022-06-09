import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/pages/create_account.dart';
import 'package:mockup/pages/forgot_password.dart';
import 'package:mockup/pages/my_appointments.dart';
import 'package:mockup/utilities/palette.dart';
import 'package:mockup/database/db_helper.dart';

class LoginDemo extends StatefulWidget {
  static String route = "login";
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final dbHelper = DBHelper.instance;

  Future<void> _validateLogin() async {
    dbHelper.insertSampleCustomer();
    if (await dbHelper.authLogin(_email, _password)) {
      debugPrint('login ok!');
    } else {
      debugPrint('login fail!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.lightBlue,
            Palette.lightGreen,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 182, 205, 205),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          color: Palette.matDarkGreen.shade900,
                          spreadRadius: 2),
                      BoxShadow(
                          blurRadius: 2,
                          color: Palette.matDarkGreen.shade100,
                          spreadRadius: 4),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 16),
                    child: Column(
                      children: [
                        Container(
                            width: 200,
                            height: 150,
                            child: Image.asset('lib/assets/images/NBLogo.png')),
                        const Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: FancyText(
                              ftext: 'snbDrive', style: Style.mainTitle),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                // style: TextStyle(  // This is inner text
                //     fontSize: 34,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.grey.shade700),
                controller: _email,
                decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(
                      fontSize: 22,
                      color: Palette.darkred,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Palette.darkred,
                      ),
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(
                      fontSize: 22,
                      color: Palette.darkred,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Palette.darkred,
                      ),
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                controller: _password,
              ),
            ),
            NavBtn(
                btnType: BtnType.link,
                label: 'Forgot Password',
                route: ForgotPassword.route),
            NavBtn(
                label: 'Login',
                route: MyAppointments.route,
                callback: _validateLogin),
            ElevatedButton(
                onPressed: () => _validateLogin(), child: const Text('login2')),
            const SizedBox(
              height: 100,
            ),
            NavBtn(
              btnType: BtnType.link,
              label: 'New User? Create Account',
              route: CreateAccount.route,
            ),
            ElevatedButton(onPressed: () {
            _InsertData();

            } 
            , child: Text("Insert Dummy Data"))
          ],
        ),
      ),
    );
  }
  
  void _InsertData() {
    dbHelper.
  }
}
