import 'package:flutter/material.dart';
import 'package:flutter_template/theme/colors.dart' as custom_colors;
import 'package:flutter_template/utils/utils.dart' as utils;

class DefaultElevatedButton extends StatelessWidget {
  final Function function;
  final String title;
  final EdgeInsets? margin;
  final ButtonStyle? buttonStyle;
  final Color? textColor;

  const DefaultElevatedButton({
    Key? key,
    required this.function,
    required this.title,
    this.margin,
    this.buttonStyle,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ??
          EdgeInsets.only(
            left: utils.defaultEdgeInsets.left,
            right: utils.defaultEdgeInsets.right,
            bottom: utils.defaultEdgeInsets.bottom,
          ),
      child: ElevatedButton(
        onPressed: () => function(),
        style: buttonStyle ?? Theme.of(context).elevatedButtonTheme.style,
        child: FittedBox(
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: textColor ?? custom_colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
