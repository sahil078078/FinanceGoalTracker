import '../exported.dart';

class CustomButton extends StatelessWidget {
  final double? width, height;
  final double minWidth, borderRadius;
  final GestureTapCallback? onTap;
  final bool isLoading;
  final String title;
  final TextStyle? style;
  final Widget? icon;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final Color loadingColor;
  final Color textColor;
  final double borderWidth;
  final double elevation;
  final bool isAfter;
  final MaterialStateProperty<EdgeInsetsGeometry>? padding;
  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.title = "Save",
    this.style,
    this.isLoading = false,
    this.icon,
    this.child,
    this.backgroundColor = appPrimary,
    this.borderColor = appPrimary,
    this.borderWidth = 0.75,
    this.elevation = 0.1,
    this.loadingColor = Colors.white,
    this.textColor = Colors.white,
    this.isAfter = false,
    this.minWidth = 80,
    this.padding,
    this.borderRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: SizedBox(
        width: width,
        height: height ?? 35,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: padding,
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            elevation: MaterialStateProperty.all(elevation),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
            ),
          ),
          onPressed: !isLoading ? onTap : null,
          child: !isLoading
              ? child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isAfter) icon ?? const SizedBox.shrink(),
                      Flexible(
                        child: Text(
                          title,
                          style: style ??
                              MyTextStyle.semiBold.copyWith(
                                color: textColor,
                                fontSize: 14.5,
                              ),
                        ),
                      ),
                      if (isAfter) icon ?? const SizedBox.shrink(),
                    ],
                  )
              : LoadingComponent(color: loadingColor),
        ),
      ),
    );
  }
}
