import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // ==============================================
  // KEY FORM STATE
  // ==============================================
  final formAuthentication = GlobalKey<FormState>();
  StateAuth state = StateAuth.initial;

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
  bool obscurePassword = false;

  // FUNGSI UNTUK PROSES REGISTER
  // ===========================================================
  void processRegister(BuildContext context) {
    if (formAuthentication.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;

      showAlertRegisterSuccess(context);
      emailController.clear();
      passwordController.clear();
      updateFormTitle(context);
    } else {
      showAlertError(context);
    }

    notifyListeners();
  }

  // FUNGSI UNTUK PROSES LOGIN
  // ===========================================================
  void processLogin(BuildContext context) {
    if (formAuthentication.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;

      if (email == 'admin' && password == 'admin') {
        showAlertLoginSuccess(context);
      }
    } else {
      showAlertError(context);
    }
    notifyListeners();
  }

  // FUNGSI UNTUK MERUBAH FORM TITLE
  // ===========================================================
  void updateFormTitle(BuildContext context) {
    if (_formTitle == 'REGISTER') {
      _formTitle = 'LOGIN';
    } else {
      _formTitle = 'REGISTER';
    }
    notifyListeners();
  }

  // FUNGSI UNTUK SHOW AND HIDDEN PASSWORD
  void actionObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}

enum StateAuth { initial, loading, success, error }

// FUNGSI UNTUK POPUP ALLERT MESSAGE KETIKA REGISTER BERHASIL
// ===========================================================
showAlertRegisterSuccess(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: const Text('REGISTER BERHASIL'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('LOGIN'))
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ));
    },
  );
}

// FUNGSI UNTUK POPUP ALLERT MESSAGE KETIKA LOGIN BERHASIL
// ===========================================================
showAlertLoginSuccess(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: const Text(
            'LOGIN BERHASIL',
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
showAlertError(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('DATAMU MASIH KOSONG'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'))
        ],
      );
    },
  );
}
