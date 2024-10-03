import 'package:flutter/material.dart';

class ProfileCustomTextFormField extends StatelessWidget {
  const ProfileCustomTextFormField({super.key, required this.controller, required this.labelText, required this.icon});
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
                    controller: controller,
                    style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '$labelText can\'t be empty';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      labelText: labelText,
                      prefixIcon: Icon(
                       icon,
                       size: 25,
                      ),
                    
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
    );
  }
}