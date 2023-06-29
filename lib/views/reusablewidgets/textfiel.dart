// import 'package:flutter/material.dart';

// class ReusableTextField extends StatefulWidget {
//   final String? hintText;
//   final bool obscureText;
//   final TextEditingController? controller;
//   final Function(String) onChanged;
//   final Function() onTap;

//   const ReusableTextField(
//       {super.key,
//       required this.hintText,
//       this.obscureText = false,
//       required this.controller,
//       required this.onChanged,
//       required this.onTap});

//   @override
//   State<ReusableTextField> createState() => _ReusableTextFieldState();
// }

// class _ReusableTextFieldState extends State<ReusableTextField> {
//   String? _value = '';
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: (value) {
//         setState(() {
//           _value = value;
//         });
//         // if (widget.onChanged != null) {
//         //   widget.onChanged(_value);
//         // }
//       },
//       onTap: widget.onTap,
//       obscureText: widget.obscureText,
//       controller: widget.controller,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         border: const OutlineInputBorder(
//           gapPadding: 2,
//           borderSide: BorderSide(
//             width: 2,
//             color: Color(0xFF432a72),
//           ),
//         ),
//       ),
//     );
//   }
// }
