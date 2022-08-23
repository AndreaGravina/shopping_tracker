import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_template/data/models/choice_item.dart';

mixin InputValidationUtil {
  String? validateRequired(String? value) {
    if (value!.isEmpty) {
      return tr('required_field');
    }
    return null;
  }

  String? validateCheck(bool? value) {
    if (value == null || value == false) {
      return tr('required_field');
    }
    return null;
  }

  String? validateRequiredDropDown(dynamic value) {
    if (value == null || (value is List<ChoiceItem> && value.isEmpty)) {
      return tr('required_field');
    }
    return null;
  }

  String? validateEmail(String? value) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern);

    if (value?.isEmpty ?? true) {
      return tr('required_field');
    } else if (!regex.hasMatch(value!)) {
      return tr('email_error');
    }
    return null;
  }

  String? validatePassword(String? value, {String? confirm}) {
    const String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!)) {
      return tr('password_error');
    }
    if (confirm != null && (value != confirm)) {
      return tr('password_not_match');
    }
    return null;
  }
}
