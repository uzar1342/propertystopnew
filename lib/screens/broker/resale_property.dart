import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/models/request/add_property_request.dart';
import 'package:propertystop/services/network_service.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/custom_dialog.dart';

class ResalePropertyPage extends StatefulWidget {
  const ResalePropertyPage({Key? key}) : super(key: key);

  @override
  State<ResalePropertyPage> createState() => _ResalePropertyPageState();
}

class _ResalePropertyPageState extends State<ResalePropertyPage> {
  var _currentStep = 0;

  final _propertyDetailsFormKey = GlobalKey<FormBuilderState>();
  final _roomConfigurationsFormKey = GlobalKey<FormBuilderState>();
  final _floorPlansFormKey = GlobalKey<FormBuilderState>();
  final _nearbyPlacesFormKey = GlobalKey<FormBuilderState>();
  final _amenitiesFormKey = GlobalKey<FormBuilderState>();
  final _featuresFormKey = GlobalKey<FormBuilderState>();
  final _picturesFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Stepper(
                        physics: const ClampingScrollPhysics(),
                        type: StepperType.vertical,
                        steps: getSteps(),
                        currentStep: _currentStep,
                        onStepContinue: () {
                          if (_currentStep == getSteps().length - 1) {
                            // print("Last Step");
                          } else {
                            setState(() {
                              _currentStep += 1;
                            });
                          }
                        },
                        onStepCancel: _currentStep == 0
                            ? null
                            : () {
                                setState(() {
                                  _currentStep -= 1;
                                });
                              },
                        onStepTapped: (step) => setState(() {
                          _currentStep = step;
                        }),
                        controlsBuilder: (context, details) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: details.onStepContinue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                if (_currentStep != 0)
                                  Expanded(
                                    child: ElevatedButton(
                                      child: const Text(
                                        "Previous",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onPressed: details.onStepCancel,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        context.loaderOverlay.show();
                        var result = await NetworkService().addPropertyResale(
                            AddPropertyRequest(
                                addAppResalePropClient:
                                    "addAppResalePropClient",
                                mobileNumber: "mobileNumber",
                                propertyType: "propertyType",
                                projectName: "projectName",
                                propAbout: "propAbout",
                                buildFloors: "buildFloors",
                                propRooms: "propRooms",
                                propCarpetArea: "propCarpetArea",
                                propPrice: "propPrice"));
                        context.loaderOverlay.hide();

                        if (json.decode(result!)['success'] == "0") {
                          await Dialogs.infoDialog(
                            json.decode(result)['message'],
                          );
                          return;
                        } else {
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                            msg: "Details Saved Successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0,
                          );
                          return;
                        }
                      },
                      child: const Text(
                        "Save Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: constants.PRIMARY_COLOR,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        state: _currentStep > 0
            ? StepState.complete
            : _currentStep == 0
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 0,
        title: const Text("Property Details"),
        content: FormBuilder(
          key: _propertyDetailsFormKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Property Description",
                    style: TextStyle(
                      color: constants.PRIMARY_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FormBuilderTextField(
                name: "project_name",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Project Name",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderDropdown(
                name: "poject_type",
                items: [buildMenuItem("Commercial")],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Type",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "about_project",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "About Project",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Property Location",
                    style: TextStyle(
                      color: constants.PRIMARY_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FormBuilderTextField(
                name: "property_address",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Address",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "property_pincode",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Pincode",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "property_city",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "City",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "property_state",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "State",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "property_lat",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Google Maps Latitude",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "property_lng",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Google Maps Longitude",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Extra Information",
                    style: TextStyle(
                      color: constants.PRIMARY_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FormBuilderDropdown(
                name: "building_status",
                items: [buildMenuItem("Ready to Move")],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Building Status",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "building_age",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Building Age",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "building_wings",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Building Wings",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "building_floors",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Building Floors",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Builder Information",
                    style: TextStyle(
                      color: constants.PRIMARY_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FormBuilderTextField(
                name: "builder_name",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Builder Name",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "builder_maharera",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "MAHARERA Number",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderDateTimePicker(
                inputType: InputType.date,
                name: "builder_possession_date",
                format: DateFormat("MM-dd-yyyy"),
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Possession Date",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "builder_project_land_parcel",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Project Land Parcel",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      Step(
        state: _currentStep > 1
            ? StepState.complete
            : _currentStep == 1
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 1,
        title: const Text("Room Configurations"),
        content: FormBuilder(
          key: _roomConfigurationsFormKey,
          child: Column(
            children: [
              FormBuilderDropdown(
                name: "configuration",
                items: [
                  buildMenuItem("1 BHK"),
                  buildMenuItem("2 BHK"),
                  buildMenuItem("3 BHK"),
                  buildMenuItem("4 BHK"),
                  buildMenuItem("5 BHK"),
                  buildMenuItem("6 BHK"),
                  buildMenuItem("7 BHK"),
                  buildMenuItem("8 BHK")
                ],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Configuration",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "carpet_area",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Carpet Area (sqft)",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: "price",
                autocorrect: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Price",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderFilePicker(
                name: "layout_blue_print",
                maxFiles: 1,
                allowMultiple: false,
                allowCompression: true,
                previewImages: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Layout Blue Print",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderFilePicker(
                name: "layout_3d_print",
                maxFiles: 1,
                allowMultiple: false,
                allowCompression: true,
                previewImages: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Layout 3D Print",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      Step(
        state: _currentStep > 2
            ? StepState.complete
            : _currentStep == 2
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 2,
        title: const Text("Upload Floor Plans"),
        content: FormBuilder(
          key: _floorPlansFormKey,
          child: Column(
            children: [
              FormBuilderFilePicker(
                name: "floor_plans",
                maxFiles: 10,
                allowMultiple: true,
                allowCompression: true,
                previewImages: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Add Floor Plans",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      Step(
        state: _currentStep > 3
            ? StepState.complete
            : _currentStep == 3
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 3,
        title: const Text("Near By Places"),
        content: FormBuilder(
          key: _nearbyPlacesFormKey,
          initialValue: const {
            "is_park_garden": false,
            "is_amusementpark_resort": false,
            "is_school_playschool": false,
            "is_restaurants_bar": false,
            "is_railwaystation": false,
            "is_airport": false,
            "is_seashore": false,
            "is_bustop": false,
            "is_clubhouse_gamestation": false,
            "is_bank_atm": false,
            "is_popular_essential": false,
          },
          child: Column(
            children: [
              FormBuilderCheckbox(
                title: const Text(
                  "Park / Garden",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_park_garden",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_park_garden']?.value)
                FormBuilderTextField(
                  name: "park_garden",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Park / Garden",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Amusement Park / Resort",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_amusementpark_resort",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_amusementpark_resort']?.value)
                FormBuilderTextField(
                  name: "amusementpark_resort",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Amusement Park / Resort",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "School / Play School",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_school_playschool",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_school_playschool']?.value)
                FormBuilderTextField(
                  name: "school_playschool",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "School / Play School",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Restaurants / Bar",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_restaurants_bar",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_restaurants_bar']?.value)
                FormBuilderTextField(
                  name: "restaurants_bar",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Restaurants / Bar",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Railway Station",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_railwaystation",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_railwaystation']?.value)
                FormBuilderTextField(
                  name: "railwaystation",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Railway Station",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Airport",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_airport",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_airport']?.value)
                FormBuilderTextField(
                  name: "airport",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Airport",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Sea Shore",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_seashore",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_seashore']?.value)
                FormBuilderTextField(
                  name: "seashore",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Sea Shore",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Bus Stop",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_bustop",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey.currentState?.fields['is_bustop']?.value)
                FormBuilderTextField(
                  name: "bustop",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Bus Stop",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Clubhouse / Game Station",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_clubhouse_gamestation",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_clubhouse_gamestation']?.value)
                FormBuilderTextField(
                  name: "clubhouse_gamestation",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Clubhouse / Game Station",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Bank / ATM",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_bank_atm",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_bank_atm']?.value)
                FormBuilderTextField(
                  name: "bank_atm",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Bank / ATM",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckbox(
                title: const Text(
                  "Any Popular / Essential Place",
                  style: TextStyle(fontSize: 16),
                ),
                name: "is_popular_essential",
                onChanged: (checked) => setState(() {}),
              ),
              if (_nearbyPlacesFormKey.currentState != null &&
                  _nearbyPlacesFormKey
                      .currentState?.fields['is_popular_essential']?.value)
                FormBuilderTextField(
                  name: "popular_essential",
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: constants.FIELD_COLOR,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Popular / Essential Place",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      Step(
        state: _currentStep > 4
            ? StepState.complete
            : _currentStep == 4
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 4,
        title: const Text("Amenities"),
        content: FormBuilder(
          key: _amenitiesFormKey,
          child: Column(
            children: [
              FormBuilderFilterChip(
                name: "amenities",
                spacing: 8,
                decoration: const InputDecoration(
                  labelText: "Choose Amenities",
                ),
                options: getAmenities(),
              ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      Step(
        state: _currentStep > 5
            ? StepState.complete
            : _currentStep == 5
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 5,
        title: const Text("Property Feature"),
        content: FormBuilder(
          key: _featuresFormKey,
          child: Column(
            children: [
              FormBuilderFilterChip(
                name: "features",
                spacing: 8,
                decoration: const InputDecoration(
                  labelText: "Choose Features",
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                options: getAmenities(),
              ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      Step(
        state: _currentStep > 6
            ? StepState.complete
            : _currentStep == 6
                ? StepState.editing
                : StepState.indexed,
        isActive: _currentStep >= 6,
        title: const Text("Upload Pictures"),
        content: FormBuilder(
          key: _picturesFormKey,
          child: Column(
            children: [
              FormBuilderFilePicker(
                name: "pictures",
                maxFiles: 10,
                allowMultiple: true,
                allowCompression: true,
                previewImages: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: constants.FIELD_COLOR,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Add Pictures",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    ];
  }

  List<FormBuilderFieldOption> getAmenities() {
    return [
      const FormBuilderFieldOption(
        value: "Swimming Pool",
        child: Text("Swimming Pool"),
      ),
      const FormBuilderFieldOption(
        value: "Laundry Room",
        child: Text("Laundry Room"),
      ),
      const FormBuilderFieldOption(
        value: "Gym",
        child: Text("Gym"),
      ),
      const FormBuilderFieldOption(
        value: "Fire Alarm",
        child: Text("Fire Alarm"),
      ),
      const FormBuilderFieldOption(
        value: "Reserved Parking",
        child: Text("Reserved Parking"),
      ),
      const FormBuilderFieldOption(
        value: "Visitors Parking",
        child: Text("Visitor Parking"),
      ),
      const FormBuilderFieldOption(
        value: "CCTV Camera",
        child: Text("CCTV Camera"),
      ),
      const FormBuilderFieldOption(
        value: "Power Backup",
        child: Text("Power Backup"),
      ),
      const FormBuilderFieldOption(
        value: "Lift",
        child: Text("Lift"),
      ),
    ];
  }
}
