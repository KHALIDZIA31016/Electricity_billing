import 'package:easy_stepper/easy_stepper.dart';
import 'package:electricity_app/core/widgets/custom_container.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/solar_result_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';

class SolarLoadView extends StatefulWidget {
  const SolarLoadView({super.key});

  @override
  State<SolarLoadView> createState() => _SolarLoadViewState();
}
class _SolarLoadViewState extends State<SolarLoadView> {
  int _currentStep = 0;
  final List<List<TextEditingController>> _controllers = List.generate(4, (_) => []);
  final List<int> _wattage = [
    40, 25, 10,
    150, 60, 100, 60,
    75, 100, 1500, 1000, 300, 200, 500, 1000,
    750
  ];

  final int panelCapacity = 350;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final List<int> sectionLengths = [3, 4, 8, 1];
    for (int i = 0; i < sectionLengths.length; i++) {
      _controllers[i] = List.generate(sectionLengths[i], (_) => TextEditingController());
    }
  }

  void _nextStep() {
    bool allFilled = _controllers[_currentStep].every((c) => c.text.trim().isNotEmpty);
    if (allFilled) {
      if (_currentStep < 3) {
        setState(() => _currentStep++);
      }
    } else {
      Get.snackbar(
        'Incomplete Fields',
        'Please fill in all the fields before proceeding.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submitForm() {
    bool allFilled = _controllers.expand((list) => list).every((controller) => controller.text.trim().isNotEmpty);
    List<int> enteredQuantities = [];
    for (var section in _controllers) {
      for (var controller in section) {
        enteredQuantities.add(int.tryParse(controller.text) ?? 0); // Add to the list
      }
    }
    if (!allFilled) {
      Get.snackbar(
        'Incomplete Fields',
        'Please fill all fields before submitting.',
        backgroundColor: AppColors.kDarkGreen1.withOpacity(0.4),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;

    }

    int totalLoad = 0;
    int index = 0;

    for (var section in _controllers) {
      for (var controller in section) {
        int quantity = int.tryParse(controller.text) ?? 0;
        totalLoad += quantity * _wattage[index];
        index++;
      }
    }

    int panelsRequired = (totalLoad / panelCapacity).ceil();

    Get.to(() => ResultSolar(
      totalLoad: totalLoad,
      panelsRequired: panelsRequired,
      panelCapacity: panelCapacity,
      enteredQuantities: enteredQuantities,
    ));
  }

  Widget _buildForm(List<String> labels, int stepIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(labels.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: TextFormField(
            controller: _controllers[stepIndex][i],
            keyboardType: TextInputType.number,
            textInputAction: i < labels.length - 1 ? TextInputAction.next : TextInputAction.done,
            style: TextStyle(color: AppColors.kDarkGreen1),
            decoration: InputDecoration(
              labelText: labels[i],
              labelStyle: TextStyle(color: AppColors.kGrey8E.withOpacity(0.6)),
              filled: true,
              fillColor: AppColors.kGrey8E.withOpacity(0.2),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContentForStep() {
    switch (_currentStep) {
      case 0:
        return _buildForm(['Tube light', 'Energy saver', 'LED bulbs'], 0);
      case 1:
        return _buildForm(['TV', 'LED TV', 'Computer', 'Laptop'], 1);
      case 2:
        return _buildForm([
          'Ceiling fan',
          'Stand fan',
          'Split AC',
          'Inverter AC',
          'Freezer',
          'Refrigerator',
          'Washing machine',
          'Iron'
        ], 2);
      case 3:
        return _buildForm(['Water pump'], 3);
      default:
        return const SizedBox();
    }
  }

  Widget _buildStepper() {
    return EasyStepper(
      activeStep: _currentStep,
      lineStyle: LineStyle(
        lineLength: 80,
        lineSpace: 10,
        lineType: LineType.dashed,
        lineThickness: 2,
        activeLineColor: AppColors.kDarkGreen1,
        defaultLineColor: AppColors.kGrey8E.withOpacity(0.3),
        finishedLineColor: Colors.blue,
      ),
      activeStepTextColor: AppColors.kDarkGreen1,
      finishedStepTextColor: Colors.blue,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 8,
      showStepBorder: false,
      onStepReached: (index) => setState(() => _currentStep = index),
      steps: [
        'Lighting',
        'Electronics',
        'Home Appliances',
        'Utility Equip.'
      ].asMap().entries.map((entry) {
        int i = entry.key;
        String title = entry.value;
        return EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: _currentStep >= i ? Colors.blue : Colors.grey,
            ),
          ),
          title: title,
          topTitle: i % 2 == 1,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Solar Load Calculator',
          borderColor: AppColors.kDarkGreen2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildStepper(),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: _buildContentForStep(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  CustomContainer(
                    height: 46,
                    width: 130,
                    ontap: _prevStep,
                    borderRadius: BorderRadius.circular(10),
                    bgColor: AppColors.kDarkGreen1.withOpacity(.7),
                    child: Center(
                      child: regularTextWidget(
                        textTitle: 'Previous',
                        textSize: 16,
                        textColor: AppColors.kWhite,
                      ),
                    ),
                  ),
                CustomContainer(
                  height: 46,
                  width: 130,
                  ontap: _currentStep == 3 ? _submitForm : _nextStep,
                  borderRadius: BorderRadius.circular(10),
                  bgColor: AppColors.kDarkGreen1.withOpacity(.7),
                  child: Center(
                    child: regularTextWidget(
                      textTitle: _currentStep == 3 ? 'Submit' : 'Next',
                      textSize: 16,
                      textColor: AppColors.kWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



