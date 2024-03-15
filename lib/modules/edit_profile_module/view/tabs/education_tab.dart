import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:placed_mobile_app/constants/placed_dimensions.dart';
import 'package:placed_mobile_app/constants/placed_strings.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/controller/edit_profile_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/widgets/custom_drop_down.dart';
import 'package:placed_mobile_app/widgets/custom_text_field.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

class EditEducationTab extends StatefulWidget {
  EditProfileController controller;
  TabController tabController;
  Profile profile;

  EditEducationTab(
      {required this.controller, required this.tabController, required this.profile, super.key});

  @override
  State<EditEducationTab> createState() => _EditEducationTabState();
}

class _EditEducationTabState extends State<EditEducationTab> {

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
  void initState() {
    // TODO: implement initState
    super.initState();
    courseController = TextEditingController(text: widget.profile.course);
    degreeController = TextEditingController(text: widget.profile.degree);
    degreeBranchController = TextEditingController(text: widget.profile.course);
    yearOfGraduationController =
        TextEditingController(text: widget.profile.engYearOfPassing);
    semController = TextEditingController(text: widget.profile.sem.toString());
    branchController = TextEditingController(text: widget.profile.course);
    yearController =
        TextEditingController(text: widget.profile.year.toString());
    XMarksController =
        TextEditingController(text: widget.profile.XMarks.toString());
    XPassingYearController =
        TextEditingController(text: widget.profile.XPassingYear);
    XBoardController = TextEditingController(text: widget.profile.board);
    XIIMarksController =
        TextEditingController(text: widget.profile.XIIMarks.toString());
    XIIPassingYearController =
        TextEditingController(text: widget.profile.XIIPassingYear);
    boardController = TextEditingController(text: widget.profile.board);
    cgpaController =
        TextEditingController(text: widget.profile.cgpa.toString());
    activeBackLogController =
        TextEditingController(text: widget.profile.activeBackLog.toString());
    totalBackLogController =
        TextEditingController(text: widget.profile.totalBackLog.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFieldForm(
                  hintText: 'Current semester*',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Empty semester';
                    }
                    else if (int.parse(val) < 1 || int.parse(val) > 8) {
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
                    if (val == null) {
                      return 'Empty CGPA';
                    }
                    return null;
                  },
                  controller: cgpaController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomDropDown(
                dropDownOption: PlacedStrings.degreeOption().map((
                    String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                text: widget.profile.degree,
              ),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomDropDown(
                dropDownOption: PlacedStrings.branchOption().map((
                    String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                text: widget.profile.course,
              ),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Year',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty Year';
                    }
                    else if (val.isEmpty) {
                      return 'Invalid Year';
                    }
                    return null;
                  },
                  controller: yearController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              //ToDo: Implement year picker
              CustomTextFieldForm(
                  hintText: 'Year of Graduation',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty Year of Graduation';
                    }
                    else if (val.isEmpty) {
                      return 'Invalid Year of Graduation';
                    }
                    return null;
                  },
                  controller: yearOfGraduationController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Active Backlogs',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty Active Backlogs';
                    }
                    else if (val.isEmpty) {
                      return 'Invalid Active Backlogs!';
                    }
                    return null;
                  },
                  controller: activeBackLogController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Total Backlogs',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty backlogs!';
                    }
                    return null;
                  },
                  controller: totalBackLogController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Percentage in 12th',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty 12th Marks';
                    }
                    return null;
                  },
                  controller: XIIMarksController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height,),
              CustomTextFieldForm(
                  hintText: 'Board in 12th',
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty board';
                    }
                    else if (val.isEmpty) {
                      return 'Invalid board';
                    }
                    return null;
                  },
                  controller: boardController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: '12th Year of Passing',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty 12th year of passing!';
                    }
                    else if (val.isEmpty || val.length > 4) {
                      return 'Invalid 12th year of passing';
                    }
                    return null;
                  },
                  controller: XIIPassingYearController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: 'Percentage in 10th',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty 10th Marks';
                    }
                    return null;
                  },
                  controller: XMarksController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height,),
              CustomTextFieldForm(
                  hintText: 'Board in 10th',
                  textInputType: TextInputType.text,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty board';
                    }
                    else if (val.isEmpty) {
                      return 'Invalid board';
                    }
                    return null;
                  },
                  controller: XBoardController,
                  obscureText: false),
              const SizedBox(height: PlacedDimens.textfield_space_height),
              CustomTextFieldForm(
                  hintText: '10th Year of Passing',
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'Empty 10th year of passing!';
                    }
                    else if (val.isEmpty || val.length > 4) {
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
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        child: GradiantButton(
          onPressed: () {
            if (widget.tabController.index == 2) {
              Navigator.pop(context);
            }
            else {
              if (formKey.currentState!.validate()) {
                widget.controller.sem.value = int.parse(semController.text);
                widget.controller.cgpa.value =
                    double.parse(cgpaController.text);
                widget.controller.degree.value = degreeController.text;
                widget.controller.course.value = branchController.text;
                widget.controller.engYearOfPassing.value =
                    yearOfGraduationController.text;
                widget.controller.year.value = int.parse(yearController.text);
                widget.controller.activeBackLog.value =
                    int.parse(activeBackLogController.text);
                widget.controller.totalBackLog.value =
                    int.parse(totalBackLogController.text);

                widget.controller.XIIMarks!.value =
                    double.parse(XIIMarksController.text);
                widget.controller.board.value = boardController.text;
                widget.controller.XIIPassingYear!.value =
                    XIIPassingYearController.text;

                widget.controller.XMarks.value =
                    double.parse(XMarksController.text);
                widget.controller.XPassingYear.value =
                    XPassingYearController.text;
                widget.tabController.animateTo(
                    (widget.tabController.index + 1));
              }
            }
          },
          text: 'Continue',
        ),
      ),
    );
  }
}
