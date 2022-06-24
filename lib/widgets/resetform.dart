import 'package:flutter/material.dart';
import '/util/colors.dart';

class ResetForm extends StatelessWidget {
  const ResetForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
        ),
      ),
    );
  }
}
