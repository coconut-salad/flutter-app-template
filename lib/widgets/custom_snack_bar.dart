import "package:flutter/material.dart";

import "../utils/colors.dart";

enum SnackBarType {
  success,
  info,
  warning,
  error,
  debug,
}

class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar.success({
    super.key,
    required this.message,
    this.messagePadding =
        const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
    this.icon = const Icon(
      Icons.check,
      color: Colors.white,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = AppColors.success,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.start,
  });

  const CustomSnackBar.info({
    super.key,
    required this.message,
    this.messagePadding =
        const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
    this.icon = const Icon(
      Icons.info,
      color: Colors.white,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = AppColors.info,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });

  const CustomSnackBar.warning({
    super.key,
    required this.message,
    this.messagePadding =
        const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
    this.icon = const Icon(
      Icons.warning_rounded,
      color: Colors.white,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = AppColors.warning,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });

  const CustomSnackBar.error({
    super.key,
    required this.message,
    this.messagePadding =
        const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
    this.icon = const Icon(
      Icons.error_outline,
      color: Colors.white,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = AppColors.error,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });

  const CustomSnackBar.debug({
    super.key,
    required this.message,
    this.messagePadding =
        const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
    this.icon = const Icon(
      Icons.bug_report,
      color: Colors.white,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = AppColors.debug,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });

  final String message;
  final Widget icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLines;
  final int iconRotationAngle;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final double iconPositionTop;
  final double iconPositionLeft;
  final EdgeInsetsGeometry messagePadding;
  final double textScaleFactor;
  final TextAlign textAlign;

  @override
  CustomSnackBarState createState() => CustomSnackBarState();
}

class CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(minHeight: 55),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      width: double.infinity,
      child: Padding(
        padding: widget.messagePadding,
        child: Row(
          children: [
            Transform.translate(
              offset: const Offset(0, -2),
              child: widget.icon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.message,
                  style: theme.textTheme.bodyMedium?.merge(widget.textStyle),
                  textAlign: widget.textAlign,
                  textScaleFactor: widget.textScaleFactor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(12));
