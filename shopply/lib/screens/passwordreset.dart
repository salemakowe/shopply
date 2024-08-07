import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopply/constants/mydecoration.dart';
import 'package:shopply/constants/myfunctions.dart';
import 'package:shopply/constants/mysizes.dart';
import 'package:shopply/constants/mywidgets.dart';
import 'package:shopply/constants/validator/password_field_validator.dart';
import 'package:shopply/main.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasError = true;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    Sizes().heightSizeCalc(context);
    Sizes().widthSizeCalc(context);
    return SafeArea(
      child: PopScope(
        canPop: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Create Password',
                style: GoogleFonts.poppins(
                  fontSize: Sizes.w20,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            body: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                padding: const EdgeInsets.all(0),
                textScaler: TextScaler.linear(textScale),
              ),
              child: Padding(
                padding: internalPadding(context),

                //start your widget from here
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyWidget().customDivider(height: Sizes.h30),
                      Text(
                        'Create new password',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: Sizes.w25,
                        ),
                      ),
                      MyWidget().customDivider(height: Sizes.h30),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: newPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              onEditingComplete: node.nextFocus,
                              obscureText: true,
                              validator: (value) {},
                              decoration: MyDecor().form(
                                context: context,
                                hinttext: 'Enter new password',
                                prefixicon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                suffixicon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _confirmPasswordVisible =
                                          !_confirmPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            MyWidget().customDivider(height: Sizes.h20),
                            TextFormField(
                              controller: confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              onEditingComplete: node.nextFocus,
                              obscureText: true,
                              validator: (value) {},
                              decoration: MyDecor().form(
                                context: context,
                                hinttext: 'Confirm password',
                                prefixicon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                suffixicon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            MyWidget().customDivider(height: Sizes.h20),

                            //Password hint
                            Visibility(
                              visible: newPasswordController.text.isNotEmpty,
                              child: Container(
                                decoration: MyWidget().container(
                                  context: context,
                                  containerColor: Colors.grey.withOpacity(.15),
                                  curve: 10,
                                ),
                                child: Padding(
                                  padding: internalPadding(context),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Password must have : ',
                                            style: GoogleFonts.poppins(),
                                          )
                                        ],
                                      ),
                                      MyWidget()
                                          .customDivider(height: Sizes.h10),
                                      PasswordFieldValidator(
                                        minLength: 8,
                                        uppercaseCharCount: 1,
                                        lowercaseCharCount: 1,
                                        numericCharCount: 1,
                                        specialCharCount: 1,
                                        defaultColor: Colors.grey,
                                        successColor: Colors.green,
                                        failureColor: Colors.red,
                                        controller: newPasswordController,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MyWidget().customDivider(height: Sizes.h50),
                            MyWidget().button(
                              context: context,
                              proceed: () {},
                              buttonText: 'Reset Password',
                              buttonTextSize: Sizes.w18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
