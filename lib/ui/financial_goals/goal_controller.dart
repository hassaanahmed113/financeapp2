import 'package:get/get.dart';

class GoalController extends GetxController {
  RxString username = ''.obs;
  RxBool convertToPKR = false.obs; // Track the selected currency
  RxDouble progressval = 0.0.obs;
  RxDouble percentage = 0.0.obs;
  RxDouble remainingperc = 0.0.obs;
  RxString nameNotification = ''.obs;
  RxDouble percNotification = 0.0.obs;
  RxString nameNotification1 = ''.obs;
  RxString percNotification1 = ''.obs;
  List goalData = [];

  addData(String goalname, String curentsaving, String totalsaving) {
    Map<String, dynamic> newData = {
      'goalname': goalname,
      'curentsaving': curentsaving,
      'totalsaving': totalsaving,
    };

    goalData.add(newData);
    print("DATAAAAAAAAA $goalData");
    goalNotification();
    update();
  }

  void goalNotification() {
    for (int i = 0; i < goalData.length; i++) {
      percentage.value = double.parse(goalData[i]['curentsaving']) /
          double.parse(goalData[i]['totalsaving']) *
          100;
      if (percentage.value > 95) {
        nameNotification.value = goalData[i]['goalname'];
        percNotification.value = percentage.value;
      }
    }
    print(nameNotification);
    print(percNotification);
  }

  double calculateProgress(double currentValue, double maxValue) {
    // Ensure that the values are within a valid range
    if (currentValue < 0.0) {
      currentValue = 0.0;
    }

    if (maxValue <= 0.0) {
      return 0.0; // Avoid division by zero
    }

    if (currentValue > maxValue) {
      currentValue = maxValue;
    }

    // Calculate the progress value between 0.0 and 1.0
    return currentValue / maxValue;
  }

  updateData(int index, String amount) {
    if (double.parse(amount) > double.parse(goalData[index]['totalsaving'])) {
      print('Not Updated');
    } else {
      goalData[index]['curentsaving'] = amount;
    }
    goalNotification();
    update();
  }

  deleteData(int index) {
    goalData.removeAt(index);

    update();
  }
}