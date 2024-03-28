import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/controller/edit_profile_controller.dart';
import 'package:placed_mobile_app/modules/personal_details_module/controller/profile_controller.dart';

class CustomDropDown extends StatefulWidget {

  CustomDropDown({Key? key, required this.dropDownOption, required this.text, this.enabled = true}) : super(key: key);
  final List<DropdownMenuItem<String>> dropDownOption;
  final String text;
  bool enabled;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState(text,dropDownOption: dropDownOption);
}

class _CustomDropDownState extends State<CustomDropDown> {
  final String text;
  final List<DropdownMenuItem<String>> dropDownOption;
  EditProfileController editProfileController = Get.find<EditProfileController>();
  ProfileController profileController = Get.find<ProfileController>();

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
        color: PlacedColors.PrimaryWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            enableFeedback: widget.enabled,
            hint: Text(text, style: GoogleFonts.poppins(color: PlacedColors.PrimaryGrey3),),
            elevation: 16,
            isExpanded: true,
            style: GoogleFonts.poppins(
                color: PlacedColors.PrimaryBlack, fontSize: 16.0),
            onChanged: (String? changedValue) {
              my_services = changedValue;
              if(dropDownOption.first.value == 'Male'){
                editProfileController.gender.value = changedValue!;
                profileController.gender.value = changedValue;
                print('Value from drop down button(gender) ${editProfileController.gender.value}');
              }
              if(dropDownOption.first.value == 'B.Tech'){
                editProfileController.degree.value = changedValue!;
                profileController.degree.value = changedValue;
                print('Value from drop down button(degree) ${editProfileController.degree.value}');
              }
              if(dropDownOption.first.value == 'CSE'){
                editProfileController.course.value = changedValue!;
                profileController.course.value = changedValue;
                print('Value from drop down button(course) ${editProfileController.course.value}');
              }
              setState(() {
                my_services;
                _onclicked(my_services);
              });
            },
            value: my_services,
            items: dropDownOption,
          ),
        ),
      ),
    );
  }
}
