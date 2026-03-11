/// Reusable text field widget with extensive customization options.
///
/// This widget provides a flexible text input component that supports:
/// - Email and password field types
/// - Custom validation
/// - Prefix and suffix icons
/// - Password visibility toggle
/// - Theme-aware styling (light/dark mode)
/// - Focus state management
/// - Custom input formatters
/// - Error state display
///
/// The field automatically adapts its appearance based on focus state
/// and theme mode, providing visual feedback to users.
///
/// Example:
/// ```dart
/// CommonTextField(
///   hint: "Enter email",
///   controller: emailController,
///   isEmail: true,
///   validation: (value) => value?.isEmpty ?? true ? "Required" : null,
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/colors/app_colors.dart';
import '../../view_models/theme_vm.dart';

class CommonTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onPress;
  final VoidCallback? fieldClick;
  final Function(String)? onChanged;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? borderColor;
  final Function? validation;
  final TextInputType? keyboardType;
  final String? errorText;
  final double? prefixIconSize;
  final double? errorTextHeight;
  final double? hintTextSize;
  final double? height;
  final double? weight;
  final double? radius;
  final Function(String)? onSaved;
  final bool isEmail;
  final bool isPassword;
  final bool isSecure;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final TextStyle? errorStyle;
  final Color? underLineBorderColor;
  final FocusNode? focusNode;
  final bool isError;
  final FontWeight? fontWeight;
  final int? maxLines;
  final List<TextInputFormatter>? customTextInputFormatter;

  const CommonTextField({
    super.key,
    this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onPress,
    this.errorText,
    this.prefixIconColor,
    this.suffixIconColor,
    this.fillColor,
    this.hintColor,
    this.onSaved,
    this.keyboardType,
    this.isEmail = false,
    this.validation,
    this.prefixIconSize,
    this.onChanged,
    this.errorTextHeight,
    this.textColor,
    this.hintTextSize,
    this.height,
    this.weight,
    this.radius,
    this.fieldClick,
    this.borderColor,
    this.isPassword = false,
    this.isSecure = false,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.errorStyle,
    this.underLineBorderColor,
    this.focusNode,
    this.isError = false,
    this.fontWeight,
    this.customTextInputFormatter, this.maxLines,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool isVisible;
  final FocusNode _focusNode = FocusNode();
  final ThemeVM _themeVM = Get.find();
  bool _isFocused = false;

  @override
  void initState() {
    isVisible = widget.isSecure;
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      textAlign: TextAlign.start,
      cursorColor: AppColors.cPrimary,
      obscureText: isVisible,
      enabled: !widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscuringCharacter: "●",
      maxLines: widget.maxLines,
      focusNode: widget.focusNode ?? _focusNode,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        decoration: TextDecoration.none,
        fontSize: 16.sp,
        color: (_themeVM.isDarkMode(context)) ? AppColors.white : AppColors.black,
        fontWeight: widget.fontWeight ?? FontWeight.normal,
      ),
      onTap: widget.fieldClick ?? () {},
      inputFormatters: widget.customTextInputFormatter != null
          ? widget.customTextInputFormatter!
          : [
              if (widget.keyboardType == TextInputType.number) ...[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,6})?$')),
              ],
            ],
      onTapOutside: (_) {
        _focusNode.unfocus();
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: widget.height ?? 17.h, horizontal: widget.weight ?? 16.w),
        counter: const Offstage(),
        isDense: false,
        suffixIconConstraints: BoxConstraints.tight(Size(45.w, 45.h)),
        prefixIcon: widget.prefixIcon == null
            ? null
            : InkWell(
                splashColor: AppColors.cTransparent,
                highlightColor: AppColors.cTransparent,
                onTap: widget.onPress,
                child: widget.prefixIcon,
              ),
        suffixIcon: widget.isPassword
            ? RPadding(
                padding: REdgeInsets.symmetric(horizontal: 12.0).r,
                child: InkWell(
                  splashColor: AppColors.cTransparent,
                  highlightColor: AppColors.cTransparent,
                  onTap: _toggleVisibility,
                  child: Icon(
                    isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20.0,
                    color: _isFocused ? AppColors.cPrimary : (widget.suffixIconColor ?? Colors.grey),
                  ),
                ),
              )
            : widget.suffixIcon == null
            ? null
            : InkWell(
                splashColor: AppColors.cTransparent,
                highlightColor: AppColors.cTransparent,
                onTap: widget.onPress,
                child: widget.suffixIcon,
              ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isError ? Colors.red : widget.borderColor ?? AppColors.cPrimary,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isError ? Colors.red : widget.borderColor ?? AppColors.cPrimary,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isError ? Colors.red : widget.borderColor ?? AppColors.cEEEEEE,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isError ? Colors.red : widget.borderColor ?? AppColors.cEDF0FF,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isError ? Colors.red : widget.borderColor ?? AppColors.cPrimary,
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
        ),
        filled: true,
        errorStyle: Theme.of(context).textTheme.titleSmall?.copyWith(height: 0),
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: widget.hintTextSize ?? 13.sp,
          color: _themeVM.isDarkMode(context) ? AppColors.white :widget.hintColor ?? AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        hintText: widget.hint,
        errorText: widget.errorText,
        fillColor: _isFocused
            ? (_themeVM.isDarkMode(context))
                  ? AppColors.c1F222A.withValues(alpha: 0.5)
                  : AppColors.cEDF0FF
            : (_themeVM.isDarkMode(context))
            ? AppColors.c1F222A
            : AppColors.cFAFAFA,
      ),
      validator: widget.validation as String? Function(String?)?,
      onSaved: widget.onSaved as String? Function(String?)?,
    );
  }
}
