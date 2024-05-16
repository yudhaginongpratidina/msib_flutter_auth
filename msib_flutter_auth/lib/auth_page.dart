import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:msib_flutter_auth/controllers/auth_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();
    return Scaffold(
      // ==============================================================
      // APP BAR
      // ==============================================================
      appBar: AppBar(
        leading: const Icon(Icons.lock, color: Colors.white),
        backgroundColor: Colors.orange,
        title: Text(
          "AUTHENTICATION",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      // ==============================================================
      // BODY
      // ==============================================================
      body: Form(
        key: authProvider.formAuthentication,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          children: [
            // ==================================================
            // FORM TITLE
            // ==================================================
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    authProvider.formTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),

            // ==================================================
            // SPACE
            // ==================================================
            const SizedBox(
              height: 20,
            ),

            // ==================================================
            // EMAIL
            // ==================================================
            TextFormField(
              controller: authProvider.emailController,
              validator: (value) =>
                  value!.isEmpty ? 'Email cannot be empty' : null,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // ==================================================
            // PASSWORD
            // ==================================================
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
                  suffixIcon: IconButton(
                      onPressed: () {
                        authProvider.actionObscurePassword();
                      },
                      icon: Icon(authProvider.obscurePassword == true
                          ? Icons.visibility_off
                          : Icons.visibility)),
                  border: const OutlineInputBorder(),
                )),

            // ==================================================
            // SPACE
            // ==================================================
            const SizedBox(
              height: 20,
            ),

            // ==================================================
            // BUTTON AUTHENTICATION
            // ==================================================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
            TextButton(
              onPressed: () {
                authProvider.updateFormTitle(context);
              },
              child: Text(
                authProvider.formTitle == 'REGISTER'
                    ? 'I have an Account'
                    : 'I Don\'t Have An Account',
                style: TextStyle(color: Colors.orange),
              ),
            )
          ],
        ),
      ),
    );
  }
}
