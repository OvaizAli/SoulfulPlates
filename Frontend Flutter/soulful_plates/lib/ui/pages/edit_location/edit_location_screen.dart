import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:soulful_plates/constants/app_sized_box.dart';
// import 'package:map_address_picker/map_address_picker.dart';
// import 'package:map_address_picker/models/location_result.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/ui/widgets/app_text_field.dart';
import 'package:soulful_plates/ui/widgets/base_button.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../utils/utils.dart';
import '../../widgets/base_common_widget.dart';
import 'edit_location_controller.dart';

class EditLocationScreen extends GetView<EditLocationController>
    with BaseCommonWidget {
  EditLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        initState: (state) async {},
        builder: (EditLocationController model) {
          return Scaffold(
              appBar: AppBar(
                title: Text(model.isEdit ? "Update Location" : "Add Location"),
              ),
              backgroundColor: AppColor.whiteColor,
              body: SafeArea(child: getBody(context)));
        });
  }

  Widget getBody(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.rHorizontalSizedBox(),
            Text(
              'Address Label',
              style: AppTextStyles.textStyleBlackTwo12With400,
            ),
            8.rVerticalSizedBox(),
            AppTextField(
              controller: controller.nameController,
              hintText: 'Enter address label',
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MapLocationPicker(
                              apiKey: "AIzaSyBpqxES86sEkb8BuQ0_ipHAUfmERDVzXh0",
                              currentLatLng: const LatLng(29.146727, 76.464895),
                              popOnNextButtonTaped: true,
                              onNext: (GeocodingResult? result) {
                                if (result != null) {
                                  controller.address =
                                      result.formattedAddress ?? "";
                                  controller.lat =
                                      result.geometry.location.lat.toString() ??
                                          '';
                                  controller.long =
                                      result.geometry.location.lng.toString() ??
                                          '';
                                  controller.update();
                                }
                              },
                              onSuggestionSelected:
                                  (PlacesDetailsResponse? result) {
                                if (result != null) {
                                  controller.address =
                                      result.result.formattedAddress ?? "";
                                  controller.lat = result
                                          .result.geometry?.location.lat
                                          .toString() ??
                                      '';
                                  controller.long = result
                                          .result.geometry?.location.lng
                                          .toString() ??
                                      '';
                                  controller.update();
                                }
                              },
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Select Location'),
                  ),
                ),
              ],
            ).paddingAll4(),
            controller.address.isNullOrEmpty
                ? AppSizedBox.sizedBox0
                : Text(
                    controller.address,
                    style: AppTextStyles.textStyleBlack14With400,
                  ).paddingVertical8(),
            controller.address.isNullOrEmpty
                ? 8.rVerticalSizedBox()
                : AppSizedBox.sizedBox0,
            BaseButton(
              onSubmit: () {
                if (controller.nameController.text.isNotEmpty &&
                    controller.lat.isNotEmpty &&
                    controller.long.isNotEmpty) {
                  if (controller.isEdit) {
                    controller.editAddress();
                  } else {
                    controller.addAddress();
                  }
                } else {
                  Utils.showSuccessToast(
                      'Please fill in all required fields.', true);
                }
              },
              text: "Add location",
            )
          ],
        ));
  }
}
