import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:msib_flutter_auth/controllers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();
    return Scaffold(
      body: Form(
        key: authProvider.formAuthentication,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              child: Image.asset(
                'assets/images/banner_auth.jpg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            // ==============================================================================================
            // FORM TITLE
            // ==============================================================================================
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authProvider.formTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Text(
                    "Enter your email and password",
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              // ==============================================================================================
              // INPUT EMAIL
              // ==============================================================================================
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child:
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
            ),

            Padding(
              // ==============================================================================================
              // TOMBOL AUTHENTICATION
              // ---------------------------------------------------------------------------------------------
              // JIKA FORM TITLE REGISTER MAKA TOMBOL REGISTER, NAMUN
              // JIKA FORM TITLE LOGIN MAKA TOMBOL LOGIN
              // ==============================================================================================
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
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
