import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/constant/route.constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      context.push(Routes.phoneNumber.path);
    }, child: Text("TEST"));
  }
}
