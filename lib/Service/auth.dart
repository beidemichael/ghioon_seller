// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';

class AuthServices {
  String? wholePhoneNumber;

  String? otpCode;
  AuthServices({this.wholePhoneNumber, this.otpCode});
  User? _firebaseUser;
  AuthCredential? _phoneAuthCredential;
  static String? _verificationId;

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  Future<void> getFirebaseUser() async {}

  UserAuth? userFromFirebaseUser(User? user) {
    return user != null ? UserAuth(uid: user.uid) : null;
  }

  Stream<UserAuth?> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        //.map((FirebaseUser user)=>_userFromFirebaseUser(user)) same as the code below
        .map(userFromFirebaseUser);
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<void> signOut() async {
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      // _firebaseUser = null;
    } catch (e) {
      print(e.toString());
    }
  }

  void submitOTP(
      otpCode, wholePhoneNumber, Function codeInvalid, Function cancelTimer) {
    /// get the `smsCode` from the user
    String smsCode = otpCode.trim();

    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: smsCode);

    login(wholePhoneNumber, codeInvalid, cancelTimer);
  }

  Future<void> login(
      wholePhoneNumber, Function codeInvalid, Function cancelTimer) async {
    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
    try {
      await FirebaseAuth.instance
          .signInWithCredential(_phoneAuthCredential!)
          .then((authRes) {
        _firebaseUser = authRes.user;

        print(_firebaseUser.toString());
      });
      final User user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;

      // await DatabaseService(userPhoneNumber: wholePhoneNumber)
      //     .newUserData('', 'New member', uid.toString());
      cancelTimer();
    } catch (e) {
      // Navigator.pop(context);
      if (e == "invalid") {}

      codeInvalid();
      print(e.toString());
    }
//      on PlatformException catch (e) {
//   if (e.message.contains("The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.")) {
//     Navigator.pop(context);
//       _showErrorDialog(context);

//   } else if (e.message.contains('The sms code has expired')) {
//     // ...
//   }
// }
  }

  Future<void> submitPhoneNumber(Function toManyTimes) async {
    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) async {
      print('verificationCompleted');

      _phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
      try {
        await FirebaseAuth.instance
            .signInWithCredential(_phoneAuthCredential!)
            .then((authRes) {
          _firebaseUser = authRes.user;

          print(_firebaseUser.toString());
        });
        final User user = FirebaseAuth.instance.currentUser!;
        final uid = user.uid;

        // await DatabaseService(userPhoneNumber: wholePhoneNumber)
        //     .newUserData('', 'New member', uid.toString());
      } catch (e) {
        if (e == ("invalid")) {}

        print(e.toString());
      }
    }

    void verificationFailed(error) {
      print('verificationFailed');
      toManyTimes();
      print(error);
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// _showErrorDialog(context);
    }

    void codeSent(String verificationId, [int? code]) {
      print('codeSent');
      _verificationId = verificationId;
      print(verificationId);
      print(code.toString());
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');

      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: wholePhoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: Duration(seconds: 62),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }
}
