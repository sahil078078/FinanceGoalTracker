import '../exported.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final mobileController = TextEditingController();

  void _getOTP(String mobile, BuildContext context) async {
    if (_key.currentState != null && _key.currentState!.validate()) {
      Provider.of<AuthProvider>(context, listen: false).verifyPhoneNumber(
        phone: mobile,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   final auth = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: Form(
        key: _key,
        child: SafeArea(
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
                    'Welcome to Finance Goal',
                    style: MyTextStyle.medium.copyWith(
                      fontSize: 18,
                      color: black,
                    ),
                  ),
                  Text(
                    'Login with mobile',
                    style: MyTextStyle.medium.copyWith(
                      fontSize: 13,
                      color: grey700,
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyTextFormField(
                    controller: mobileController,
                    label: 'Mobile number',
                    hintText: 'Enter your mobile number',
                    maxLength: 10,
                    inputFormatters: mobileInputFormatter,
                    validator: mobileNumValidator,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    onSubmit: (_) => _getOTP(_, context),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      isLoading: auth.isLoadingForVerifyMobileNumber,
                      width: 100,
                      title: 'Get OTP',
                      onTap: () => _getOTP(mobileController.text, context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
