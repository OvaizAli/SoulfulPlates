import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/size_config.dart';

class BaseCheckBox extends StatelessWidget {
  const BaseCheckBox({Key? key,this.size,required this.isChecked,required this.onCheckedChanged}) : super(key: key);

  final double? size;
  final bool isChecked;
  final Function onCheckedChanged;
  static double defaultSize=35.rSize();
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension:size??defaultSize,
      child: FittedBox(
        child: Theme(
            data: Theme.of(context).copyWith( checkboxTheme: CheckboxThemeData(checkColor:MaterialStateProperty.resolveWith(getCheckColor),fillColor:MaterialStateProperty.resolveWith(getCheckBoxColor),side: const BorderSide(color:AppColor.blackColor, style: BorderStyle.solid,width: 1,)),),
            child: Checkbox(value: isChecked, onChanged: (val){onCheckedChanged(val);},
            ),
        ),
      ),
    );
  }

  Color getCheckBoxColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColor.whiteColor;
    }
    return AppColor.whiteColor;
  }

  Color getCheckColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColor.blackColor;
    }
    return AppColor.greenColor;
  }
}
