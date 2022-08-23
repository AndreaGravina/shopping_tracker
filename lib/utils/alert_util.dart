import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showSaveSuccess({
  required BuildContext ctx,
  String? content,
  String? title,
  Function? onDismiss,
}) async {
  await showDialog(
    context: ctx,
    builder: (ctxDialog) => AlertDialog(
      elevation: 0,
      title: Text(title ?? tr('confirm')),
      content: Text(content ?? tr('save_success')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctxDialog).pop();
          },
          child: Text(
            tr('close'),
          ),
        ),
      ],
    ),
  );
  if (onDismiss != null) {
    onDismiss();
  }
}

Future<void> showMessage({
  required BuildContext ctx,
  String? content,
  String? title,
  Function? onDismiss,
}) async {
  await showDialog(
    context: ctx,
    builder: (ctxDialog) => AlertDialog(
      elevation: 0,
      title: Text(title ?? tr('warning')),
      content: Text(content ?? tr('general_error')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctxDialog).pop();
          },
          child: Text(
            tr('close'),
          ),
        ),
      ],
    ),
  );
  if (onDismiss != null) {
    onDismiss();
  }
}

Future<void> showConfirm({
  required BuildContext ctx,
  required Function onConfirm,
  String? content,
}) async {
  await showDialog(
    context: ctx,
    builder: (ctxDialog) => AlertDialog(
      elevation: 0,
      title: Text(tr('confirm')),
      content: Text(content ?? tr('delete_confirm')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctxDialog).pop();
            onConfirm();
          },
          child: Text(
            tr('confirm'),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(ctxDialog).pop();
          },
          child: Text(
            tr('undo'),
          ),
        ),
      ],
    ),
  );
}
