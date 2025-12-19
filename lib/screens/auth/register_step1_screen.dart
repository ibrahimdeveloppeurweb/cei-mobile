import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart'
    show DigitLengthLimitingTextInputFormatter, IvoryCoastPhoneFormatter;
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/repository/auth_repository.dart';
import 'package:cei_mobile/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  State<RegisterStep1Screen> createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController phoneNumberCont = TextEditingController();

  FocusNode phoneNumberFocus = FocusNode();

  void _sendOtp() async {
    try {
      appStore.setLoading(true);
      final trimmedPhoneNumber = phoneNumberCont.text;
      final result = await sendOtpRequest(trimmedPhoneNumber);
      context.pushNamed(AppRoutes.registerStep2, pathParameters: {'phoneNumber': trimmedPhoneNumber.trim()});
    } catch (e) {
      toast('$e');
    } finally {
      appStore.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.height, // Reduced from 100 to give more space
                        Image.asset(
                          AssetConstants.logo,
                          height: 80,
                        ),
                        Text("Bienvenue sur",
                            style: boldTextStyle(
                                size: 36, letterSpacing: 2, color: Colors.black)),
                        Text("CEI Mobile",
                            style: boldTextStyle(
                              size: 36,
                              letterSpacing: 2,
                              color: AppColors.primary,
                            )),
                        50.height,
                        const Text(
                          'Numéro de téléphone',
                          style: AppTextStyles.body2,
                        ),
                        AppTextField(
                          controller: phoneNumberCont,
                          decoration: const InputDecoration(
                            hintText: "0102030405",
                            border: OutlineInputBorder(),
                          ),
                          errorThisFieldRequired: "Saisir votre numéro de téléphone",
                          inputFormatters: [
                            DigitLengthLimitingTextInputFormatter(11),
                            IvoryCoastPhoneFormatter()
                          ],
                          textFieldType: TextFieldType.PHONE,
                        ),
                        60.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'J\'ai déjà un compte? ',
                              style: boldTextStyle(),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed(AppRoutes.login);
                              },
                              child: Text(
                                "Se connecter",
                                style: boldTextStyle(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'En continuant j’accepte les conditions générales d’utilisation et les politiques de confidentialité de CEI Mobile.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body2,
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      30.height,
                      Observer(builder: (builder) {
                        return AppButton(
                          width: context.width(),
                          shapeBorder:
                              RoundedRectangleBorder(borderRadius: radius()),
                          onTap: () {
                            if (formKey.currentState!.validate()){
                              _sendOtp();
                            }
                          },
                          elevation: 0.0,
                          color: AppColors.primary,
                          child: appStore.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  padding: EdgeInsets.zero,
                                )
                              : Text('Suivant',
                                  style: boldTextStyle(color: Colors.white)),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
