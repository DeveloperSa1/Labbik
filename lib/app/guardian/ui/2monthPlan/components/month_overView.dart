import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/sized.dart';
import 'package:labbaik/shared/store/CustomChart/widgets/sample_bar_chart.dart';
import 'package:labbaik/shared/store/CustomChart/widgets/sample_pie_chart.dart';

class MonthOverview extends StatefulWidget {
  const MonthOverview({super.key});

  @override
  State<MonthOverview> createState() => _MonthOverviewState();
}

class _MonthOverviewState extends State<MonthOverview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Divider(),
              SizedBox(height: 180, child: SamplePieChart()),
              Divider(),
              sizedH20,
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_SPACING_LARGE),
                child: SizedBox(height: 180, child: SampleBarChart()),
              ),
              
      ],
    );
  }
}
