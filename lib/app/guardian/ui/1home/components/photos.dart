import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:labbaik/app/guardian/widgets/homeCard.dart';
import 'package:labbaik/imports.dart';

class StudentReports extends StatefulWidget {
  const StudentReports({super.key});

  @override
  State<StudentReports> createState() => _StudentReportsState();
}

class _StudentReportsState extends State<StudentReports> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...List.generate(13, (index) => HomeCard())],
    );
  }
}
