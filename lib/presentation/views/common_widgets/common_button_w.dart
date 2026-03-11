import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/colors/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.title,
    this.callbackFunction,
    this.isRoundedButton,
    this.isBorderedButton,
    this.fontWeight,
    this.titleColor,
    this.backgroundColor,
    this.prefixWidget,
    this.suffixWidget,
    this.paddingFromBothSide,
    this.textAlign,
    this.borderColor,
    this.fontSize,
    this.buttonHeight,
    this.withoutAlignment,
    this.buttonBorderRadius,
    this.showLoading,
    this.loadingColor = Colors.white,
    this.showShadow = false,
  });

  final Function? callbackFunction;
  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? loadingColor;
  final bool? isRoundedButton;
  final bool? isBorderedButton;
  final FontWeight? fontWeight;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double? paddingFromBothSide;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? buttonHeight;
  final double? buttonBorderRadius;
  final bool? withoutAlignment;
  final bool? showLoading;
  final bool? showShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callbackFunction != null) {
          callbackFunction!();
        }
      },
      child: Container(
        height: buttonHeight ?? 58,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            (isRoundedButton ?? false)
                ? buttonBorderRadius ?? 40.r
                : buttonBorderRadius ?? 6.r,
          ),
          color: (isBorderedButton ?? false)
              ? backgroundColor ?? AppColors.white
              : AppColors.black,
          border: Border.all(color: borderColor ?? AppColors.black, width: 1.w),
          boxShadow: showShadow ?? false
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: showLoading ?? false
            ? CupertinoActivityIndicator(color: loadingColor)
            : (withoutAlignment ?? true)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: prefixWidget ?? const SizedBox.shrink(),
                  ),
                  //prefixWidget != null ? SizedBox(width: 16.w) : const SizedBox.shrink(),
                  Expanded(
                    flex: 3,
                    child: Text(
                      title ?? "",
                      textAlign: textAlign ?? TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            titleColor ??
                            ((isBorderedButton ?? false)
                                ? AppColors.black
                                : AppColors.white),
                        fontWeight: fontWeight ?? FontWeight.bold,
                        fontSize: fontSize ?? 16.0.sp,
                      ),
                    ),
                  ),
                  //suffixWidget != null ? SizedBox(width: 16.w) : const SizedBox.shrink(),
                  Expanded(
                    flex: 1,
                    child: suffixWidget ?? const SizedBox.shrink(),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixWidget ?? const SizedBox.shrink(),
                  //prefixWidget != null ? SizedBox(width: 16.w) : const SizedBox.shrink(),
                  Text(
                    title ?? "",
                    textAlign: textAlign ?? TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          titleColor ??
                          ((isBorderedButton ?? false)
                              ? AppColors.black
                              : AppColors.white),
                      fontWeight: fontWeight ?? FontWeight.bold,
                      fontSize: fontSize ?? 14.0.sp,
                    ),
                  ),
                  //suffixWidget != null ? SizedBox(width: 16.w) : const SizedBox.shrink(),
                  suffixWidget ?? const SizedBox.shrink(),
                ],
              ),
      ),
    );
  }
}
