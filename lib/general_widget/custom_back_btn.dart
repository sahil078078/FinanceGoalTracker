import '../exported.dart';

class CustomBackBtn extends StatelessWidget {
  final GestureTapCallback? onTap;
  const CustomBackBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => backScreen(context: context),
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        size: 20,
      ),
    );
  }
}
