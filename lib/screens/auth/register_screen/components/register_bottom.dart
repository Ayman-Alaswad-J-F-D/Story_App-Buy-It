import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/custom_button.dart';
import '../../cubit/auth_cubit.dart';

class RegisterBotton extends StatelessWidget {
  const RegisterBotton({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
    // required this.state,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  // final AuthState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AuthLoadingState,
          builder: (context) => CustomButton(
            text: 'Register',
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.whiteColor,
            onTap: () {
              if (formKey.currentState!.validate()) {
                AuthCubit.get(context).userRegister(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  phone: phoneController.text,
                );
              }
            },
          ),
          fallback: (context) => const CustomButton(
            trueChild: true,
            height: 16,
            backgroundColor: AppColors.primaryColor,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primaryColor,
              ),
            ),
            onTap: null,
          ),
        );
      },
    );
  }
}
