import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/defaultDropDown.dart';
import 'package:garage_app/widget/defaultTextInput.dart';
import 'package:garage_app/widget/textbutton.dart';
import 'package:garage_app/widget/titleWidget.dart';

class EditTicketScreen extends StatefulWidget {
  final bool isEditMode;
  const EditTicketScreen({super.key, this.isEditMode = false});

  @override
  State<EditTicketScreen> createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  List<PlatformFile> mediaFiles = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subCategoryController = TextEditingController();
  String category = "";
  String subCategory = "";

  String priority = "";
  String location = "";
  String callType = "";
  String equipment = "";
  String component = "";

  final List<String> subCategoryOptions = [
    "Building Structure",
    "Compressor & Air",
    "CarWash",
  ];

  final List<String> categoryOptions = [
    "Building Structure",
    "Compressor & Air",
    "CarWash",
  ];

  final List<String> priorityOptions = ["High", "Medium", "Low"];
  final List<String> locationOptions = [
    "Location 1",
    "Location 2",
    "Location 3",
  ];
  final List<String> callTypeOptions = ["Type 1", "Type 2", "Type 3"];
  final List<String> equipmentOptions = [
    "Equipment 1",
    "Equipment 2",
    "Equipment 3",
  ];
  final List<String> componentOptions = [
    "Component 1",
    "Component 2",
    "Component 3",
  ];

  Future<void> pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mp3', 'wav'],
      allowMultiple: true,
      withData: true,
    );

    if (result != null) {
      setState(() {
        mediaFiles.addAll(result.files);
      });
    }
  }

  void removeMedia(int index) {
    setState(() {
      mediaFiles.removeAt(index);
    });
  }

  Widget buildMediaPreview(PlatformFile file, int index) {
    Widget filePreview;
    if (file.bytes != null) {
      if (['jpg', 'jpeg', 'png'].contains(file.extension)) {
        filePreview = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: MemoryImage(file.bytes!),
              fit: BoxFit.cover,
            ),
          ),
        );
      } else if (['mp4', 'mov'].contains(file.extension)) {
        filePreview = Icon(Icons.videocam, color: AppColor.mainColor, size: 30);
      } else if (['mp3', 'wav', 'm4a'].contains(file.extension)) {
        filePreview = Icon(
          Icons.audiotrack,
          color: AppColor.mainColor,
          size: 30,
        );
      } else {
        filePreview = Icon(
          Icons.insert_drive_file,
          color: Colors.grey,
          size: 30,
        );
      }
    } else {
      filePreview = Icon(Icons.insert_drive_file, color: Colors.grey, size: 30);
    }

    return Stack(
      clipBehavior: Clip.none,

      alignment: Alignment.topRight,
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: AppColor.imageContainerBackground,
            border: Border.all(color: AppColor.blueColor, width: 1.5),

            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: filePreview),
        ),
        Positioned(
          top: -5,
          right: 0,
          child: GestureDetector(
            onTap: () => removeMedia(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blueColorWithOpacity10,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.close,
                size: 16,
                color: AppColor.mainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: widget.isEditMode ? "Edit Ticket" : "Raise Ticket",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TitleWidget(
                val: widget.isEditMode ? "Ticket Details" : "New Ticket",
                fontSize: 14,
                fontFamily: AppData.poppinsMedium,
                color: AppColor.blackText,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),

              DefaultTextInput(
                hint: "Type",
                label: "Subject",
                onChange: (value) {
                  setState(() {
                    _subCategoryController.text = value;
                  });
                },
                validator: AppData.nameValidation(_subCategoryController.text),
                errorMsg: AppData.nameErrorMsg(
                  _subCategoryController.text,
                  "Subject",
                ),
              ),

              SizedBox(height: getProportionateScreenHeight(16)),

              DefaultDropDown<String>(
                hint: "Choose",
                label: "Category",
                onChange: (value) {
                  setState(() {
                    category = value!;
                  });
                },
                value: category,
                listValues: categoryOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(category),
                errorMsg: AppData.nameErrorMsg(category, "Category"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              DefaultDropDown<String>(
                hint: "Choose",
                label: "Sub Category",
                onChange: (value) {
                  setState(() {
                    subCategory = value!;
                  });
                },
                value: subCategory,
                listValues: subCategoryOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(subCategory),
                errorMsg: AppData.nameErrorMsg(subCategory, "Sub Category"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              DefaultDropDown<String>(
                hint: "Choose",
                label: "Priority (SLA)",
                onChange: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
                value: priority,
                listValues: priorityOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(priority),
                errorMsg: AppData.nameErrorMsg(priority, "Priority (SLA)"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              // Location (Dropdown)
              DefaultDropDown<String>(
                hint: "Choose",
                label: "Location",
                onChange: (value) {
                  setState(() {
                    location = value!;
                  });
                },
                value: location,
                listValues: locationOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(location),
                errorMsg: AppData.nameErrorMsg(location, "Location"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              // Call Type (Dropdown)
              DefaultDropDown<String>(
                hint: "Choose",
                label: "Call Type",
                onChange: (value) {
                  setState(() {
                    callType = value!;
                  });
                },
                value: callType,
                listValues: callTypeOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(callType),
                errorMsg: AppData.nameErrorMsg(callType, "Call Type"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              // Equipment (Dropdown)
              DefaultDropDown<String>(
                hint: "Choose",
                label: "Equipment",
                onChange: (value) {
                  setState(() {
                    equipment = value!;
                  });
                },
                value: equipment,
                listValues: equipmentOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(equipment),
                errorMsg: AppData.nameErrorMsg(equipment, "Equipment"),
              ),

              SizedBox(height: getProportionateScreenHeight(16)),

              // Component (Dropdown)
              DefaultDropDown<String>(
                hint: "Choose",
                label: "Component",
                onChange: (value) {
                  setState(() {
                    component = value!;
                  });
                },
                value: component,
                listValues: componentOptions,
                getDisplayText: (value) => value,
                getValue: (value) => value,
                validator: AppData.nameValidation(component),
                errorMsg: AppData.nameErrorMsg(component, "Component"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/svg/attach_image_icon.svg'),
                  SizedBox(width: 5),
                  TextButtonWidget(onPressed: pickMedia, text: 'Attach Media'),
                ],
              ),
              if (mediaFiles.isNotEmpty) ...[
                SizedBox(height: getProportionateScreenHeight(16)),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      mediaFiles
                          .asMap()
                          .entries
                          .map(
                            (entry) =>
                                buildMediaPreview(entry.value, entry.key),
                          )
                          .toList(),
                ),
              ],
              SizedBox(height: getProportionateScreenHeight(16)),

              DefaultButton(
                text: widget.isEditMode ? "Update Ticket" : "Create Ticket",
                press: () {
                  if (_formKey.currentState!.validate() &&
                      category.isNotEmpty &&
                      subCategory.isNotEmpty &&
                      priority.isNotEmpty &&
                      location.isNotEmpty &&
                      callType.isNotEmpty &&
                      equipment.isNotEmpty &&
                      component.isNotEmpty) {
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePath.successScreen,
                      arguments: {
                        'title':
                            widget.isEditMode
                                ? 'Ticket has been updated'
                                : 'Ticket Raised!',
                        'subtitle': 'Ticket ID  0001',
                      },
                    );
                  } else {
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
