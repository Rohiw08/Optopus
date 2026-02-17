// Login Button
import 'package:flutter/material.dart';

Widget loginButton(formKey) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.deepPurpleAccent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (formKey.currentState!.validate()) {
          // ... Navigate To your Home Page
        }
      },
      child: const Text('Login'),
    ),
  );
}
