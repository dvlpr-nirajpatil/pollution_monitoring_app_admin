import 'package:flutter/material.dart';
import 'package:rsm/consts/typography.dart';
import 'package:rsm/views/shared_widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              "Create an account".text.fontFamily(semibold).size(22).make(),
              10.heightBox,
              customTextField(name: "Full Name", hint: "Enter your full name"),
              customTextField(name: "Email", hint: "Enter Email"),
              customTextField(
                  name: "Password", hint: "Enter your password", is_pass: true),
              const SizedBox(
                height: 20,
              ),
              FilledButton(onPressed: () {}, child: const Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
