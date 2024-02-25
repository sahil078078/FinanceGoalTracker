import '../exported.dart'; 


class LoadingComponent extends StatelessWidget {
  final Color color;
  final double size;
  final double loadingWidth;
  const LoadingComponent({
    super.key,
    this.color = black,
    this.size = 20,
    this.loadingWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: loadingWidth,
        ),
      ),
    );
  }
}
