import '../../exported.dart';

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({
    super.key,
    this.percentage = 0.0,
    this.animationDuration = 3000,
    this.thickness = 9.0,
    this.barRadius = 9,
    this.trailing,
    this.padding,
  }) : _per = percentage <= 1 ? percentage : 1;

  ///! set percentage max 100% to eliminate error
  final double _per;

  final double percentage, thickness, barRadius;
  final int animationDuration;
  final Widget? trailing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      percent: _per,
      animationDuration: animationDuration, // millisecond
      lineHeight: thickness,
      barRadius: Radius.circular(barRadius),
      backgroundColor: grey100,
      animateFromLastPercent: true,
      trailing: trailing,
      clipLinearGradient: true,
      padding: padding ?? const EdgeInsets.only(right: 10),
      linearGradient: const LinearGradient(
        colors: [blue, orange, orange, green],
        stops: [0.15, 0.3, 0.65, 0.8],
      ),
    );
  }
}
