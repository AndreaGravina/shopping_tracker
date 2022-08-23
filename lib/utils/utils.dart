import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/utils/responsive_util.dart';
import 'package:flutter_template/theme/colors.dart' as custom_colors;
import 'package:flutter_template/utils/constants.dart' as constants;

EdgeInsets get defaultEdgeInsets {
  return EdgeInsets.only(
    top: 2.h,
    left: 2.w,
    right: 2.w,
    bottom: 4.h,
  );
}

Map<String, String> get basicHeaders {
  return {
    'Authorization': 'Basic ${constants.basicToken}',
  };
}

bool isFirstRoute(BuildContext context) {
  return ModalRoute.of(context)?.isFirst ?? false;
}

Widget buildErrorText(FormFieldState state) {
  return Container(
    margin: const EdgeInsets.only(top: 8.0, left: 16.0),
    child: Text(
      state.errorText ?? '',
      style: Theme.of(state.context).textTheme.bodyText2?.copyWith(
        color: Theme.of(state.context).colorScheme.secondary,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget buildImagePlaceholder() {
  return Container(
    decoration: const BoxDecoration(
      color: custom_colors.placeholderGray,
    ),
    child: Image.asset(
      'assets/images/event_placeholder.png',
      fit: BoxFit.contain,
    ),
  );
}

Widget buildProgressIndicator({
  Color customColor = custom_colors.red,
  bool small = false,
}) {
  return Center(
    child: small
        ? SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(customColor),
              strokeWidth: 2.0,
            ),
          )
        : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(customColor),
          ),
  );
}

Widget buildBackButton({
  required BuildContext ctx,
  Color customColor = custom_colors.black,
}) {
  return IconButton(
    onPressed: () {
      Navigator.of(ctx).pop();
    },
    icon: Image.asset(
      'assets/images/ic_arrow_back.png',
      width: 24.0,
      height: 24.0,
      color: customColor,
    ),
    splashRadius: 24.0,
  );
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<void> launchInBrowser(String url) async {
  final encoded = Uri.encodeFull(url);
  if (await canLaunch(encoded)) {
    await launch(
      encoded,
      forceSafariVC: false,
    );
  } else {
    print('Could not launch $encoded');
    //throw 'Could not launch $url';
  }
}

Future<void> launchEmail(String email, {Map<String, String>? params}) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: params != null ? encodeQueryParameters(params) : '',
  );
  final url = emailLaunchUri.toString();

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
    //throw 'Could not launch $url';
  }
}

Future<void> launchPhone(String number) async {
  final Uri phoneLaunchUri = Uri(
    scheme: 'tel',
    path: number,
  );
  final url = phoneLaunchUri.toString();

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
    //throw 'Could not launch $url';
  }
}

void showSnackBar({
  required BuildContext ctx,
  required String title,
  int? seconds,
}) {
  //remove previous visible snackbar
  ScaffoldMessenger.of(ctx).removeCurrentSnackBar();

  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      duration: Duration(seconds: seconds ?? 3),
      behavior: SnackBarBehavior.floating,
      content: Text(
        title,
        style: Theme.of(ctx).textTheme.bodyText1?.copyWith(
          color: custom_colors.white,
        ),
      ),
    ),
  );
}

Future<bool> isLocalAsset(String assetPath) async {
  try {
    await rootBundle.load(assetPath);
    return true;
  } catch (_) {
    return false;
  }
}

String capitalize(String text) {
  return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
}

//input format: HH:mm:ss -> HH:mm
String formatHour(String hour) {
  if (hour.length >= 3) {
    return hour.substring(0, hour.length - 3);
  }
  return '';
}

String formatDate(DateTime dateTime, {String pattern = 'dd/MM/yyyy HH:mm'}) {
  try {
    return DateFormat(pattern).format(dateTime);
  } catch (e) {
    return '';
  }
}

double parseStringToDouble(String? value) {
  try {
    if (value != null) {
      final replaced = value.replaceAll(',', '.');
      return double.parse(replaced);
    }
  } catch (e) {
    print('format exception : ${e.toString()}');
  }
  return 0;
}
