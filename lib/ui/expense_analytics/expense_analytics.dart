import 'package:finance_track_app/core/theme.dart';
import 'package:finance_track_app/core/utils.dart';
import 'package:finance_track_app/core/widgets/app_bar.dart';
import 'package:finance_track_app/core/widgets/spaces_widget.dart';
import 'package:finance_track_app/core/widgets/text_widgets.dart';
import 'package:finance_track_app/ui/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseAnalytics extends StatelessWidget {
  ExpenseAnalytics({super.key});
  final ThemeController _themeController = Get.put(ThemeController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var month = DateFormat.MMMM().format(date);
    return Obx(() => Scaffold(
          backgroundColor: _themeController.isDarkMode.value
              ? Colors.black87
              : ColorConstraint().primaryColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: GlobalAppBar1('EXPENSE ANALYTICS')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                      () => customTextWidget(
                          month,
                          _themeController.isDarkMode.value
                              ? ColorConstraint().primaryColor
                              : ColorConstraint().backColor,
                          FontWeight.w700,
                          32),
                    ),
                    Spaces().midw(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: customTextWidget(
                          'Analytics',
                          _themeController.isDarkMode.value
                              ? ColorConstraint().primaryColor
                              : ColorConstraint().secondaryColor,
                          FontWeight.w600,
                          20),
                    ),
                  ],
                ),
                Spaces().largeh(),
                SizedBox(
                    height: Get.height * 0.65,
                    width: Get.width,
                    child: GetBuilder<DashboardController>(
                      builder: (controller) {
                        List<double> perExpenseDouble = controller
                            .dataAnalytics!.perExpense!
                            .map((dynamic item) => item is int
                                ? item.toDouble()
                                : double.tryParse(item.toString()) ?? 0.0)
                            .toList();
                        List<double> perSavingDouble = controller
                            .dataAnalytics!.perSaving!
                            .map((dynamic item) => item is int
                                ? item.toDouble()
                                : double.tryParse(item.toString()) ?? 0.0)
                            .toList();
                        List<String> timeData = controller.dataAnalytics!.time!
                            .map((dynamic item) => item.toString())
                            .toList();
                        List<String> incomeData = controller
                            .dataAnalytics!.perIncome!
                            .map((dynamic item) => item.toString())
                            .toList();
                        return chartToRun(perExpenseDouble, perSavingDouble,
                            timeData, incomeData);
                      },
                    )),
              ]),
            ),
          ),
        ));
  }

  Widget chartToRun(chart1, chart2, time, perincome) {
    return GetBuilder<DashboardController>(builder: (controller) {
      if (controller.dataAnalytics?.time == null ||
          controller.dataAnalytics?.perSaving == null) {
        return Center(
            child: Text(
          'No Expenses available',
          style: TextStyle(
            color: _themeController.isDarkMode.value
                ? ColorConstraint().primaryColor
                : ColorConstraint().secondaryColor,
          ),
        ));
      }

      try {
        LabelLayoutStrategy? xContainerLabelLayoutStrategy;
        ChartData chartData;
        ChartOptions chartOptions = const ChartOptions();

        chartOptions = const ChartOptions(
          dataContainerOptions: DataContainerOptions(
            startYAxisAtDataMinRequested: true,
          ),
        );

        chartData = ChartData(
          dataRows: [chart1, chart2],
          yUserLabels: perincome,
          xUserLabels: time,
          dataRowsLegends: const ['Expenses', 'Savings'],
          chartOptions: chartOptions,
        );

        var lineChartContainer = LineChartTopContainer(
          chartData: chartData,
          xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
        );

        var lineChart = LineChart(
          painter: LineChartPainter(
            lineChartContainer: lineChartContainer,
          ),
        );

        return lineChart;
      } catch (e) {
        print('Error in chartToRun: $e');
        return const Text('Error generating chart');
      }
    });
  }
}
