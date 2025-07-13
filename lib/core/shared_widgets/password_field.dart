// import 'package:graduationproject/core/constants/imports.dart';
//
// import '../../generated/l10n.dart';
// class PasswordField extends StatefulWidget {
//   const PasswordField({
//     super.key,
//      this.onSaved,
//     required this.controller,
//     required this.onChanged,
//     required this.isPassword,
//   });
//   final TextEditingController controller;
//   final void Function(String?)? onChanged;
//   final bool isPassword;
//   final void Function(String?)? onSaved;
//   @override
//   State<PasswordField> createState() => _PasswordFieldState();
// }
//
// class _PasswordFieldState extends State<PasswordField> {
//   bool obsecureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextFormField(
//       controller:widget.controller,
//       onChanged: widget.onChanged,
//       prefixIcon: Icon(
//       Icons.lock,
//       color: AppColors.secondaryColor,
//     ),
//       obscureText: obsecureText,
//       onSaved: widget.onSaved,
//       suffixIcon: GestureDetector(
//         onTap: () {
//           obsecureText = !obsecureText;
//           setState(() {});
//         },
//         child: obsecureText
//             ? Icon(
//                 Icons.remove_red_eye,
//                 color: AppColors.secondaryColor,
//               )
//             : const Icon(Icons.visibility_off),
//       ),
//       hintText: widget.isPassword ? S.of(context).password: S.of(context).confirm_password,
//       textInputType: TextInputType.visiblePassword,
//     );
//   }
// }
