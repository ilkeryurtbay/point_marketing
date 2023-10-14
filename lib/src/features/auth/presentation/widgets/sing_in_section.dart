import 'package:flutter/material.dart';

class SignInSection extends StatefulWidget {
  const SignInSection({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : 
    _formKey = formKey,
    _emailController = emailController,
    _passwordController = passwordController,
    super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  _SignInSectionState createState() => _SignInSectionState();
}

class _SignInSectionState extends State<SignInSection> {
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    // TextEditingController'leri dinlemek için addListener kullanın
    widget._emailController.addListener(_clearEmailError);
    widget._passwordController.addListener(_clearPasswordError);
  }

  @override
  void dispose() {
    // Listener'ları temizleyin
    widget._emailController.removeListener(_clearEmailError);
    widget._passwordController.removeListener(_clearPasswordError);
    super.dispose();
  }

  void _clearEmailError() {
    if (emailError != null) {
      setState(() {
        emailError = null;
      });
    }
  }

  void _clearPasswordError() {
    if (passwordError != null) {
      setState(() {
        passwordError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: widget._formKey,
        child: Column(
          children: [
            TextFormField(
              controller: widget._emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    emailError = 'Please enter your email';
                  });
                  return null;
                } else if (!isValidEmail(value)) {
                  setState(() {
                    emailError = 'Please enter a valid email address';
                  });
                  return null;
                }
                return null;
              },
            ),
            if (emailError != null)
              Text(
                emailError!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            TextFormField(
              controller: widget._passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    passwordError = 'Please enter your password';
                  });
                  return null;
                }
                return null;
              },
            ),
            if (passwordError != null)
              Text(
                passwordError!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget._formKey.currentState!.validate()) {
                  // E-posta ve şifre doğrulaması burada yapılabilir
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }
}
