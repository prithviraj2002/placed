import 'package:flutter/material.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
        title: Text('Contact Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('KSR Swamy', style: TextStyle(fontSize: 18),),
            trailing: Text('+91 1234567890', style: TextStyle(fontSize: 18),),
          ),
          ListTile(
            title: Text('Harry', style: TextStyle(fontSize: 18),),
            trailing: Text('+91 1234567890', style: TextStyle(fontSize: 18),),
          )
        ],
      ),
    );
  }
}
