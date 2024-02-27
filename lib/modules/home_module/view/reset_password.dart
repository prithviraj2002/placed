import 'package:flutter/material.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showOldPassword = false;
  bool showNewPassword = false;
  
  
  void toggleOldPassword(){
    setState(() {
      showOldPassword = !showOldPassword;
    });
  }
  
  void toggleNewPassword(){
    setState(() {
      showNewPassword = !showNewPassword;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPasswordController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: oldPasswordController,
                obscureText: showOldPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Old Password',
                  suffixIcon: IconButton(onPressed: toggleOldPassword, icon: showOldPassword ? Icon(Icons.lock) : Icon(Icons.lock_open))
                ),
                validator: (String? val) {
                  if(val == null || val.isEmpty){
                    return 'Cannot have an empty value!';
                  }
                  else if(val.length < 7){
                    return 'Cannot have password less than 8 characters!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: passwordController,
                obscureText: showNewPassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter New Password',
                  suffixIcon: IconButton(onPressed: toggleNewPassword, icon: showNewPassword ? Icon(Icons.lock) : Icon(Icons.lock_open))
                ),
                validator: (String? val) {
                  if(val == null || val.isEmpty){
                    return 'Cannot have an empty value!';
                  }
                  else if(val.length < 7){
                    return 'Cannot have password less than 8 characters!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30,),
              TextButton(onPressed: () {
                if(formKey.currentState!.validate() && oldPasswordController.text.isNotEmpty && passwordController.text.isNotEmpty){
                  AppWriteAuth.resetPassword(passwordController.text, oldPasswordController.text).then((value) {
                    if(value.passwordUpdate.isNotEmpty){
                      showDialog(context: context, builder: (ctx) {
                        return AlertDialog(
                          title: Text('Password updated successfully!'),
                          content: Row(
                            children: [
                              Text('Going back to home screen'),
                              const SizedBox(width: 10,),
                              CircularProgressIndicator()
                            ],
                          ),
                        );
                      });
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
                      });
                    }
                    else if(value.passwordUpdate.isEmpty){
                      showDialog(context: context, builder: (ctx){
                        return AlertDialog(
                          title: Text('An error occurred!'),
                          content: Text('An error occurred while trying to reset password!'),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text('Close'))
                          ],
                        );
                      });
                    }
                  });
                }
              }, child: Text('Update Password'))
            ],
          ),
        ),
      ),
    );
  }
}
