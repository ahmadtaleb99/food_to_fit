import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RoundedTextField extends StatelessWidget {
  final String? hint;
  final bool? obscure;
  final TextEditingController? controller;
  final TextInputAction? action;
  final TextInputType? textInputType;
  final Function? onSubmitted;

  RoundedTextField({this.hint, this.obscure, this.controller, this.action, this.textInputType, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure!,
      textInputAction: action,
      keyboardType: textInputType,
      onFieldSubmitted: (_) => onSubmitted!(),
      validator: FormBuilderValidators.required(errorText: 'Field is required'.tr() ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: CustomColors.PrimaryColor),
          ),
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.0),
          hintText: hint,
      ),
    );
  }
}
