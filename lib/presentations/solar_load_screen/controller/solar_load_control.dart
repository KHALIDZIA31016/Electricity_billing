// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
//
// import '../view/solar_result_view.dart';
//
// class SolarLoadController extends GetxController {
//   int _currentStep = 0;
//   final List<List<TextEditingController>> _controllers = List.generate(4, (_) => []);
//   final List<int> _wattage = [
//     40, 25, 10,
//     150, 60, 100, 60,
//     75, 100, 1500, 1000, 300, 200, 500, 1000,
//     750
//   ];
//
//   final int panelCapacity = 350;
//
//   // Getter for the current step
//   int get currentStep => _currentStep;
//
//   // Method to initialize controllers
//   void initializeControllers() {
//     final List<int> sectionLengths = [3, 4, 8, 1];
//     for (int i = 0; i < sectionLengths.length; i++) {
//       _controllers[i] = List.generate(sectionLengths[i], (_) => TextEditingController());
//     }
//   }
//
//   // Method for the next step
//   void nextStep() {
//     if (_controllers[_currentStep].every((c) => c.text.trim().isNotEmpty)) {
//       if (_currentStep < 3) {
//         _currentStep++;
//         update();
//       }
//     } else {
//       Get.snackbar(
//         'Incomplete Fields',
//         'Please fill in all the fields before proceeding.',
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   // Method for the previous step
//   void prevStep() {
//     if (_currentStep > 0) {
//       _currentStep--;
//       update();
//     }
//   }
//
//   // Method to submit the form
//   void submitForm() {
//     bool allFilled = _controllers.expand((list) => list).every((controller) => controller.text.trim().isNotEmpty);
//
//     if (!allFilled) {
//       Get.snackbar(
//         'Incomplete Fields',
//         'Please fill all fields before submitting.',
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     int totalLoad = 0;
//     int index = 0;
//
//     for (var section in _controllers) {
//       for (var controller in section) {
//         int quantity = int.tryParse(controller.text) ?? 0;
//         totalLoad += quantity * _wattage[index];
//         index++;
//       }
//     }
//
//     int panelsRequired = (totalLoad / panelCapacity).ceil();
//
//     Get.to(() => ResultSolar(
//       totalLoad: totalLoad,
//       panelsRequired: panelsRequired,
//       panelCapacity: panelCapacity,
//     ));
//   }
//
//   // Method to build the form for specific step
//   List<Widget> buildForm(BuildContext context) {
//     List<String> labels;
//
//     switch (_currentStep) {
//       case 0:
//         labels = ['Tube light', 'Energy saver', 'LED bulbs'];
//         break;
//       case 1:
//         labels = ['TV', 'LED TV', 'Computer', 'Laptop'];
//         break;
//       case 2:
//         labels = [
//           'Ceiling fan',
//           'Stand fan',
//           'Split AC',
//           'Inverter AC',
//           'Freezer',
//           'Refrigerator',
//           'Washing machine',
//           'Iron'
//         ];
//         break;
//       case 3:
//         labels = ['Water pump'];
//         break;
//       default:
//         return [];
//     }
//
//     return List.generate(labels.length, (i) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//         child: TextFormField(
//           controller: _controllers[_currentStep][i],
//           keyboardType: TextInputType.number,
//           textInputAction: i < labels.length - 1 ? TextInputAction.next : TextInputAction.done,
//           decoration: InputDecoration(
//             labelText: labels[i],
//             filled: true,
//             fillColor: Colors.grey.withOpacity(0.2),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//           ),
//         ),
//       );
//     });
//   }
// }