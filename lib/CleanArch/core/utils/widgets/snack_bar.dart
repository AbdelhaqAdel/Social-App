import 'package:flutter/material.dart';

showSnackBar({required context, required String message}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 2),
        content: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
