import 'package:flutter/material.dart';
import '/Screens/login.dart';
import '/util/colors.dart';
import '/util/dimensions.dart';
import '/util/styles.dart';
import '/widgets/resetform.dart';
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: kDefaultPadding,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
                'Forgot Password',
              style: titleText,
            ),
            SizedBox(height: 5,),
            Text(
                'Please enter you email address',
              style: textButton.copyWith(fontWeight: FontWeight.w600)
            ),
            SizedBox(height: 10,),
            ResetForm(),
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); //signup döndüğü şey oluyor text girseydin signupa bastığında yazdığın text gözükecekti
                      //we are telling the navigator to push something onto the stack and we gave the route
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Reset Password',
                        style: forgot,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
