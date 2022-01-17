import 'package:flutter/material.dart';
import 'package:motel/app/ui/color_helper.dart';

class RoundCornerTextInputWidget extends StatelessWidget {
  const RoundCornerTextInputWidget(
      {Key? key,
      this.onChange,
      this.hintText,
      this.initialValue,
      this.inputTextKey})
      : super(key: key);
  final ValueChanged<String>? onChange;
  final String? hintText;
  final String? initialValue;
  final Key? inputTextKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(38)),
        // border: Border.all(
        //   color: HexColor("#757575").withOpacity(0.6),
        // ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorHelper.dividerColor,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Container(
          height: 48,
          child: Center(
            child: TextFormField(
              key: inputTextKey,
              initialValue: initialValue ?? '',
              maxLines: 1,
              onChanged: (String txt) {
                if (onChange != null) onChange!(txt);
              },
              style: TextStyle(
                fontSize: 16,
                // color: AppTheme.dark_grey,
              ),
              cursorColor: ColorHelper.primaryColor,
              decoration: new InputDecoration(
                errorText: null,
                border: InputBorder.none,
                hintText: hintText ?? '',
                hintStyle: TextStyle(color: ColorHelper.disabledColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
