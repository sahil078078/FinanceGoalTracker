import '../exported.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoadingForVerifyMobileNumber = false;
  Future<void> verifyPhoneNumber({
    required String phone,
    required BuildContext context,
  }) async {
    try {
      isLoadingForVerifyMobileNumber = true;
      notifyListeners();
      final phoneNumber = '+91 ${phone.substring(0, 4)} ${phone.substring(4, 7)} ${phone.substring(7)}'; // +91 **** *** *** format mobile number

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          //! Work in Android for automatically otp detect and sign up
          try {
            final UserCredential credential = await auth.signInWithCredential(phoneAuthCredential);

            isLoadingForVerifyMobileNumber = false;
            notifyListeners();
            if (credential.user != null && credential.user!.uid.isEmpty && context.mounted) {
              onSignInSuccessfully(context);
            }

            isLoadingForVerifyMobileNumber = false;
            notifyListeners();
          } on FirebaseAuthException catch (e) {
            Fluttertoast.showToast(msg: e.code);
            isLoadingForVerifyMobileNumber = false;
            notifyListeners();
          } catch (e) {
            Fluttertoast.showToast(msg: '$e');
            isLoadingForVerifyMobileNumber = false;
            notifyListeners();
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('codeAutoRetrievalTimeout Work');
          isLoadingForVerifyMobileNumber = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          debugPrint('codeSent Work');
          isLoadingForVerifyMobileNumber = false;
          notifyListeners();
          pushNReplace(
            context: context,
            routeName: RoutePath.otp,
            arguments: verificationId,
          );
        },
        verificationFailed: (FirebaseAuthException error) {
          isLoadingForVerifyMobileNumber = false;
          notifyListeners();
          debugPrint('verificationFailed code : ${error.code}');
          debugPrint('verificationFailed phoneNumber : ${error.phoneNumber}');
          debugPrint('verificationFailed message : ${error.message}');

          Fluttertoast.showToast(msg: error.code);
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoadingForVerifyMobileNumber = false;
      notifyListeners();
      debugPrint('signInWithMobileNumber : FirebaseAuthException : $e');
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      isLoadingForVerifyMobileNumber = false;
      notifyListeners();
      debugPrint('signInWithMobileNumber error : $e');
      Fluttertoast.showToast(msg: '$e');
    }
  }

  String errorMsg = '';
  bool hasError = false;
  bool isLoadingForVerifyOTP = false;
  bool signInSuccessFully = false;
  Future<bool> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    if (smsCode.isEmpty) {
      hasError = true;
      errorMsg = 'Please enter OTP';
      notifyListeners();
      return false;
    } else if (smsCode.length < 6) {
      hasError = true;
      errorMsg = 'Please enter entire OTP';
      notifyListeners();
      return false;
      //! Terminate function
    }

    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    isLoadingForVerifyOTP = true;

    notifyListeners();
    try {
      final UserCredential userCredential = await auth.signInWithCredential(credential);

      isLoadingForVerifyOTP = false;
      hasError = false;
      errorMsg = '';
      signInSuccessFully = (userCredential.user?.uid ?? "").isNotEmpty;
      notifyListeners();
      return signInSuccessFully;
    } on FirebaseAuthException catch (e) {
      isLoadingForVerifyOTP = false;
      hasError = true;
      errorMsg = e.code;
      signInSuccessFully = false;
      notifyListeners();
      debugPrint('verifyOTP : FirebaseError code : ${e.code}');
      debugPrint('verifyOTP : FirebaseError message : ${e.message}');
      return false;
    } catch (e) {
      isLoadingForVerifyOTP = false;
      hasError = true;
      errorMsg = 'Something went wrong';
      signInSuccessFully = false;
      notifyListeners();
      return false;
    }
  }

  //! SUCCESSFULLY AUTH
  void onSignInSuccessfully(BuildContext context) {
    Fluttertoast.showToast(msg: "Sign-In successfully");
    pushNReplace(context: context, routeName: RoutePath.home);
  }

  //! LOGOUT
  bool isLoadingForLogout = false;
  Future<bool> logout() async {
    isLoadingForLogout = true;
    notifyListeners();

    try {
      await auth.signOut();
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
      // add 1.5 second delay
      final isLogOut = auth.currentUser == null;
      isLoadingForLogout = false;
      notifyListeners();
      return isLogOut;
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.code);
      isLoadingForLogout = false;
      notifyListeners();
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
      isLoadingForLogout = false;
      notifyListeners();
      return false;
    }
  }

  //! Constructor
  User? get currentUser => _currentUser;
  User? get _currentUser => auth.currentUser;
}
