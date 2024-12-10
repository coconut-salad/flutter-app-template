import "package:flutter/material.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";

import "../widgets/custom_snack_bar.dart";

void fireSnackbar(BuildContext context, String message, SnackBarType type,
    {Duration duration = const Duration(seconds: 4), bool onTop = true}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  CustomSnackBar snackBar;
  switch (type) {
    case SnackBarType.success:
      snackBar = CustomSnackBar.success(message: message);
      break;
    case SnackBarType.info:
      snackBar = CustomSnackBar.info(message: message);
      break;
    case SnackBarType.warning:
      snackBar = CustomSnackBar.warning(message: message);
      break;
    case SnackBarType.error:
      snackBar = CustomSnackBar.error(message: message);
      break;
    case SnackBarType.debug:
      snackBar = CustomSnackBar.debug(message: message);
      break;
  }

  showTopSnackBar(
    displayDuration: duration -
        const Duration(seconds: 2), // To account for the animation duration
    snackBarPosition: onTop ? SnackBarPosition.top : SnackBarPosition.bottom,
    Overlay.of(context),
    snackBar,
  );
}
