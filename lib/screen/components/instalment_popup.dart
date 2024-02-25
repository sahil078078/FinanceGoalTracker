import '../../exported.dart';

class InstalmentPopup extends StatefulWidget {
  final String title;
  final GoalModel goal;
  final double remainAmount;
  const InstalmentPopup({
    super.key,
    required this.title,
    required this.goal,
    required this.remainAmount,
  });

  @override
  State<InstalmentPopup> createState() => _InstalmentPopupState();
}

class _InstalmentPopupState extends State<InstalmentPopup> {
  DateTime? instalmentDate;
  final instalmentAmountController = TextEditingController();
  final instalmentDateController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final goalProvider = context.watch<GoalProvider>();
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: size.width * 0.75,
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Instalment',
                    style: MyTextStyle.semiBold.copyWith(
                      color: appPrimary,
                      fontSize: 25,
                    ),
                  ),
                  CustomIconButton(
                    onTap: () => backScreen(context: context),
                    svgPath: 'asset/icons/cross.svg',
                    colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                  )
                ],
              ),
              square15,
              //!TITLE
              Text(
                widget.title,
                maxLines: 2,
                style: MyTextStyle.medium.copyWith(
                  color: black,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 10),
              MyTextFormField(
                controller: instalmentAmountController,
                label: 'Amount',
                hintText: 'Enter instalment amount',
                keyboardType: TextInputType.number,
                inputFormatters: realNumberFormatter,
                maxLength: 9,
                validator: (rate) {
                  if (rate != null && rate.trim().isNotEmpty) {
                    final x = double.tryParse(rate.trim()) ?? 0;

                    if (x <= 0) {
                      return "Invalid amount";
                    } else if (x > widget.remainAmount) {
                      return 'Your ${indianFormat(widget.remainAmount)} just left';
                    } else {
                      return null;
                    }
                  }
                  return "Please enter amount";
                },
              ),
              const SizedBox(height: 8),
              MyTextFormField(
                controller: instalmentDateController,
                label: 'Date',
                hintText: 'Select instalment date',
                validator: (_) {
                  if (_ != null && _.trim().isNotEmpty) return null;
                  return 'Please select date';
                },
                readOnly: true,
                absorbing: true,
                onTap: () async {
                  final date = await getDate(
                    context: context,
                    initialDate: instalmentDate,
                  );
                  setState(
                    () {
                      if (date != null) {
                        instalmentDate = date;
                        instalmentDateController.text = ddMMyy(date);
                      } else {
                        instalmentDate = null;
                        instalmentDateController.clear();
                      }
                    },
                  );
                },
              ),

              square15,
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  isLoading: goalProvider.isLoadingForAddInstalment,
                  onTap: () async {
                    if (_key.currentState != null && _key.currentState!.validate()) {
                      final instalment = InstalmentModel(
                        amount: double.parse(instalmentAmountController.text.trim()),
                        date: instalmentDate!,
                      );
                      final isSuccess = await goalProvider.addInstalment(instalment: instalment, docID: widget.goal.id!);
                      if (isSuccess && context.mounted) {
                        goalProvider.readGoal();
                        backScreen(context: context);
                      }
                    }
                  },
                  width: 120,
                  title: 'Save',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
