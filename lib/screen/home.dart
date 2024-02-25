import 'components/instalment_popup.dart';
import '../exported.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Provider.of<GoalProvider>(context, listen: false).isRefreshForReadRecord) {
        _refresh(context);
      }
    });
  }

  Future<void> _refresh(BuildContext context) async {
    Provider.of<GoalProvider>(context, listen: false).readGoal();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = context.watch<AuthProvider>();
    final goalProvider = context.watch<GoalProvider>();
    final myGoals = goalProvider.myGoals;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('My Goals'),
        actions: [
          CustomIconButton(
            svgPath: 'asset/icons/add.svg',
            boxHeight: 24,
            boxWidth: 24,
            onTap: () => nextScreen(
              context: context,
              routeName: RoutePath.selectGoalScreen,
            ),
          ),
          const SizedBox(width: 5),
          CustomIconButton(
            isLoading: auth.isLoadingForLogout,
            svgPath: 'asset/icons/logout 1.svg',
            colorFilter: const ColorFilter.mode(red, BlendMode.srcIn),
            boxHeight: 22,
            boxWidth: 22,
            onTap: () => auth.logout().then(
              (value) {
                if (true) {
                  pushNRemoveUntil(
                    context: context,
                    newRouteName: RoutePath.loginScreen,
                  );
                }
              },
            ),
          ),
          square15,
        ],
      ),
      body: Padding(
        padding: padding,
        child: goalProvider.isLoadingForReadRecord
            ? const LoadingComponent()
            : myGoals.isEmpty
                ? RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Goal List Is Empty',
                              style: MyTextStyle.medium.copyWith(
                                fontSize: 18,
                                color: black,
                              ),
                            ),
                            Text(
                              'Create goal and track it.',
                              style: MyTextStyle.medium.copyWith(
                                fontSize: 15,
                                color: grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: ListView.builder(
                      itemCount: myGoals.length,
                      itemBuilder: (context, index) {
                        final goal = myGoals[index];
                        return GoalCard(goal: goal);
                      },
                    ),
                  ),
      ),
    );
  }
}

class GoalCard extends StatefulWidget {
  const GoalCard({
    super.key,
    required this.goal,
  });

  final GoalModel goal;

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  double per = 0;
  double totalAmount = 0;
  double collectAmount = 0;
  double remainAmount = 0;
  String image = 'asset/images/home.png';

  @override
  void initState() {
    super.initState();

    debugPrint('goal : ${widget.goal.toJson()}');

    // Collection
    // ignore: avoid_function_literals_in_foreach_calls
    widget.goal.instalment.forEach((e) {
      collectAmount += e.amount;
    });
    //Total
    totalAmount = widget.goal.amount;

    //Percentage
    if (collectAmount != 0 && totalAmount != 0) {
      per = collectAmount / totalAmount;
    }

    //remainAmount
    remainAmount = totalAmount - collectAmount;

    //Image
    int index = userGoal.indexWhere((element) => element['title'] == widget.goal.type);
    if (index != -1) {
      image = userGoal[index]['png'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  color: grey50,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
              square15,
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.goal.goalTitle,
                              style: MyTextStyle.semiBold.copyWith(color: black, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CustomIconButton(
                            padding: EdgeInsets.zero,
                            boxHeight: 22,
                            boxWidth: 22,
                            svgHeight: 22,
                            svgWidth: 22,
                            onTap: () => nextScreen(
                              context: context,
                              routeName: RoutePath.goalDetailsScreen,
                              arguments: widget.goal,
                            ),
                            svgPath: 'asset/icons/box-arrow-in-up-right.svg',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: indianFormat(collectAmount),
                            style: MyTextStyle.semiBold.copyWith(
                              color: green,
                              fontSize: 13.5,
                            ),
                          ),
                          TextSpan(
                            text: '  of  ',
                            style: MyTextStyle.regular.copyWith(
                              color: grey700,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: indianFormat(totalAmount),
                            style: MyTextStyle.medium.copyWith(
                              color: black,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (remainAmount > 0)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomTextButton(
                          title: 'Instalment',
                          onPressed: () async {
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => InstalmentPopup(
                                remainAmount: remainAmount,
                                title: widget.goal.goalTitle,
                                goal: widget.goal,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressBar(
            percentage: per,
            trailing: Text(
              '${twoDigitPer(per)}%',
              style: MyTextStyle.medium.copyWith(color: grey600, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}
