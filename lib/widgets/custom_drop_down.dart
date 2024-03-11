import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class CustomDropDown extends StatefulWidget {

  const CustomDropDown({Key? key, required this.dropDownOption, required this.text}) : super(key: key);
  final List<DropdownMenuItem<String>> dropDownOption;
  final String text;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState(text,dropDownOption: dropDownOption);
}

class _CustomDropDownState extends State<CustomDropDown> {
  final String text;
  final List<DropdownMenuItem<String>> dropDownOption;

  var my_services;

  _CustomDropDownState(this.text, {required this.dropDownOption});

  _onclicked(value) {
    if (kDebugMode) {
      print('Clicked...$value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFE5ECF6),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(text),
            elevation: 16,
            isExpanded: true,
            style: TextStyle(
                color: PlacedColors.textfield_text_color, fontSize: 16.0),
            onChanged: null,
            value: my_services,
            items: dropDownOption,
          ),
        ),
      ),
    );
  }
}
