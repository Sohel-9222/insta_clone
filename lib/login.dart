import 'package:flutter/material.dart';
import 'package:instaclone/dashboard.dart';
import 'package:instaclone/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String password = '';
  String mobileEmail = '';
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool isEmailMatch = false;
  bool isPasswordMatch = false;
  bool isPasswordVisible = false;

  @override
  TextEditingController _phoneMobileConroller = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();

  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveLoginData(String phoneMobile, String loginPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneMobile', phoneMobile);
    prefs.setString('loginPassword', loginPassword);
  }

  Future<Map<String, String>> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String phoneMobile = prefs.getString('phoneMobile') ?? '';
    String loginPassword = prefs.getString('loginPassword') ?? '';

    return {'phoneMobile': phoneMobile, 'loginPassword': loginPassword};
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileEmail = prefs.getString('mobileEmailKey') ?? 'No data available';
      password = prefs.getString('passwordKey') ?? 'No data available';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 70.h,
                width: 90.w,
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xffdbdbdb))),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Instagram",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        height: 8.h,
                        width: 75.w,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _phoneMobileConroller,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffffafafa),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffdbdbdb)),
                              ),
                              hintText: "Phone number, username or email",
                            ),
                            validator: (value) {
                              bool isEmailMatch =
                                  mobileEmail == _phoneMobileConroller.text;
                              if (!isEmailMatch) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid phone number, username, or email';
                                } else {
                                  return "Email does not match";
                                }
                              }
                              // Add additional validation if needed
                              return null; // Return null if the validation passes
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        height: 8.h,
                        width: 75.w,
                        child: Form(
                          key:
                              _formKey2, // Use a separate _formKey for each Form widget
                          child: TextFormField(
                            obscureText: !isPasswordVisible,
                            controller: _loginPasswordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xfffafafa),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffdbdbdb)),
                              ),
                              hintText: "Password",
                              suffixIcon: GestureDetector (
                                onTap: () {

                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;

                                  });
                                },
                                child: Icon(
                                  isPasswordVisible ?Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              )
                            ),
                            validator: (value) {
                              bool isPasswordMatch =
                                  password == _loginPasswordController.text;
                              if (!isPasswordMatch) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid password';
                                } else {
                                  return "password not match";
                                }
                              }
                              // Add additional password validation if needed
                              return null; // Return null if the validation passes
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            // Validate the form
                            if (_formKey.currentState?.validate() ?? false) {
                              // Form is valid, proceed with login logic
                              bool isEmailMatch =
                                  mobileEmail == _phoneMobileConroller.text;
                              bool isPasswordMatch =
                                  password == _loginPasswordController.text;

                              if (isEmailMatch == isPasswordMatch) {
                                // Email matches, proceed with login logic
                                saveLoginData(
                                  _phoneMobileConroller.text,
                                  _loginPasswordController.text,
                                );

                                Map<String, String> loginData =
                                    await getLoginData();

                                print(loginData);

                                // Navigate to Dashboard only when the email matches
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              } else {
                                // Handle the case when email doesn't match
                                print("Email does not match");
                              }
                            }

                            if (_formKey2.currentState?.validate() ?? false) {
                              // Form is valid, proceed with login logic
                              bool isEmailMatch =
                                  mobileEmail == _phoneMobileConroller.text;

                              bool isPasswordMatch =
                                  password == _loginPasswordController.text;

                              if (isEmailMatch || isPasswordMatch) {
                                // Email matches, proceed with login logic
                                saveLoginData(
                                  _phoneMobileConroller.text,
                                  _loginPasswordController.text,
                                );

                                Map<String, String> loginData =
                                    await getLoginData();

                                print(loginData);

                                // Navigate to Dashboard only when the email matches
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              } else {
                                // Handle the case when email doesn't match
                                print("Email does not match");
                              }
                            }
                            // Navigate to the Dashboard
                          } catch (error) {
                            // Handle any errors that may occur during the login process
                            print('Error during login: $error');
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 75.w,
                          child: Center(
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff4cb5f9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            height: 8.h,
                            width: 30.w,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xff737373),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                            height: 8.h,
                            width: 30.w,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.facebook,
                            color: Color(0xff385185),
                            size: 4.h,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Log in with Facebook",
                            style: TextStyle(
                                color: Color(0xff385185),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Forgot password?",
                        style: TextStyle(fontSize: 13.sp),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 10.h,
                width: 90.w,
                // color: Colors.green,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => signup()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff0095f6),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xffdbdbdb))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
