import 'package:flutter/material.dart';
import 'package:shopply/constants/validator/pwd_validator.dart';
import './validator_items.dart';

class PasswordFieldValidator extends StatefulWidget {
  final int minLength;
  final int uppercaseCharCount;
  final int lowercaseCharCount;
  final int numericCharCount;
  final int specialCharCount;

  final Color defaultColor;
  final Color successColor;
  final Color failureColor;
  final TextEditingController controller;

  final String? minLengthMessage;
  final String? uppercaseCharMessage;
  final String? lowercaseMessage;
  final String? numericCharMessage;
  final String? specialCharacterMessage;

  const PasswordFieldValidator({
    super.key,
    required this.minLength,
    required this.uppercaseCharCount,
    required this.lowercaseCharCount,
    required this.numericCharCount,
    required this.specialCharCount,
    required this.defaultColor,
    required this.successColor,
    required this.failureColor,
    required this.controller,
    this.minLengthMessage,
    this.uppercaseCharMessage,
    this.lowercaseMessage,
    this.numericCharMessage,
    this.specialCharacterMessage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldValidatorState createState() => _PasswordFieldValidatorState();
}

class _PasswordFieldValidatorState extends State<PasswordFieldValidator> {
  final Map<Validation, bool> _selectedCondition = {
    Validation.atLeast: false,
    Validation.uppercase: false,
    Validation.lowercase: false,
    Validation.numericCharacter: false,
    Validation.specialCharacter: false,
    Validation.passwordMatch: false,
  };

  late bool isFirstRun;

  void validate() {
    _selectedCondition[Validation.atLeast] = Validator().hasMinimumLength(
      widget.controller.text,
      widget.minLength,
    );

    _selectedCondition[Validation.uppercase] = Validator().hasMinimumUppercase(
      widget.controller.text,
      widget.uppercaseCharCount,
    );

    _selectedCondition[Validation.lowercase] = Validator().hasMinimumLowercase(
      widget.controller.text,
      widget.lowercaseCharCount,
    );

    _selectedCondition[Validation.numericCharacter] =
        Validator().hasMinimumNumericCharacters(
      widget.controller.text,
      widget.numericCharCount,
    );

    _selectedCondition[Validation.specialCharacter] =
        Validator().hasMinimumSpecialCharacters(
      widget.controller.text,
      widget.specialCharCount,
    );

    // _selectedCondition[Validation.passwordMatch] =
    //     _passwordMatch(widget.controller.text);

    setState(() {
      return;
    });
  }

  // bool _passwordMatch(String confirmPassword) {
  //   return confirmPassword == newPasswordController.text;
  // }

  @override
  void initState() {
    super.initState();
    isFirstRun = true;

    widget.controller.addListener(() {
      isFirstRun = false;
      validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _selectedCondition.entries.map((entry) {
        int conditionValue = 0;
        String conditionMessage = '';
        if (entry.key == Validation.atLeast) {
          conditionValue = widget.minLength;
          conditionMessage = widget.minLengthMessage ??
              validatorMessage.entries
                  .firstWhere(
                    (element) => element.key == Validation.atLeast,
                  )
                  .value
                  .toString();
        }
        if (entry.key == Validation.uppercase) {
          conditionValue = widget.uppercaseCharCount;
          conditionMessage = widget.uppercaseCharMessage ??
              validatorMessage.entries
                  .firstWhere(
                    (element) => element.key == Validation.uppercase,
                  )
                  .value
                  .toString();
        }
        if (entry.key == Validation.lowercase) {
          conditionValue = widget.lowercaseCharCount;
          conditionMessage = widget.lowercaseMessage ??
              validatorMessage.entries
                  .firstWhere(
                    (element) => element.key == Validation.lowercase,
                  )
                  .value
                  .toString();
        }
        if (entry.key == Validation.numericCharacter) {
          conditionValue = widget.numericCharCount;
          conditionMessage = widget.numericCharMessage ??
              validatorMessage.entries
                  .firstWhere(
                    (element) => element.key == Validation.numericCharacter,
                  )
                  .value
                  .toString();
        }
        if (entry.key == Validation.specialCharacter) {
          conditionValue = widget.specialCharCount;
          conditionMessage = widget.specialCharacterMessage ??
              validatorMessage.entries
                  .firstWhere(
                    (element) => element.key == Validation.specialCharacter,
                  )
                  .value
                  .toString();
        }
        if (entry.key == Validation.passwordMatch) {
          conditionMessage = validatorMessage[Validation.passwordMatch]!;
        }
        return ValidatorItemWidget(
          conditionMessage,
          conditionValue,
          isFirstRun
              ? widget.defaultColor
              : entry.value
                  ? widget.successColor
                  : widget.failureColor,
          entry.value,
        );
      }).toList(),
    );
  }
}
