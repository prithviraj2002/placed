import 'dart:ffi';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/constants/placed_strings.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/widgets/custom_drop_down.dart';
import 'package:placed_mobile_app/widgets/custom_text_field.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';
import '../../../../constants/placed_dimensions.dart';
import '../../../../utils/utils.dart';
import '../../controller/profile_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PersonalTab extends StatefulWidget {
  TabController tabController;
  ProfileController controller;

  PersonalTab(
      {required this.controller, required this.tabController, super.key});

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  final formKey = GlobalKey<FormState>();
  DateRangePickerController dateController = DateRangePickerController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController IUController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController countryCodeController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController AddressController = TextEditingController();

  TextEditingController GithubLinkController = TextEditingController();

  TextEditingController LinkedinLinkController = TextEditingController();

  TextEditingController OtherWebsiteLinkController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  DateTime dateTime = DateTime.now();

  String selectedDate = 'Date of Birth';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    IUController.dispose();
    phoneNumberController.dispose();
    countryCodeController.dispose();
    dateOfBirthController.dispose();
    AddressController.dispose();
    GithubLinkController.dispose();
    LinkedinLinkController.dispose();
    OtherWebsiteLinkController.dispose();
    genderController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () async{
                      await Utils.chooseImage('gallery').then((value) {
                        widget.controller.setImagePath(value);
                      });
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/default_profile_image.png'),
                          // replace with your image
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Obx(() => widget.controller.imagePath.isEmpty
                          ? Container()
                          : Image.file(File(widget.controller.imagePath.value),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Positioned(
                    bottom: 2.0,
                    right: 2.0,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        icon: Image.asset('assets/edit_image_photo.png'),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Text Fields
              CustomTextFieldForm(
                  bgColor: PlacedColors.PrimaryWhite,
                  hintText: 'Full name',
                  textInputType: TextInputType.text,
                  validator: (val) => val!.isEmpty
                      ? 'Empty name'
                      : val.length < 2
                          ? 'Invalid name'
                          : null,
                  controller: nameController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  bgColor: PlacedColors.PrimaryWhite,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Empty Email';
                    } else if (!val.contains('@') || !val.contains('indus')) {
                      return 'Enter a valid Indus Id';
                    }
                    return null;
                  },
                  controller: emailController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: PlacedColors.PrimaryWhite,
                          border: Border.all(color: PlacedColors.PrimaryBlueLight1),
                          borderRadius: BorderRadius.circular(10)),
                      child: const CountryCodePicker(
                        boxDecoration: BoxDecoration(color: Colors.white),
                        //Color(0xFFB5D8F6)
                        initialSelection: 'IN',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 2,
                    child: CustomTextFieldForm(
                        hintText: 'Phone number',
                        textInputType: TextInputType.number,
                        bgColor: PlacedColors.PrimaryWhite,
                        validator: (val) => val!.isEmpty
                            ? 'Empty number'
                            : val.length < 10
                                ? 'Invalid number'
                                : null,
                        controller: phoneNumberController,
                        obscureText: false),
                  ),
                ],
              ),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Enrollment number',
                  textInputType: TextInputType.text,
                  bgColor: PlacedColors.PrimaryWhite,
                  validator: (val) => val!.isEmpty
                      ? 'Empty IU'
                      : val.length != 12
                          ? 'Invalid IU'
                          : null,
                  controller: IUController,
                  obscureText: false),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: PlacedColors.PrimaryBlueLight1)
                ),
                child: CustomDropDown(
                  dropDownOption: PlacedStrings.GenderOption().map((
                      String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  text: widget.controller.gender.isEmpty ? 'Gender' : widget.controller.gender.value,
                ),
              ),
              const SizedBox(height: 16),
              //ToDo: Implement generic Date picker
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          surfaceTintColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 20,),
                                SfDateRangePicker(
                                  showNavigationArrow: true,
                                  controller: dateController,
                                  selectionColor: PlacedColors.PrimaryBlueMain,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(onPressed: () {
                                      setState(() {
                                        selectedDate = DateFormat('dd-MM-yyyy').format(dateController.selectedDate!).toString();
                                      });
                                      Navigator.pop(context);
                                    }, child: Text('OK')),
                                    TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Cancel'))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: PlacedColors.PrimaryBlueLight1),
                    color: PlacedColors.PrimaryWhite,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: selectedDate != 'Date of Birth' ? PlacedColors.PrimaryBlack : PlacedColors.PrimaryGrey3,
                        ),
                      ),
                      Icon(
                        Icons.edit_calendar_outlined,
                        color: PlacedColors.PrimaryGrey3,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Descriptive Text Field
              //ToDo: Increase the size of the address text field according to the design.
              CustomTextFieldForm(
                  hintText: 'Residential address',
                  textInputType: TextInputType.text,
                  bgColor: PlacedColors.PrimaryWhite,
                  validator: (val) => val!.length == 0
                      ? 'Empty Address'
                      : val.length < 2
                          ? 'Invalid Address'
                          : null,
                  controller: AddressController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Github link',
                  bgColor: PlacedColors.PrimaryWhite,
                  textInputType: TextInputType.text,
                  validator: (val) => val!.length == 0
                      ? 'Empty Link'
                      : val.length < 2
                          ? 'Invalid Link'
                          : null,
                  controller: GithubLinkController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'LinkedIn Profile link',
                  textInputType: TextInputType.text,
                  bgColor: PlacedColors.PrimaryWhite,
                  validator: (val) => val!.length == 0
                      ? 'Empty Link'
                      : val.length < 2
                          ? 'Invalid Link'
                          : null,
                  controller: LinkedinLinkController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Other Website link (optional)',
                  textInputType: TextInputType.text,
                  bgColor: PlacedColors.PrimaryWhite,
                  validator: (val) {
                    return null;
                  },
                  controller: OtherWebsiteLinkController,
                  obscureText: false),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GradiantButton(
          onPressed: () {
            if (widget.tabController.index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));
            } else {
              if (formKey.currentState!.validate()) {
                widget.controller.name.value = nameController.text;
                widget.controller.email.value = emailController.text;
                widget.controller.phoneNumber.value =
                    phoneNumberController.text;
                widget.controller.IU.value = IUController.text;
                widget.controller.address.value = AddressController.text;
                widget.controller.githubProfile.value =
                    GithubLinkController.text;
                widget.controller.linkedinProfile.value =
                    LinkedinLinkController.text;
                widget.controller.otherLink.value =
                    OtherWebsiteLinkController.text;
                widget.tabController
                    .animateTo((widget.tabController.index + 1));
                widget.controller.dateOfBirth.value = selectedDate == 'Date of Birth' ? DateTime.now().toString() : selectedDate;
              }
            }
          },
          widget: Text('Save & Continue', style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),),
        ),
      ),
    );
  }
}

