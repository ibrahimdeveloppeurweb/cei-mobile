import 'package:cei_mobile/common_widgets/app_logo.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:async';

class RegisterStep2Screen extends StatefulWidget {
  final String phoneNumber;
  const RegisterStep2Screen({
    Key? key, required this.phoneNumber,
  }) : super(key: key);

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final int otpLength = 4;
  List<String> otpDigits = ['', '', '', ''];
  List<FocusNode> focusNodes = [];
  List<TextEditingController> controllers = [];
  GlobalKey<FormState> formKey = GlobalKey();

  bool isResendEnabled = false;
  int resendCountdown = 30;
  Timer? _timer;

  void _verifyOtp() async {
    try {
      appStore.setLoading(true);
      print(widget.phoneNumber.validate().trim());
      final result = await verifyOtpRequest(otpDigits.join(''), widget.phoneNumber.validate().trim());
      context.pushNamed(AppRoutes.registerStep3, pathParameters: {'phoneNumber': widget.phoneNumber.validate().trim()});
    } catch (e) {
      toast('$e');
    } finally {
      appStore.setLoading(false);
    }
  }

  void _resendOtp() async {
    try {
      appStore.setLoading(true);
      final trimmedPhoneNumber = widget.phoneNumber;
      final result = await resendOtpRequest(trimmedPhoneNumber);
    } catch (e) {
      toast('$e');
    } finally {
      appStore.setLoading(false);
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize focus nodes and controllers
    for (int i = 0; i < otpLength; i++) {
      focusNodes.add(FocusNode());
      controllers.add(TextEditingController());
    }

    // Start resend timer
    startResendTimer();
  }

  void startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown == 0) {
        setState(() {
          isResendEnabled = true;
          _timer?.cancel();
        });
      } else {
        setState(() {
          resendCountdown--;
        });
      }
    });
  }

  void resendOtp() {
    if (!isResendEnabled) return;

    // Reset OTP fields
    for (int i = 0; i < otpLength; i++) {
      controllers[i].clear();
      otpDigits[i] = '';
    }

    // Reset focus to first field
    FocusScope.of(context).requestFocus(focusNodes[0]);

    // Reset timer
    setState(() {
      isResendEnabled = false;
      resendCountdown = 30;
    });

    // Start timer again
    startResendTimer();

    // Show confirmation to user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Un nouveau code a été envoyé'),
        duration: Duration(seconds: 2),
      ),
    );

    // Here you would make an API call to request a new OTP code
    // mockSendOtp(widget.phoneNumber);
  }

  void validateOtp() {
    // Combine digits to form the complete OTP
    String completeOtp = otpDigits.join();

    if (completeOtp.length == otpLength) {
      _verifyOtp();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un code complet'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
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
                        // Logo
                        AppLogo(),
                        const SizedBox(height: 20),
                        // Title
                        Text(
                          "Vérification du téléphone",
                          style: boldTextStyle(size: 34, letterSpacing: 0.5, color: Colors.black),
                        ),

                        const SizedBox(height: 40),

                        // OTP Input fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(otpLength, (index) {
                            return Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: controllers[index],
                                focusNode: focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: boldTextStyle(size: 24),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      otpDigits[index] = value;
                                    });

                                    // Move to next field if available
                                    if (index < otpLength - 1) {
                                      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                                    } else {
                                      // Last field, submit OTP
                                      focusNodes[index].unfocus();
                                      validateOtp();
                                    }
                                  } else {
                                    setState(() {
                                      otpDigits[index] = '';
                                    });

                                    // Move to previous field if available
                                    if (index > 0) {
                                      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                                    }
                                  }
                                },
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 40),

                        // Resend option
                        Center(
                          child: Observer(builder: (builder){
                            return appStore.isLoading ? const CircularProgressIndicator() : Column(
                              children: [
                                Text(
                                  'Vous n\'avez pas reçu de code?',
                                  style: secondaryTextStyle(size: 16),
                                ),
                                TextButton(
                                  onPressed: isResendEnabled ? _resendOtp : null,
                                  child: Text(
                                    isResendEnabled ? 'Renvoyer' : 'Renvoyer (${resendCountdown}s)',
                                    style: TextStyle(
                                      color: isResendEnabled ? AppColors.primary : Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                        ),

                        const SizedBox(height: 40),

                        // Number pad
                        Column(
                          children: [
                            // Row 1 (1, 2, 3)
                            _buildNumberRow([1, 2, 3]),

                            const SizedBox(height: 20),

                            // Row 2 (4, 5, 6)
                            _buildNumberRow([4, 5, 6]),

                            const SizedBox(height: 20),

                            // Row 3 (7, 8, 9)
                            _buildNumberRow([7, 8, 9]),

                            const SizedBox(height: 20),

                            // Row 4 (empty, 0, backspace)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildEmptyKey(),
                                _buildNumberKey(0),
                                _buildBackspaceKey(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberRow(List<int> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) => _buildNumberKey(number)).toList(),
    );
  }

  Widget _buildNumberKey(int number) {
    return InkWell(
      onTap: () => _onNumberPressed(number),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: Text(
          number.toString(),
          style: boldTextStyle(size: 28),
        ),
      ),
    );
  }

  Widget _buildEmptyKey() {
    return const SizedBox(
      width: 80,
      height: 80,
    );
  }

  Widget _buildBackspaceKey() {
    return InkWell(
      onTap: _onBackspacePressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: const Icon(Icons.backspace_outlined, size: 28),
      ),
    );
  }

  void _onNumberPressed(int number) {
    // Find the first empty field or the last field if all are filled
    int targetIndex = otpDigits.indexOf('');
    if (targetIndex == -1) targetIndex = otpLength - 1;

    // Update the field
    setState(() {
      otpDigits[targetIndex] = number.toString();
      controllers[targetIndex].text = number.toString();
    });

    // Move focus to the next field if available
    if (targetIndex < otpLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[targetIndex + 1]);
    } else {
      // All fields are filled, validate OTP
      validateOtp();
    }
  }

  void _onBackspacePressed() {
    // Find the last non-empty field or the first field if all are empty
    int targetIndex = otpDigits.lastIndexWhere((digit) => digit.isNotEmpty);
    if (targetIndex == -1) targetIndex = 0;

    // Clear the field
    setState(() {
      otpDigits[targetIndex] = '';
      controllers[targetIndex].clear();
    });

    // Set focus to the cleared field
    FocusScope.of(context).requestFocus(focusNodes[targetIndex]);
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text('Vérification réussie!', style: boldTextStyle(size: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Continuer'),
            ),
          ],
        ),
      ),
    );
  }
}