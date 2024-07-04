import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText; //Metin alanı boşken görünecek olan ipucu metnidir.
  final bool obscureText; //kullanıcının girdiği metni gizlemek için kullanılır
  final TextInputType keyboardType; //Metin girişi için klavye türünü belirtir.
  final Widget? suffixIcon; // Metin alanının sonunda görünecek olan simge
  final VoidCallback? onTap;
  final Widget? prefixIcon; // Metin alanının başında görünecek olan simge.
  final String? Function(String?)?
      validator; //Metin alanındaki veriyi doğrulamak için kullanılan fonksiyon.
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorMsg,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade300,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Color.fromARGB(255, 227, 52, 207)),
        errorText: errorMsg,
      ),
    );
  }
}
