import 'package:flutter/material.dart';
import 'package:point_marketing/src/features/auth/presentation/widgets/singinSection.dart';
import 'package:point_marketing/src/features/auth/presentation/widgets/vectorsSection.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            vectorsSection(),
            Image.asset("assets/pointlogo.png"),
            singInSection(formKey: _formKey, emailController: _emailController, passwordController: _passwordController),
          ],
        ),
      ),
    );
  }
}



