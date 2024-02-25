import '../exported.dart';

class CustomIconButton extends StatelessWidget {
  final String? svgPath;
  final Widget? child;

  final EdgeInsetsGeometry? padding;
  final GestureTapCallback onTap;
  final double? boxWidth, boxHeight;
  final double? svgWidth, svgHeight;
  final ColorFilter? colorFilter;
  final bool isLoading;
  CustomIconButton({
    super.key,
    this.svgPath,
    this.child,
    required this.onTap,
    this.padding,
    this.boxWidth,
    this.boxHeight,
    this.colorFilter,
    this.svgHeight,
    this.svgWidth,
    this.isLoading = false,
  }) : assert(
          ((child == null && svgPath.checkNotEmptyAndNull) || (child != null && svgPath == null)),
          "user one of them child or svgPath : ErrorMsg",
        );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        splashColor: splashColor,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(5.0),
          child: SizedBox(
            width: boxWidth ?? 18,
            height: boxHeight ?? 18,
            child: isLoading
                ? const LoadingComponent(
                    size: 12,
                    color: red,
                    loadingWidth: 0.9,
                  )
                : svgPath.checkNotEmptyAndNull
                    ? Center(
                        child: SvgPicture.asset(
                          svgPath!,
                          colorFilter: colorFilter,
                          height: svgHeight,
                          width: svgWidth,
                        ),
                      )
                    : child,
          ),
        ),
      ),
    );
  }
}
