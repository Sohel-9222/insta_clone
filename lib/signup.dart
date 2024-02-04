import 'package:flutter/material.dart';
import 'package:instaclone/dashboard.dart';
import 'package:instaclone/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey3 = GlobalKey<FormState>();
  // TextEditingController _mobileEmailController = TextEditingController();
  // TextEditingController _fullNameContrller = TextEditingController();
  // TextEditingController _userNameController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null; // Return null if validation passes
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null; // Return null if validation passes
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one digit';
    } else if (!RegExp(r'(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-])')
        .hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Return null if validation passes
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    List<String> words = value.trim().split(' ');

    if (words.length < 2) {
      return 'Full name should contain at least two words';
    }

    for (String word in words) {
      if (!RegExp(r'^[A-Z][a-z]*$').hasMatch(word)) {
        return 'Invalid character in the full name';
      }
    }

    return null; // Return null if validation passes
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    // Check if the username contains only letters, numbers, underscores, or dots
    if (!RegExp(r'^[a-zA-Z0-9_.]+$').hasMatch(value)) {
      return 'Invalid characters in the username';
    }

    // Check if the username is between 3 and 20 characters long
    if (value.length < 3 || value.length > 20) {
      return 'Username should be between 3 and 20 characters long';
    }

    return null; // Return null if validation passes
  }

  @override
  TextEditingController _mobileEmailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> saveSignupData(String mobileEmail, String fullName,
      String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save data

    prefs.setString('mobileEmailKey', mobileEmail);
    prefs.setString('fullNameKey', fullName);
    prefs.setString('userNameKey', userName);
    prefs.setString('passwordKey', password);
  }

  Future<Map<String, String>> getSignupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve signup data

    String mobileEmail = prefs.getString('mobileEmailKey') ?? '';
    String fullName = prefs.getString('fullNameKey') ?? '';
    String userName = prefs.getString('userNameKey') ?? '';
    String password = prefs.getString('passwordKey') ?? '';

    return {
      'mobileEmail': mobileEmail,
      'fullName': fullName,
      'userName': userName,
      'password': password,
    };
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 6.h,
              ),
              Container(
                height: 100.h,
                width: 90.w,
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xffdbdbdb))),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "Instagram",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          "Sign up to see photos and videos",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Color(0xff737373)),
                        ),
                      ),
                      Text(
                        "from your friends.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Color(0xff737373)),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 5.h,
                          width: 75.w,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                  size: 4.h,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  "Log in with Facebook",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff1877f2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),

                      SizedBox(
                        height: 1.h,
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
                      Form(
                        key: _formKey3,
                        child: Column(
                          children: [
                            Container(
                              height: 8.h,
                              width: 75.w,
                              child: TextFormField(
                                controller: _mobileEmailController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffffafafa),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffdbdbdb))),
                                    hintText: "Email"),
                                validator: validateEmail,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 8.h,
                              width: 75.w,
                              child: TextFormField(
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfffafafa),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffdbdbdb))),
                                      hintText: "Full Name"),
                                  validator: validateFullName),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 8.h,
                              width: 75.w,
                              child: TextFormField(
                                  controller: _userNameController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfffafafa),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffdbdbdb))),
                                      hintText: "Username"),
                                  validator: validateUserName),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 8.h,
                              width: 75.w,
                              child: TextFormField(
                                obscureText: !_isPasswordVisible,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfffafafa),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffdbdbdb)),
                                  ),
                                  hintText: "Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                validator: validatePassword,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 70.w,
                            child: Column(
                              children: [
                                Text(
                                  "People who use our service may have uploaded your contact information to",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff737573)),
                                ),
                                Text(
                                  "Instagram. Learn More",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff737573)),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text("By signing up, you agree to our Terms,",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff737573),
                                    )),
                                Text(
                                  "Privacy Policy and Cookies Policy.",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff737573)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 3.h,
                      ),

                      InkWell(
                        onTap: () async {
                          try {
                            if (_formKey3.currentState?.validate() ?? false) {
                              // Save the signup data first
                              saveSignupData(
                                _mobileEmailController.text,
                                _fullNameController.text,
                                _userNameController.text,
                                _passwordController.text,
                              );

                              // Retrieve the signup data after saving
                              Map<String, String> signupData =
                                  await getSignupData();

                              // Do something with the retrieved signup data, for example, print it
                              print(signupData);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()),
                              );
                            }

                            // Other signup logic can go here
                          } catch (error) {
                            // Handle any errors that may occur during the signup process
                            print('Error during signup: $error');
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 75.w,
                          child: Center(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff4cb5f9),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      // SizedBox(height: 2.h,),
                      // Text("Forgot password?",
                      //   style: TextStyle(
                      //       fontSize: 13.sp
                      //
                      //   ),
                      // )
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
                        "Have an account?",
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
                            MaterialPageRoute(builder: (context) => login()),
                          );
                        },
                        child: Text(
                          "Log in",
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
              SizedBox(height: 2.h)
            ],
          ),
        ),
      ),
    );
  }
}
