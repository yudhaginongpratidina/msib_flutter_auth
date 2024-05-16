import 'package:flutter/material.dart';
import 'package:msib_flutter_auth/controllers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.lock, color: Colors.white),
        backgroundColor: Colors.orange,
        title: const Text(
          "AUTHENTICATION",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: authProvider.formAuthentication,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/images/banner_auth.jpg', height: 180),
            ),
            // ==============================================================================================
            // FORM TITLE
            // ==============================================================================================
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    authProvider.formTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // ==============================================================================================
            // INPUT EMAIL
            // ==============================================================================================
            TextFormField(
              controller: authProvider.emailController,
              validator: (value) =>
                  value!.isEmpty ? 'Email cannot be empty' : null,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // ==============================================================================================
            // INPUT PASSWORD
            // ==============================================================================================
            TextFormField(
                controller: authProvider.passwordController,
                obscureText: authProvider.obscurePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong isi field ini';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.orange,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        authProvider.actionObscurePassword();
                      },
                      icon: Icon(authProvider.obscurePassword == true
                          ? Icons.visibility_off
                          : Icons.visibility)),
                  border: const OutlineInputBorder(),
                )),
            const SizedBox(
              height: 20,
            ),

            // ==============================================================================================
            // TOMBOL AUTHENTICATION
            // ---------------------------------------------------------------------------------------------
            // JIKA FORM TITLE REGISTER MAKA TOMBOL REGISTER, NAMUN
            // JIKA FORM TITLE LOGIN MAKA TOMBOL LOGIN
            // ==============================================================================================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                authProvider.formTitle == 'REGISTER'
                    ? authProvider.processRegister(context)
                    : authProvider.processLogin(context);
              },
              child: Text(
                authProvider.formTitle == 'REGISTER' ? 'REGISTER' : 'LOGIN',
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // ==============================================================================================
            // ALTERNATIVE AUTHENTICATION
            // ==============================================================================================
            TextButton(
              onPressed: () {
                authProvider.updateFormTitle(context);
              },
              child: Text(
                authProvider.formTitle == 'REGISTER'
                    ? 'I have an Account'
                    : 'I Don\'t Have An Account',
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
