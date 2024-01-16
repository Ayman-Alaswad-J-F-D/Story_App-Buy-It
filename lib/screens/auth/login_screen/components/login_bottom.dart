import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/custom_button.dart';
import '../../cubit/auth_cubit.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AuthLoadingState,
          builder: (context) => CustomButton(
            text: 'Login',
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.whiteColor,
            onTap: () {
              if (formKey.currentState!.validate()) {
                AuthCubit.get(context).userLogin(
                  email: emailController.text,
                  password: passwordController.text,
                );
              }
            },
          ),
          fallback: (context) => const CustomButton(
            height: 15,
            onTap: null,
            backgroundColor: AppColors.primaryColor,
            trueChild: true,
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
