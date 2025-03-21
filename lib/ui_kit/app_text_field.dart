import 'package:doggie_chef/src/core/utils/animated_button.dart';
import 'package:doggie_chef/src/core/utils/app_icon.dart';
import 'package:doggie_chef/src/core/utils/icon_provider.dart';
import 'package:gap/gap.dart';
import 'package:doggie_chef/src/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doggie_chef/src/core/utils/text_with_border.dart';
import 'package:doggie_chef/ui_kit/app_button.dart';

class CountTextField extends StatelessWidget {
  const CountTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.setState,
  });

  final TextEditingController controller;
  final String title;
  final VoidCallback setState;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      controller.text =
                          (int.parse(controller.text) - 1).toString();
                    } else {
                      controller.text = "0";
                    }
                    setState();
                  },
                  child: AppIcon(asset: IconProvider.minus.buildImageUrl()),
                ),
                SizedBox(
                  width: getWidth(context, baseSize: 149),
                  child: AppTextField(
                    controller: controller,
                  ),
                ),
                AnimatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      controller.text =
                          (int.parse(controller.text) + 1).toString();
                    } else {
                      controller.text = "1";
                    }
                    setState();
                  },
                  child: AppIcon(asset: IconProvider.plus.buildImageUrl()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.title,
    this.backgrund = false,
    this.maxLines,
    this.flex = 0,
    this.isEdit = true,
    this.width = 75,
    this.onChanged,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? title;
  final bool backgrund;
  final int? maxLines;
  final int flex;
  final bool isEdit;
  final double width;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Expanded(flex: flex, child: TextWithBorder(title!, fontSize: 23)),
        if (title != null) const Gap(10),
        Expanded(
          flex: flex,
          child: SizedBox(
            width: width,
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: const TextStyle(
                color: Color(0xFF894406),
                fontSize: 17,
              ),
              readOnly: isEdit,
              maxLines: maxLines,
              textAlign: TextAlign.center,
              padding: EdgeInsets.symmetric(
                vertical: 6,
              ),
              decoration: !backgrund
                  ? null
                  : const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
          ),
        ),
      ],
    );
  }
}
