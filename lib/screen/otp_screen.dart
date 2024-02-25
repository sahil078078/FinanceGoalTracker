import '../exported.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  void _onSubmit({
    required BuildContext context,
    required String smsCode,
  }) async {
    final isSuccess = await context.read<AuthProvider>().verifyOTP(
          context: context,
          verificationId: widget.verificationId,
          smsCode: smsCode,
        );

    if (isSuccess && context.mounted) {
      context.read<AuthProvider>().onSignInSuccessfully(context);
    }
  }

  final smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: SvgPicture.asset(
                    'asset/icons/login-background.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Please enter OTP',
                  style: MyTextStyle.medium.copyWith(
                    fontSize: 18,
                    color: black,
                  ),
                ),
                const SizedBox(height: 6),
                PinCodeTextField(
                  highlight: true,
                  controller: smsController,
                  maxLength: 6,
                  pinBoxWidth: 40,
                  pinBoxHeight: 40,
                  pinBoxRadius: 5,
                  pinBoxBorderWidth: 1,
                  highlightPinBoxColor: Colors.white,
                  highlightColor: appPrimary,
                  defaultBorderColor: grey500,
                  keyboardType: TextInputType.number,
                  pinTextStyle: MyTextStyle.semiBold.copyWith(fontSize: 16),
                  pinBoxOuterPadding: const EdgeInsets.only(right: 3, left: 3),
                  pinBoxColor: Colors.transparent,
                  errorBorderColor: Colors.redAccent,
                  hasError: auth.hasError,
                  onDone: (n) => _onSubmit(context: context, smsCode: n),
                  hasTextBorderColor: appPrimary,
                ),
                if (auth.hasError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Visibility(
                        visible: auth.hasError,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 0,
                          ),
                          child: Text(
                            auth.errorMsg,
                            style: MyTextStyle.regular.copyWith(
                              color: redMsg,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                square15,
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    isLoading: auth.isLoadingForVerifyOTP,
                    width: 100,
                    title: 'Get OTP',
                    onTap: () => _onSubmit(context: context, smsCode: smsController.text),
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
