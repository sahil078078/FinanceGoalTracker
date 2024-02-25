
import '../exported.dart';

class GoalDetailsScreen extends StatefulWidget {
  final GoalModel goal;
  const GoalDetailsScreen({super.key, required this.goal});

  @override
  State<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends State<GoalDetailsScreen> {
  /// for title and amount
  Widget _keyValue({
    required String key,
    required double value,
    Color keyColor = grey700,
    Color valueColor = violet,
    TextStyle? keyStyle,
    TextStyle? valueStyle,
  }) =>
      Column(
        children: [
          Text(
            key,
            style: keyStyle ??
                MyTextStyle.medium.copyWith(
                  fontSize: 18,
                  color: keyColor,
                ),
          ),
          Text(
            indianFormat(value),
            style: valueStyle ??
                MyTextStyle.semiBold.copyWith(
                  fontSize: 20,
                  color: valueColor,
                ),
          ),
        ],
      );

  Widget pointNote({required String key, required String value}) => Padding(
        padding: const EdgeInsets.only(bottom: 2.5),
        child: CustomRichText(
          text1: '\u2022  ',
          text2: key,
          text3: "  :  ",
          text4: value,
          style1: MyTextStyle.medium.copyWith(fontSize: 20, color: grey500),
          style2: MyTextStyle.regular.copyWith(fontSize: 13, color: grey800),
          style4: MyTextStyle.medium.copyWith(fontSize: 11.5, color: black),
        ),
      );

  // Dynamic
  double per = 0;
  double totalAmount = 0;
  double collectAmount = 0;
  double remainAmount = 0;
  String image = 'asset/images/home.png';
  Duration leftDate = const Duration();
  double instalmentPerMonth = 0;

  @override
  void initState() {
    super.initState();

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

    //remail days
    final d = widget.goal.completionDate.difference(DateTime.now());
    leftDate = d;

    if (remainAmount > 0 && d.inDays > 0) {
      instalmentPerMonth = remainAmount / (leftDate.inDays / 30);
    } else {
      instalmentPerMonth = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackBtn(),
        title: const Text('Goal Description'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! TITLE
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.goal.goalTitle,
                  textAlign: TextAlign.center,
                  style: MyTextStyle.bold.copyWith(
                    color: black,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              //! COMPLETION DATE
              Align(
                alignment: Alignment.center,
                child: CustomRichText(
                  text1: 'Target Date',
                  text2: '  :  ',
                  text3: specialFormate(widget.goal.completionDate, 'MMM dd,yyyy'),
                  textAlign: TextAlign.center,
                  style1: MyTextStyle.medium.copyWith(
                    fontSize: 13,
                    color: grey700,
                  ),
                  style2: MyTextStyle.medium.copyWith(
                    fontSize: 12,
                    color: grey500,
                  ),
                  style3: MyTextStyle.semiBold.copyWith(
                    fontSize: 13,
                    color: blue,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //! TOTAL
                      _keyValue(
                        key: 'Goal',
                        value: totalAmount,
                        keyColor: grey800,
                      ),
                      const SizedBox(height: 25),
                      //! LACK-REMAIN
                      _keyValue(
                        key: 'Lack',
                        value: remainAmount,
                        keyColor: grey400,
                        valueColor: redMsg,
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 70,
                    animation: true,
                    animationDuration: 3000,
                    startAngle: 0,
                    percent: per <= 1 ? per : 1,
                    circularStrokeCap: CircularStrokeCap.round,
                    lineWidth: 8,
                    rotateLinearGradient: true,
                    progressColor: green,
                    backgroundColor: grey100,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            image,
                            color: black,
                          ),
                        ),
                        Text(
                          '${twoDigitPer(per)}%',
                          style: MyTextStyle.medium.copyWith(
                            color: grey800,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              //! ACCUMULATE - COLLECTED
              Align(
                alignment: Alignment.center,
                child: _keyValue(
                  key: 'Accumulated Money',
                  value: collectAmount,
                  keyStyle: MyTextStyle.medium.copyWith(
                    fontSize: 22,
                    color: grey600,
                  ),
                  valueStyle: MyTextStyle.semiBold.copyWith(
                    fontSize: 25,
                    color: green,
                  ),
                ),
              ),
              square15,
              Text(
                'Your Progress',
                style: MyTextStyle.light.copyWith(
                  fontSize: 13.5,
                  color: grey900,
                ),
              ),
              const SizedBox(height: 7),
              LinearProgressBar(
                thickness: 12,
                padding: EdgeInsets.zero,
                percentage: per,
              ),
              const SizedBox(height: 30),
              Text(
                'Key notes',
                style: MyTextStyle.light.copyWith(
                  fontSize: 13.5,
                  color: grey900,
                ),
              ),
              const SizedBox(height: 7),
              pointNote(
                key: 'Created date',
                value: ddMMyy(widget.goal.createdAt),
              ),
              pointNote(
                key: 'completion date',
                value: ddMMyy(widget.goal.completionDate),
              ),
              pointNote(
                key: 'Left duration',
                value: '${leftDate.inDays / 30} Month',
              ),
              pointNote(
                key: 'Instalment per month',
                value: indianFormat(instalmentPerMonth),
              ),
              const SizedBox(height: 20),

              //!RECORD
              Text(
                'History of instalment',
                style: MyTextStyle.light.copyWith(
                  fontSize: 13.5,
                  color: grey900,
                ),
              ),
              const SizedBox(height: 10),
              Timeline.tileBuilder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                builder: TimelineTileBuilder.fromStyle(
                  itemCount: widget.goal.instalment.length,

                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ddMMMyy(widget.goal.instalment[index].date),
                          style: MyTextStyle.medium.copyWith(fontSize: 11, color: grey700),
                        ),
                        Text(
                          indianFormat(widget.goal.instalment[index].amount),
                          style: MyTextStyle.regular.copyWith(fontSize: 12, color: black),
                        ),
                      ],
                    ),
                  ),
                  indicatorStyle: IndicatorStyle.dot,
                  connectorStyle: ConnectorStyle.solidLine,
                  endConnectorStyle: ConnectorStyle.transparent,
                  nodePositionBuilder: (context, index) => 0.00,
                  addAutomaticKeepAlives: true,
                  // itemExtentBuilder: (context, index) => 00,
                ),
                theme: TimelineThemeData(
                  color: appPrimary,
                  indicatorTheme: const IndicatorThemeData(
                    size: 8,
                    position: 0.175,
                    color: green,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 1.2,
                    indent: 0,
                    color: grey400,
                    space: 10,
                  ),
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
