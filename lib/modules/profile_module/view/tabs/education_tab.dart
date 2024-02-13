import 'package:flutter/material.dart';
import '../../../../constants/placed_dimensions.dart';
import '../../../../widgets/custom_text_field.dart';

class EducationTab extends StatefulWidget {
  @override
  State<EducationTab> createState() => _EducationTabState();
}

class _EducationTabState extends State<EducationTab> {
  TextEditingController courseController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController degreeBranchController = TextEditingController();
  TextEditingController yearOfGraduationController = TextEditingController();
  TextEditingController semController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController XMarksController = TextEditingController();
  TextEditingController XPassingYearController = TextEditingController();
  TextEditingController XIIMarksController = TextEditingController();
  TextEditingController XIIPassingYearController = TextEditingController();
  TextEditingController diplomaBranchController = TextEditingController();
  TextEditingController diplomaPassingYearController = TextEditingController();
  TextEditingController diplomaMarksController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController boardController = TextEditingController();
  TextEditingController engYearOfPassingController = TextEditingController();
  TextEditingController cgpaController = TextEditingController();
  TextEditingController activeBackLogController = TextEditingController();
  TextEditingController totalBackLogController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextFieldForm(
              hintText: 'Current Semester*',
              textInputType: TextInputType.number,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: semController,
              obscureText: false),
          const SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'CGPA (till last semester)',
              textInputType: TextInputType.number,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: cgpaController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Degree',
              textInputType: TextInputType.text,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: degreeController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Branch',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: degreeBranchController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Year of Graduation',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: branchController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Active Backlogs',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: yearOfGraduationController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Total Backlogs',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: activeBackLogController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Percentage in 12th',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: totalBackLogController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height,),
          CustomTextFieldForm(
              hintText: 'Board in 12th',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: XIIMarksController,
              obscureText: false),
          SizedBox(height: PlacedDimens.textfield_space_height),
          CustomTextFieldForm(
              hintText: 'Year of Passing',
              textInputType: TextInputType.emailAddress,
              validator: (val) => val!.length == 0
                  ? 'Empty mail'
                  : val.length < 2
                      ? 'Invalid mail'
                      : null,
              controller: boardController,
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
              controller: XIIPassingYearController,
              obscureText: false),
        ],
      ),
    );
  }
}
