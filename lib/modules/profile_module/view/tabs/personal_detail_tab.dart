import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/widgets/custom_text_field.dart';
import '../../../../constants/placed_dimensions.dart';
import '../../../../utils/utils.dart';
import '../../controller/profile_controller.dart';

class PersonalTab extends StatefulWidget {
  const PersonalTab({super.key});

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  final ProfileController controller = Get.find<ProfileController>();

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

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/default_profile_image.png'),
                    // replace with your image
                    fit: BoxFit.cover,
                  ),
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
                    onPressed: () async {
                      await Utils.chooseImage('gallery').then((value) {
                        controller.setImagePath(value);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // Text Fields
          CustomTextFieldForm(
              hintText: 'Full Name',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty name'
                  : val.length < 2
                      ? 'Invalid name'
                      : null,
              controller: nameController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: emailController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: CountryCodePicker(
                  boxDecoration: BoxDecoration(color: Colors.blue),
                  backgroundColor: Color(0xFFB5D8F6),
                  initialSelection: 'IN',
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                flex: 2,
                child: CustomTextFieldForm(
                    hintText: 'Phone Number',
                    textInputType: TextInputType.text,
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
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Enrollment Number',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty IU'
                  : val.length < 13
                      ? 'Invalid IU'
                      : null,
              controller: nameController,
              obscureText: false),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: (){
              showCupertinoModalPopup(context: context, builder: (context){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.white,
                  child: CupertinoDatePicker(
                    initialDateTime: dateTime,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date){
                      setState(() {
                        dateTime = date;
                      });
                    },
                  ),
                );
              });
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: PlacedColors.bgColor,
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateTime.toString(),
                    style: TextStyle(
                      color: PlacedColors.textfield_text_color,
                    ),
                  ),
                  Icon(
                    Icons.edit_calendar_outlined,
                    color: PlacedColors.textfield_text_color,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          CustomTextFieldForm(
              hintText: dateOfBirthController.text,
              textInputType: TextInputType.datetime,
              validator: (val) => val!.length == 0
                  ? 'Empty name'
                  : val.length < 2
                      ? 'Invalid name'
                      : null,
              controller: dateOfBirthController,
              obscureText: false),
          SizedBox(height: 16.0),
          // Descriptive Text Field
          CustomTextFieldForm(
              hintText: 'Residential Address',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty name'
                  : val.length < 2
                      ? 'Invalid name'
                      : null,
              controller: AddressController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Github Link',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty Link'
                  : val.length < 2
                      ? 'Invalid Link'
                      : null,
              controller: GithubLinkController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'LinkedIn Profile Link',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty Link'
                  : val.length < 2
                      ? 'Invalid Link'
                      : null,
              controller: GithubLinkController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Other Website Link (optional)',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty Link'
                  : val.length < 2
                      ? 'Invalid Link'
                      : null,
              controller: GithubLinkController,
              obscureText: false),
        ],
      ),
    );
  }
}
