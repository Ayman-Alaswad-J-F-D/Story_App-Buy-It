import 'package:flutter/material.dart';
import 'package:store_app/app/functions/toast_snack_bar.dart';
import 'package:store_app/theme/colors.dart';
import 'package:store_app/theme/styles.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_circular_progress.dart';
import '../../../widget/custom_text_field.dart';

class ConnectAsBody extends StatelessWidget {
  ConnectAsBody({Key? key}) : super(key: key);

  final TextEditingController emailControlle = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                label: "Your Email",
                textEditingController: emailControlle,
                typeInput: TextInputType.text,
                colorLabelText: AppColors.primaryColor,
                cursorColor: AppColors.primaryColor,
                filledNeed: true,
                fillColor: AppColors.lightGrayColor,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "* required";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Your Note :",
                  style: TextStyles.pacifico14PrimaryRegular,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                label: "",
                radius: 15,
                maxLines: 6,
                textEditingController: noteController,
                typeInput: TextInputType.text,
                cursorColor: AppColors.primaryColor,
                colorLabelText: AppColors.primaryColor,
                filledNeed: true,
                fillColor: AppColors.lightGrayColor,
                hintText: "Note ..",
                colorHintText: AppColors.primaryColor,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "write something";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Send",
                height: 10,
                backgroundColor: AppColors.primaryColor,
                colorText: AppColors.yallowColor,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (builder) {
                        return const CustomCircularProgress();
                      },
                    );
                    Future.delayed(const Duration(seconds: 2)).then(
                      (_) {
                        Navigator.pop(context);
                        toastSnackBar(
                          context: context,
                          text:
                              "Your message has been received. Thank you for reaching out.",
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "You can contact the administrator via the following mail.\nAdmin Email : buyitproduct@gmail.com",
                  style: TextStyles.font12LightGrayRegularHeight1_5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
