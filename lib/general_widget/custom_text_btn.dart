import '../exported.dart'; 

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.padding,
    this.visualDensity,
    this.title,
    this.style,
    this.child,
    required this.onPressed,
  }) : assert(
          (title != null && child == null) || (title == null && child != null),
          'Use title or child one at time',
        );
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final String? title;
  final TextStyle? style;
  final Widget? child;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        visualDensity: visualDensity ??
            const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
      ),
      child: title != null
          ? Text(
              '$title',
              style: style ??
                  MyTextStyle.semiBold.copyWith(
                    fontSize: 16,
                    color: grey500,
                  ),
            )
          : child!,
    );
  }
}
