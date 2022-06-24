import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odev/home.dart';
import 'package:odev/main.dart';
import 'package:odev/widgets/loginform.dart';
import '../util/user.dart';
import '/Screens/profile.dart';
import 'bottom_navbar.dart';
import 'email_verify.dart';

class EditProfile extends StatefulWidget {
  AppUser? appUser2;
   EditProfile({Key? key, required this.appUser2}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

TextEditingController yourNameController = TextEditingController();
TextEditingController yourEmailAddressController = TextEditingController();
TextEditingController yourPasswordController = TextEditingController();
TextEditingController yourPasswordAgainController = TextEditingController();
TextEditingController yourBioController = TextEditingController();
PlatformFile? pickedFile;
File? file;
UploadTask? uploadTask;

class _EditProfileState extends State<EditProfile> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final result = await FilePicker.platform
                        .pickFiles(type: FileType.image, allowMultiple: false);
                    if (mounted) {
                      pickedFile = result?.files.single;
                      setState(() {
                        file = File(pickedFile!.path!);
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      (() {
                      if (widget.appUser2!.userPhotoUrl == '-') {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('images/guest-user.jpg'),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(widget.appUser2!.userPhotoUrl),
                              ),
                            ),
                          ),
                        );
                      }
                    }()),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              file == null
                  ? Container()
                  : Column(
                      children: [
                        const Text('Your New Profile Photo'),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.file(file!, fit: BoxFit.contain),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            uploadTask =
                                storageRef.child(file!.path).putFile(file!);
                            final snapshot =
                                await uploadTask!.whenComplete(() => null);
                            final url = await snapshot.ref.getDownloadURL();
                            firestore
                                .collection('users')
                                .doc(appUser!.userUid)
                                .update({'userPhotoUrl': url});
                          },
                          child: const Text('Save'),
                        )
                      ],
                    ),
              const SizedBox(height: 30),
              buildTextField(
                "Full Name",
                "Please enter your name",
                false,
                yourNameController,
              ),
              buildTextField(
                "Bio Text",
                "Please enter bio",
                false,
                yourBioController,
              ),
              (() {
                if (appUser!.emailVerified) {
                  return Column(
                    children: [
                      buildTextField(
                        "Email",
                        "Please enter your email address",
                        false,
                        yourEmailAddressController,
                      ),
                      buildTextField(
                        "Password",
                        "Please enter your password",
                        true,
                        yourPasswordController,
                      ),
                      buildTextField(
                        "Confirm Password",
                        "Please enter your password again",
                        true,
                        yourPasswordAgainController,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text('''
If you want to change email and password, please verify your email address'''),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailVerify(),
                                ));
                          },
                          child: const Text('Verify Email'))
                    ],
                  );
                }
              }()),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(appUser2: appUser)));
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      firestore
                            .collection('users')
                            .doc(appUser!.userUid)
                            .update({
                          'userName': yourNameController.text,
                          'bioText': yourBioController.text,
                        });
                      if (appUser!.emailVerified) {
                        auth.currentUser!
                            .updateEmail(yourEmailAddressController.text);
                        auth.currentUser!
                            .updatePassword(yourPasswordController.text);
                        firestore
                            .collection('users')
                            .doc(appUser!.userUid)
                            .update({
                          'userName': yourNameController.text,
                          'userEmail': yourEmailAddressController.text,
                          'password': yourPasswordController.text,
                        });
                        Fluttertoast.showToast(msg: 'Updated');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      auth.signOut();
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBar(),
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (appUser!.emailVerified) {
                        auth.currentUser!.delete();
                        Fluttertoast.showToast(msg: 'Deleted your account');
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Your email did not verified');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmailVerify(),
                            ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelT, String place, bool isPassword,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPassword ? isObscure : false,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelT,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: place,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
