import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_dimensions.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/profile_module/controller/profile_controller.dart';
import '../../../utils/utils.dart';

class ProfileCreationScreen extends StatefulWidget {
  ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController IUController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController semController = TextEditingController();
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    IUController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your profile'),
        scrolledUnderElevation: 0.0,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: PlacedDimens.dimens10,
                horizontal: PlacedDimens.dimens10),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(75)),
                    child: GestureDetector(
                      onTap: () async {
                        await Utils.chooseImage('gallery').then((value) {
                          controller.setImagePath(value);
                        });
                      },
                      child: controller.imagePath.value.isEmpty
                          ? const Stack(children: [
                              Icon(
                                Icons.person,
                                size: 150,
                              ),
                              Positioned(
                                  top: 145,
                                  left: 145,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                  ))
                            ])
                          : ClipOval(
                              child: Image.file(
                                File(controller.imagePath.value),
                                height: 175,
                                width: 175,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Tap above to add an image',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Name text field
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Date of birth controller
                TextFormField(
                  controller: dateOfBirthController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date of birth',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Date of birth cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),


                //email text field
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email cannot have empty value';
                    }
                    if (!value.contains('@iite.indusuni.ac.in')) {
                      return 'Not a valid indus email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //IU number textfield
                TextFormField(
                  controller: IUController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'IU number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'IU number cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //phone number field
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        //ToDo: Add view pdf functionality
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        height: 55,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                            color: Colors.black12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            controller.selectedResumePath.isEmpty
                                ? const Text('Select Resume')
                                : const Text('Resume selected!'),
                            const SizedBox(
                              width: 10,
                            ),
                            controller.selectedResumePath.isEmpty
                                ? const Icon(
                                    Icons.file_copy_outlined,
                                  )
                                : const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.getResumePdf();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.save,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                //Course text field
                TextFormField(
                  controller: courseController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'course',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'course cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Degree text field
                TextFormField(
                  controller: degreeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Degree',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Degreee cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Year text field
                TextFormField(
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'year',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'year cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //sem text field
                TextFormField(
                  controller: semController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'sem',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'sem cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //X Marks text field
                TextFormField(
                  controller: XMarksController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'X marks',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'X Marks cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //XPassing year text field
                TextFormField(
                  controller: XPassingYearController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'X Passing year',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'X passing year cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //XIIMarks text field
                TextFormField(
                  controller: XIIMarksController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'XII Marks',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'XII Marks cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //XIIPassingYear text field
                TextFormField(
                  controller: XIIPassingYearController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'XII Passing year',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'XII passing year cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Diploma branch text field
                TextFormField(
                  controller: diplomaBranchController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Diploma branch',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Diploma branch cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Diploma passing year controller
                TextFormField(
                  controller: diplomaPassingYearController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Diploma Passing year',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Diploma passing year cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Diploma marks controller
                TextFormField(
                  controller: diplomaMarksController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Diploma marks',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Diploma marks cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Gender Text field
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Gender',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Gender cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Board text field
                TextFormField(
                  controller: boardController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Board',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Board cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Eng year of passing
                TextFormField(
                  controller: engYearOfPassingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Engineering year of passing',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Year of passing cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //cgpa text field
                TextFormField(
                  controller: cgpaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'cgpa',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'cgpa cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //Active backlog
                TextFormField(
                  controller: activeBackLogController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Active backlog',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'active back log cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //total backlog
                TextFormField(
                  controller: totalBackLogController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Total back log',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Total backlog cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //address
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address cannot have empty value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          controller.uploadProfileImage().then((value) {
            if (value.$createdAt.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Profile image uploaded successfully!'),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                ],
              )));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('An error occurred!'),
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  )
                ],
              )));
            }
          });
          controller.uploadResume().then((value) {
            if (value.$createdAt.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Resume uploaded successfully!'),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                ],
              )));
            } else if (value.$createdAt.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('An error occurred!'),
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  )
                ],
              )));
            }
          });
          controller.name.value = nameController.text;
          controller.email.value = emailController.text;
          controller.dateOfBirth.value = dateOfBirthController.text;
          controller.IU.value = IUController.text;
          controller.phoneNumber.value = phoneNumberController.text;
          controller.course.value = courseController.text;
          controller.degree.value = degreeController.text;
          controller.year.value = int.parse(yearController.text);
          controller.sem.value = int.parse(semController.text);
          controller.XMarks.value = double.parse(XMarksController.text);
          controller.XPassingYear.value = XPassingYearController.text;
          controller.XIIMarks!.value = double.parse(XIIMarksController.text);
          controller.XIIPassingYear!.value = XIIPassingYearController.text;
          controller.diplomaBranch!.value = diplomaBranchController.text;
          controller.diplomaPassingYear!.value = diplomaBranchController.text;
          controller.diplomaPassingYear!.value = diplomaPassingYearController.text;
          controller.diplomaMarks!.value = double.parse(diplomaMarksController.text);
          controller.gender.value = genderController.text;
          controller.engYearOfPassing.value = engYearOfPassingController.text;
          controller.cgpa.value = double.parse(cgpaController.text);
          controller.activeBackLog.value = int.parse(activeBackLogController.text);
          controller.totalBackLog.value = int.parse(totalBackLogController.text);
          controller.address.value = addressController.text;
          controller.createProfileAndUpload().then((value) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
            if (value.$createdAt.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Profile created successfully!'),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                ],
              )));
            } else if (value.$createdAt.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('An error occurred!'),
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  )
                ],
              )));
            }
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent),
          child: const Center(
            child: Text(
              'Submit',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
