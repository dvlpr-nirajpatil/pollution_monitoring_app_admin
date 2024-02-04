import 'package:flutter/material.dart';

Padding customTextField({name, hint, is_pass = false, controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name ?? ""),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          obscureText: is_pass,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a $name';
            }
            return null;
          },
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    ),
  );
}
