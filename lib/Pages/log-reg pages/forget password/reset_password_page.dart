// import 'package:flutter/material.dart';

// class ResetPasswordWithEmailPage extends StatelessWidget {
//   ResetPasswordWithEmailPage({super.key});

//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: MyAppBar(title: "Reset Password"),
//       body: Form(
//         key: formKey,
//         child: ListView(
//           primary: false,
//           padding: EdgeInsets.all(20),
//           children: [
//             blackText("New password", 15),
//             SignUpTextField(
//               padding: EdgeInsets.all(0),
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//             ),
//             SizedBox(height: 20),
//             blackText("Confirm New Password", 15),
//             SignUpTextField(
//               padding: EdgeInsets.all(0),
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//             ),
//             SizedBox(height: 50),
//             WallpepredBTN(
//               text: "Save",
//               haveWallpaper: false,
//               width: 0.75 * w,
//               onTap: () {
//                 if (formKey.currentState!.validate()) {}
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
