import 'package:flutter/material.dart';
import 'package:instaclone/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? fullNameData = '';
  String? userNameData = '';
  String? emailData = '';
  String? passwordData = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullNameData = prefs.getString('fullNameKey') ?? '';
      userNameData = prefs.getString('userNameKey') ?? '';
      emailData = prefs.getString('phoneMobile');
      passwordData = prefs.getString('loginPassword');
    });
  }

  Future<void> editData(String newUserName, String newFullName, String newPhoneMobile, String newLoginPassword ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userNameKey', newUserName);
    prefs.setString('fullNameKey', newFullName);
    prefs.setString('phoneMobile', newPhoneMobile);
    prefs.setString('loginPassword', newLoginPassword);
    setState(() {
      // Reload the data inside setState
      loadData(); // Refresh the UI with the updated data
    });
    print('Data updated: $newUserName, $newFullName');
  }

  Future<void> deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userNameKey');
    prefs.remove('fullNameKey');
    prefs.remove('phoneMobile');
    prefs.remove('loginPassword');

    setState(() {
      loadData();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 8.h,
              width: 75.w,
              child: TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffafafa),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffdbdbdb)),
                    ),
                    labelText: fullNameData),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 8.h,
              width: 75.w,
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffafafa),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffdbdbdb)),
                    ),
                    labelText: userNameData),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            Container(
              height: 8.h,
              width: 75.w,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffafafa),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffdbdbdb)),
                    ),
                    labelText: emailData),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            Container(
              height: 8.h,
              width: 75.w,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfffafafa),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffdbdbdb)),
                    ),
                    labelText: passwordData),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String newUserName = userNameController.text;
                    String newFullName = fullNameController.text;
                    String newPhoneMobile = emailController.text;
                    String newLoginPassword = passwordController.text;

                    await editData(newUserName, newFullName, newPhoneMobile, newLoginPassword);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("New Data updated successfully!"),
                    ));

                    // Remove the redundant call
                    // print(editData(newUserName, newFullName));
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(onPressed: () async{
                  await deleteData();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted")));
                }, child: Text('Delete')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Text('LogOut'))
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("New UserName : $userNameData"),SizedBox(height: 1.h,),
                Text("New FullName : $fullNameData"),SizedBox(height: 1.h,),
                Text("New PhoneMobile : $emailData"),SizedBox(height: 1.h,),
                Text("New LoginPassword : $passwordData"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
