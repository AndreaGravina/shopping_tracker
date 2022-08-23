import 'package:flutter/material.dart';
import 'package:flutter_template/utils/input_validation_util.dart';
import 'package:flutter_template/theme/colors.dart' as custom_colors;

class DefaultTextField extends StatelessWidget with InputValidationUtil {
  final String title;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final Function? onTap;
  final Function? onSubmitted;
  final Function? onChanged;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final bool isRequired;
  final bool isEnabled;
  final bool isReadOnly;
  final bool obscureText;
  final bool autofocus;

  const DefaultTextField({
    Key? key,
    required this.title,
    required this.onSaved,
    this.controller,
    this.onTap,
    this.textInputType,
    this.validator,
    this.initialValue,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.textStyle,
    this.decoration,
    this.isRequired = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.obscureText = false,
    this.autofocus = false,
  }) : super(key: key);

  String _printTitle() {
    if (title.isEmpty) {
      return '';
    }
    return isRequired ? '$title *' : title;
  }

  @override
  Widget build(BuildContext context) {
    //set initial value
    if (initialValue != null && controller != null) {
      if (controller!.text.isEmpty) {
        controller!.text = initialValue!;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _printTitle(),
          style: textStyle ?? Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        TextFormField(
          onTap: onTap != null ? () => onTap!(context) : null,
          //se controller presente prende il valore controller.text
          initialValue: controller == null ? initialValue : null,
          keyboardType: textInputType ?? TextInputType.text,
          decoration: decoration ??
              const InputDecoration().applyDefaults(
                Theme.of(context).inputDecorationTheme,
              ),
          textInputAction: textInputAction ?? TextInputAction.next,
          maxLines: textInputType == TextInputType.multiline ? 5 : 1,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: custom_colors.black,
          ),
          controller: controller,
          validator: validator ?? (isRequired ? validateRequired : null),
          obscureText: obscureText,
          autofocus: autofocus,
          enabled: isEnabled,
          focusNode: focusNode,
          readOnly: isReadOnly,
          onFieldSubmitted: onSubmitted != null ? (value) => onSubmitted!(value) : null,
          onChanged: onChanged != null ? (value) => onChanged!(value) : null,
          onSaved: (value) => onSaved(value),
        ),
      ],
    );
  }
}
