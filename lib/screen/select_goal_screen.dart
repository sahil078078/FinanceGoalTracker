import '../exported.dart';

class SelectGoalScreen extends StatelessWidget {
  const SelectGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final goalProvider = Provider.of<GeneralProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackBtn(),
        title: const Text('Select Your Goal'),
      ),
      body: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AlignedGridView.count(
                crossAxisCount: (size.width / 145).floor(),
                itemCount: userGoal.length,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                itemBuilder: (context, index) {
                  final goal = userGoal[index];
                  return SelectedGoalCard(
                    goal: goal,
                    isSelected: goalProvider.selectedGoal == goal,
                    onTap: () => goalProvider.changeGoal(goal),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                width: 100,
                onTap: () => nextScreen(
                  context: context,
                  routeName: RoutePath.createGoal,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class SelectedGoalCard extends StatelessWidget {
  const SelectedGoalCard({
    super.key,
    required this.goal,
    this.onTap,
    this.isSelected = false,
  });

  final Map<String, dynamic> goal;
  final GestureTapCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: grey50,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? appPrimary : grey300,
            width: isSelected ? 1.2 : 0.45,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                width: double.maxFinite,
                child: Image(
                  image: AssetImage(goal['png']),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                  color: isSelected ? appPrimary : grey500,
                ),
              ),
            ),
            Center(
              child: Text(
                goal['title'],
                style: MyTextStyle.bold.copyWith(
                  fontSize: isSelected ? 16 : 15.5,
                  color: isSelected ? black : grey600,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
