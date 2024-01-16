import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/custom_text_field.dart';
import '../../cubit/auth_cubit.dart';

class RegisterCardTextFormField extends StatelessWidget {
  const RegisterCardTextFormField({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  final GlobalKey formKey;

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
            top: 25,
            left: 10,
            right: 10,
            bottom: 8,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 90,
                child: CustomTextFormField(
                  filledNeed: true,
                  fillColor: Colors.grey.shade100,
                  textEditingController: nameController,
                  typeInput: TextInputType.text,
                  label: "Name",
                  colorLabelText: AppColors.secondPrimaryColor,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.person,
                    color: AppColors.primaryColor,
                  ),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 90,
                child: CustomTextFormField(
                  filledNeed: true,
                  fillColor: Colors.grey.shade100,
                  textEditingController: emailController,
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
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final cubit = AuthCubit.get(context);
                  return SizedBox(
                    height: 90,
                    child: CustomTextFormField(
                      filledNeed: true,
                      fillColor: Colors.grey.shade100,
                      textEditingController: passwordController,
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
                          return "Please is too short";
                        }
                        return null;
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 80,
                child: CustomTextFormField(
                  filledNeed: true,
                  fillColor: Colors.grey.shade100,
                  textEditingController: phoneController,
                  typeInput: TextInputType.phone,
                  label: "Phone",
                  colorLabelText: AppColors.secondPrimaryColor,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.phone,
                    color: AppColors.primaryColor,
                  ),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone";
                    }
                    return null;
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
