import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/helpers/toast.dart';
import 'package:lawimmunity/main.dart';
import 'package:lawimmunity/screens/home_redirect_page.dart';
import 'package:lawimmunity/widgets/app_logo.dart';
import 'package:lawimmunity/widgets/appbar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';

class OtpLoginModal {
  var txtotpController = TextEditingController();

  bool isAutoValidate = false;

  var errorMessage = '';

  String? phoneNumber;
  bool? isLogin;

  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  String? _verificationId;
  int? forceResendingToken;


  final GlobalKey<FormState> key = GlobalKey<FormState>();

  showOtpLoginModalSheet({required mobileNo, required BuildContext context}) {
    phoneNumber = mobileNo;
    errorMessage = '';
    verifyPhoneNumber(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      isScrollControlled: true,
      builder: (BuildContext bcontext) {
        return AnimatedPadding(
          padding: MediaQuery.of(bcontext).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: BottomSheet(
            onClosing: () {},
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, setState) =>
                      SingleChildScrollView(
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: key,
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.close_sharp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: const [
                                    Spacer(),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset(
                                    //     "assets/images/12a.jpg",
                                    //     width: 80,
                                    //     height: 80,
                                    //     //color: Colors.white,
                                    //   ),
                                    // ),
                                    SizedBox(width: 20),
                                    Center(child: AppLogo()),
                                    Spacer()
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: const AutoSizeText(
                                          'Please enter your verification code',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 1,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: AutoSizeText.rich(
                                          TextSpan(
                                              text:
                                                  'A Verification code has been sent to your mobile no',
                                              children: [
                                                TextSpan(
                                                    text: ' (${phoneNumber}) ',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const TextSpan(
                                                    text: 'please enter here')
                                              ]),
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        children: const [
                                          AutoSizeText(
                                            'Enter your Otp Code',
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: (val) => val == ''
                                          ? 'This field is required'
                                          : null,

                                      controller: txtotpController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      // decoration: AppStyle.inputBoxDecoration(10.0, "", null)
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Container(
                                          width: 250,
                                          alignment: Alignment.center,
                                          child: RaisedGradientButton(
                                            'VERIFY OTP',
                                            radius: 12,
                                            onPressed: () {
                                              signInWithPhoneNumber(context);
                                            },
                                          )),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                        onTap: () async {
                                          verifyPhoneNumber(context);
                                        },
                                        child: const Center(
                                          child: Text(
                                            'Resend OTP',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
            },
          ),
        );
      },
    );
  }






  void verifyPhoneNumber(context)async{

      PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
        User? user;
        bool error=false;
        try{
          user=(await firebaseAuth.signInWithCredential(phoneAuthCredential)).user!;
        } catch (e){
          print("Failed to sign in: " + e.toString());
          error=true;
        }
        if(!error&&user!=null){
          String id=user.uid;
          //todo: here you can store user data in backend
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeRedirectPage()));
        }
      };

      PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
        showToast(authException.message!);
      };
      PhoneCodeSent codeSent = (String? verificationId, [int? forceResendingToken]) async {
        showToast('Please check your phone for the verification code.');
        this.forceResendingToken=forceResendingToken;
        _verificationId = verificationId;
      };
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
        _verificationId = verificationId;
      };
      try {
        await firebaseAuth.verifyPhoneNumber(
            phoneNumber: phoneNumber!,
            timeout: const Duration(seconds: 5),
            forceResendingToken: forceResendingToken!=null?forceResendingToken:null,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      } catch (e) {
        showToast("Failed to Verify Phone Number: $e");
      }
  }
  void signInWithPhoneNumber(context) async {
    if (key.currentState!.validate()) {
      bool error = false;
      User? user;
      AuthCredential credential;
      try {
        credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: txtotpController.text,
        );
        user = (await firebaseAuth.signInWithCredential(credential)).user!;
      } catch (e) {
        showToast("Failed to sign in: " + e.toString());
        error = true;
      }
      if (!error && user != null && user.uid != null) {
        String id = user.uid;
        //here you can store user data in backend
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeRedirectPage()));
      }
    }
  }


}
