import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/custom_text_field.dart';
import '../../cubit/auth_cubit.dart';

class LoginCardTextFormField extends StatefulWidget {
  const LoginCardTextFormField({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey formKey;

  @override
  State<LoginCardTextFormField> createState() => _LoginCardTextFormFieldState();
}

class _LoginCardTextFormFieldState extends State<LoginCardTextFormField> {
  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;
  @override
  void initState() {
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 28,
            left: 10,
            right: 10,
            bottom: 8,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 85,
                child: CustomTextFormField(
                  focusNode: _emailNode,
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(_passwordNode),
                  filledNeed: true,
                  fillColor: Colors.grey.shade100,
                  textEditingController: widget.emailController,
                  typeInput: TextInputType.emailAddress,
                  label: "E-mail",
                  colorLabelText: AppColors.secondPrimaryColor,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.userLarge,
                    color: AppColors.primaryColor,
                  ),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email address";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 85,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final cubit = AuthCubit.get(context);
                    return CustomTextFormField(
                      focusNode: _passwordNode,
                      filledNeed: true,
                      fillColor: Colors.grey.shade100,
                      textEditingController: widget.passwordController,
                      typeInput: TextInputType.visiblePassword,
                      isPassword: cubit.isPassword,
                      suffixIcon: cubit.suffix,
                      suffixPressed: () => cubit.changePasswordVisibility(),
                      label: "Password",
                      colorLabelText: AppColors.secondPrimaryColor,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.lock,
                        color: AppColors.primaryColor,
                      ),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else if (value.length < 8) {
                          return "Please is too short";
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
