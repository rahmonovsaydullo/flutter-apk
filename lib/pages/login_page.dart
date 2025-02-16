import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart/login_check.dart';
import 'package:flutter_application_1/pages/add_page.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernamecheck = TextEditingController();
  final TextEditingController passwordcheck = TextEditingController();
  bool showError = false; // false 
  bool isPasswordVisible = false; // false

  void checkAdmin() {
    if (usernamecheck.text == "admin" && passwordcheck.text == "admin123") {
      context.pushReplacement('/add', extra: AddNewProductPage());
      isLoggedIn=true;
    } else {
      isLoggedIn=false;
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/logo.png",
                width: 200,
                height: 200,
              ),
              Text(
                "Login",
                style: TextStyle(
                  color: Color(0xfff000),
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                  fontFamily: 'san-serif',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    if (showError)
                      Text(
                        "Username or password is incorrect",
                        style: TextStyle(color: Colors.red),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            "Username",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'san-serif',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: usernamecheck,
                      decoration: InputDecoration(
                        hintText: "Enter username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'san-serif',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: passwordcheck,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                shape: StadiumBorder(),
                minWidth: 200,
                height: 50,
                onPressed: checkAdmin,
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'san-serif',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                color: Color(0xFFF345AE1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
