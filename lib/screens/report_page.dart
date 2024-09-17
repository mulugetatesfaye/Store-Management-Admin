import 'package:ahmedadmin/screens/desktop_report_page.dart';
import 'package:ahmedadmin/screens/mobile_report_page.dart';
import 'package:flutter/material.dart';

class ReportPageResponsive extends StatelessWidget {
  const ReportPageResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Mobile view
          return MobileReportPage();
        } else {
          // Desktop view
          return DesktopReportPage();
        }
      },
    );
  }
}
