import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/profile_module/controller/profile_controller.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../constants/placed_dimensions.dart';
import '../../../../widgets/custom_text_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EducationTab extends StatefulWidget {
  ProfileController controller;
  TabController tabController;
  EducationTab({required this.controller, required this.tabController, super.key});

  @override
  State<EducationTab> createState() => _EducationTabState();
}

class _EducationTabState extends State<EducationTab> {

  final formKey = GlobalKey<FormState>();

  TextEditingController courseController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController degreeBranchController = TextEditingController();
  TextEditingController yearOfGraduationController = TextEditingController();
  TextEditingController semController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  TextEditingController XMarksController = TextEditingController();
  TextEditingController XPassingYearController = TextEditingController();
  TextEditingController XBoardController = TextEditingController();

  TextEditingController XIIMarksController = TextEditingController();
  TextEditingController XIIPassingYearController = TextEditingController();
  TextEditingController boardController = TextEditingController();

  TextEditingController diplomaBranchController = TextEditingController();
  TextEditingController diplomaPassingYearController = TextEditingController();
  TextEditingController diplomaMarksController = TextEditingController();

  TextEditingController cgpaController = TextEditingController();
  TextEditingController activeBackLogController = TextEditingController();
  TextEditingController totalBackLogController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    courseController.dispose();
    degreeController.dispose();
    degreeBranchController.dispose();
    yearOfGraduationController.dispose();
    semController.dispose();
    branchController.dispose();
    XMarksController.dispose();
    XPassingYearController.dispose();
    XIIMarksController.dispose();
    XIIPassingYearController.dispose;
    diplomaBranchController.dispose();
    diplomaPassingYearController.dispose();
    diplomaMarksController.dispose();
    boardController.dispose();
    cgpaController.dispose();
    activeBackLogController.dispose();
    totalBackLogController.dispose();
    yearController.dispose();
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
              CustomTextFieldForm(
                  hintText: 'Current Semester*',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null || val.isEmpty){
                      return 'Empty semester';
                    }
                    else if(int.parse(val) < 1 || int.parse(val) > 8){
                      return 'Invalid semester';
                    }
                    return null;
                  },
                  controller: semController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'CGPA (till last semester)',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty CGPA';
                    }
                    return null;
                  },
                  controller: cgpaController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              //ToDo: Implement drop down to select from options
              CustomTextFieldForm(
                  hintText: 'Degree',
                  textInputType: TextInputType.text,
                  validator: (val) {
                   if(val == null){
                     return 'Empty Degree';
                   }
                   else if(val.length < 2){
                     return 'Invalid Degree';
                   }
                   return null;
                  },
                  controller: degreeController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              //ToDo: Implement drop down to select from options
              CustomTextFieldForm(
                  hintText: 'Branch',
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if(val == null){
                      return 'Empty Branch';
                    }
                    else if(val.length < 2 || val.isEmpty){
                      return 'Invalid Branch';
                    }
                    return null;
                  },
                  controller: degreeBranchController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Year',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty Year';
                    }
                    else if(val.isEmpty){
                      return 'Invalid Year';
                    }
                    return null;
                  },
                  controller: yearController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              //ToDo: Implement year picker
              CustomTextFieldForm(
                  hintText: 'Year of Graduation',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty Year of Graduation';
                    }
                    else if(val.isEmpty){
                      return 'Invalid Year of Graduation';
                    }
                    return null;
                  },
                  controller: yearOfGraduationController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Active Backlogs',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty Active Backlogs';
                    }
                    else if(val.isEmpty){
                      return 'Invalid Active Backlogs!';
                    }
                    return null;
                  },
                  controller: activeBackLogController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Total Backlogs',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty backlogs!';
                    }
                    return null;
                  },
                  controller: totalBackLogController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Percentage in 12th',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty 12th Marks';
                    }
                    return null;
                  },
                  controller: XIIMarksController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height,),
              CustomTextFieldForm(
                  hintText: 'Board in 12th',
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if(val == null){
                      return 'Empty board';
                    }
                    else if(val.isEmpty){
                      return 'Invalid board';
                    }
                    return null;
                  },
                  controller: boardController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: '12th Year of Passing',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty 12th year of passing!';
                    }
                    else if(val.isEmpty || val.length > 4){
                      return 'Invalid 12th year of passing';
                    }
                    return null;
                  },
                  controller: XIIPassingYearController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Percentage in 10th',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty 10th Marks';
                    }
                    return null;
                  },
                  controller: XMarksController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height,),
              CustomTextFieldForm(
                  hintText: 'Board in 10th',
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if(val == null){
                      return 'Empty board';
                    }
                    else if(val.isEmpty){
                      return 'Invalid board';
                    }
                    return null;
                  },
                  controller: XBoardController,
                  obscureText: false),
              SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: '10th Year of Passing',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if(val == null){
                      return 'Empty 10th year of passing!';
                    }
                    else if(val.isEmpty || val.length > 4){
                      return 'Invalid 10th year of passing';
                    }
                    return null;
                  },
                  controller: XPassingYearController,
                  obscureText: false),
              const SizedBox(height: 70,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GradiantButton(
          onPressed: () {
            if(widget.tabController.index == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            }else{
              if(formKey.currentState!.validate()){
                widget.controller.sem.value = int.parse(semController.text);
                widget.controller.cgpa.value = double.parse(cgpaController.text);
                widget.controller.degree.value = degreeController.text;
                widget.controller.course.value = branchController.text;
                widget.controller.engYearOfPassing.value = yearOfGraduationController.text;
                widget.controller.year.value = int.parse(yearController.text);
                widget.controller.activeBackLog.value = int.parse(activeBackLogController.text);
                widget.controller.totalBackLog.value = int.parse(totalBackLogController.text);

                widget.controller.XIIMarks!.value = double.parse(XIIMarksController.text);
                widget.controller.board.value = boardController.text;
                widget.controller.XIIPassingYear!.value = XIIPassingYearController.text;

                widget.controller.XMarks.value = double.parse(XMarksController.text);
                widget.controller.XPassingYear.value = XPassingYearController.text;
                widget.tabController.animateTo((widget.tabController.index + 1));
              }
            }
          },
          text: 'Save & Continue',
        ),
      ),
    );
  }
}
