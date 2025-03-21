import 'package:flutter/cupertino.dart';
import 'package:doggie_chef/src/core/utils/icon_provider.dart';
import 'package:doggie_chef/src/core/utils/size_utils.dart';
import 'package:doggie_chef/src/core/utils/animated_button.dart';
import 'package:doggie_chef/src/core/utils/text_with_border.dart';

class AppButton extends StatelessWidget {
  final ButtonColors style;
  final bool isRound;
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Widget? child;
  final double? fontSize;
  

  const AppButton({
    super.key,
    required this.style,
    this.isRound = false,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.child,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        width: width ?? (isRound ? 63 : getWidth(context, baseSize: 131)),
        height: height ?? (isRound ? 63 : 45),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                isRound
                    ? IconProvider.littleButton.buildImageUrl()
                    : IconProvider.roundButton.buildImageUrl(),
              ),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                style.colors,
                BlendMode.modulate,
              )),
        ),
        child: Padding(
            padding: EdgeInsets.all(14),
            child: Center(
              child: child ?? TextWithBorder(text, fontSize: fontSize ?? 29, textAlign: TextAlign.center,),
            )),
      ),
    );
  }
}

enum ButtonColors {
  green(Color(0xFF90DD00)),
  purple(Color(0xFF8C34E0)),
  yellow(Color(0xFFFFE23D)),
  red(Color(0xFFDD0000));

  final Color colors;

  const ButtonColors(this.colors);
}
