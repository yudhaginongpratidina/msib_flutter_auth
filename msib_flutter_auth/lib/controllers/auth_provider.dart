// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // ==============================================
  // KEY FORM STATE
  // ==============================================
  final formAuthentication = GlobalKey<FormState>();
  StateAuth authState = StateAuth.initial;

  // =================================================
  // CONTROLLER
  // =================================================
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _formTitle =
      'REGISTER'; // Menggunakan _formTitle sebagai private variable

  String get formTitle =>
      _formTitle; // Getter untuk mendapatkan nilai formTitle

  var email = '';
  var password = '';
  var uid = '';
  var messageError = '';
  bool obscurePassword = true;

  // FUNGSI UNTUK PROSES REGISTER
  // ===========================================================
  void processRegister(BuildContext context) async {
    if (formAuthentication.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        email = emailController.text;
        uid = dataUser.uid;
        authState = StateAuth.success;
        showAlertRegisterSuccess(context, uid);
        emailController.clear();
        passwordController.clear();
        updateFormTitle(context);
      } on FirebaseAuthException catch (error) {
        authState = StateAuth.error;
        messageError = error.message!;
        showAlertError(context, messageError);
      } catch (e) {
        authState = StateAuth.error;
        messageError = e.toString();
        showAlertError(context, messageError);
      }

      notifyListeners();
    } else {
      showAlertFieldEmpty(context);
    }
  }

  // FUNGSI UNTUK PROSES LOGIN
  // ===========================================================
  void processLogin(BuildContext context) async {
    if (formAuthentication.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        email = emailController.text;
        uid = dataUser.uid;
        authState = StateAuth.success;
        showAlertLoginSuccess(context, uid);
      } on FirebaseAuthException catch (error) {
        authState = StateAuth.error;
        messageError = error.message!;
        showAlertError(context, messageError);
      } catch (e) {
        authState = StateAuth.error;
        messageError = e.toString();
        showAlertError(context, messageError);
      }
    } else {
      showAlertFieldEmpty(context);
    }
    notifyListeners();
  }

  // FUNGSI UNTUK MERUBAH FORM TITLE
  // ===========================================================
  void updateFormTitle(BuildContext context) {
    if (_formTitle == 'REGISTER') {
      _formTitle = 'LOGIN';
      emailController.clear();
      passwordController.clear();
    } else {
      _formTitle = 'REGISTER';
      emailController.clear();
      passwordController.clear();
    }
    notifyListeners();
  }

  // FUNGSI UNTUK SHOW AND HIDDEN PASSWORD
  // ===========================================================
  void actionObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}

enum StateAuth { initial, loading, success, error }

// FUNGSI UNTUK POPUP ALLERT MESSAGE KETIKA REGISTER BERHASIL
// ===========================================================
void showAlertRegisterSuccess(BuildContext context, String uuid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'BERHASIL TERDAFTAR DENGAN UUID : $uuid',
          style: const TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('LOGIN'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      );
    },
  );
}

// FUNGSI UNTUK POPUP ALLERT MESSAGE KETIKA LOGIN BERHASIL
// ===========================================================
showAlertLoginSuccess(BuildContext context, String uid) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(
            'BERHASIL LOGIN DENGAN UUID : $uid',
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ));
    },
  );
}

// FUNGSI UNTUK POPUP ALLERT MESSAGE KETIKA ERROR
// ===========================================================
void showAlertError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(
            'TERJADI ERROR : $message',
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ));
    },
  );
}

// FUNGSI UNTUK POPUP ALLERT MESSAGE KETIKA FIELD KOSONG
// ===========================================================
showAlertFieldEmpty(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(
            'DATAMU MASIH KOSONG',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ));
    },
  );
}
