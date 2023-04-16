import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/page/login_page.dart';

import '../provider/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeData().scaffoldBackgroundColor,
            )),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 1,
            ),
            child: Center(
              child: ListView(
                children: <Widget>[
                  Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    child: Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/images/img_profile.png',
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              ' Username : ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " Email :",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyThemes.darkTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 350,
                          child: TextButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                print("signed out");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              });
                            },
                            icon: Icon(
                              Icons.logout,
                              color: ThemeData().scaffoldBackgroundColor,
                              size: 20,
                            ),
                            label: Text("Logout",
                                style: TextStyle(
                                  color: ThemeData().scaffoldBackgroundColor,
                                  fontSize: 20,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
