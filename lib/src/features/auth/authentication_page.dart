import 'package:flutter/material.dart';
import 'package:point_marketing/src/features/auth/presentation/widgets/sing_in_section.dart';
import 'package:point_marketing/src/features/auth/presentation/widgets/vectors_section.dart';

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
            VectorsSection(),
            Image.asset("assets/pointlogo.png"),
            SignInSection(formKey: _formKey, emailController: _emailController, passwordController: _passwordController),
          ],
        ),
      ),
    );
  }
}



