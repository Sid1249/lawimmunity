import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawimmunity/screens/auth/login_signup_page.dart';
import 'package:lawimmunity/screens/dashboard/dashboard_page.dart';
import 'package:lawimmunity/widgets/appbar.dart';

class HomeRedirectPage extends StatefulWidget {
  const HomeRedirectPage({Key? key}) : super(key: key);

  @override
  _HomeRedirectPageState createState() {
    return _HomeRedirectPageState();
  }
}

class _HomeRedirectPageState extends State<HomeRedirectPage> {
  var mainPage;

  @override
  void initState() {
    isUserAuthenticated();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainPage;
  }

  void isUserAuthenticated() {


    mainPage = Scaffold(
      appBar: LawImmunityAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading..",
                style: GoogleFonts.baskervville(
                    fontSize: 22, color: Colors.black, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 5,),
              Center(child: CircularProgressIndicator())
            ],
          )),
    );


    if(FirebaseAuth.instance.currentUser != null){

      setState(() {
        mainPage = const DashboardPage();
      });

    }else{

      setState(() {
        // mainPage = LoginSignupPage();
        mainPage = DashboardPage();

      });

    }

  }




}
