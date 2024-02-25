import '../exported.dart';

class CreateGoal extends StatefulWidget {
  const CreateGoal({super.key});

  @override
  State<CreateGoal> createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  final goalTitleController = TextEditingController();
  final goalAmountController = TextEditingController();
  final completionDateController = TextEditingController();
  DateTime? completionDate;

  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    goalTitleController.dispose();
    goalAmountController.dispose();
    completionDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generalProvider = Provider.of<GeneralProvider>(context);
    final goalProvider = Provider.of<GoalProvider>(context);

    final myGoal = generalProvider.selectedGoal;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackBtn(),
        title: const Text('Create Your Goal'),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 230,
                          height: 230,
                          child: Image.asset(
                            myGoal['png'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextFormField(
                        controller: goalTitleController,
                        label: 'Goal Title',
                        hintText: 'Enter your goal title',
                        validator: (goal) {
                          if (goal != null && goal.trim().isNotEmpty) return null;
                          return 'Please enter your goal';
                        },
                      ),
                      square15,
                      MyTextFormField(
                        controller: goalAmountController,
                        label: 'Amount',
                        hintText: 'Enter your budget amount',
                        keyboardType: TextInputType.number,
                        inputFormatters: realNumberFormatter,
                        maxLength: 9,
                        validator: amountValidator,
                      ),
                      square15,
                      MyTextFormField(
                        controller: completionDateController,
                        label: 'Completion Date',
                        hintText: 'Select completion date',
                        validator: (_) {
                          if (_ != null && _.trim().isNotEmpty) return null;
                          return 'Please select date';
                        },
                        readOnly: true,
                        absorbing: true,
                        onTap: () async {
                          final date = await getDate(
                            context: context,
                            initialDate: completionDate,
                          );

                          setState(
                            () {
                              if (date != null) {
                                completionDate = date;
                                completionDateController.text = ddMMyy(date);
                              } else {
                                completionDate = null;
                                completionDateController.clear();
                              }
                            },
                          );
                        },
                      ),
                      square15,
                    ],
                  ),
                ),
              ),
              square15,
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  isLoading: goalProvider.isLoadingForCreateGoal,
                  onTap: () async {
                    if (_key.currentState != null && _key.currentState!.validate()) {
                      final goal = GoalModel(
                        createdAt: DateTime.now(),
                        type: myGoal['title'],
                        goalTitle: goalTitleController.text.trim(),
                        amount: double.parse(goalAmountController.text.trim()),
                        completionDate: completionDate!,
                      );
                      final isSuccess = await goalProvider.createGoal(goal);
                      if (isSuccess && context.mounted) {
                        goalProvider.readGoal(); //READ-GOAl -> update UI
                        pushNRemoveUntil(context: context, newRouteName: RoutePath.home);
                      }
                    }
                  },
                  width: 120,
                  title: 'Create Goal',
                ),
              ),
              square15,
            ],
          ),
        ),
      ),
    );
  }
}
