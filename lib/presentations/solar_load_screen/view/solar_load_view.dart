import 'dart:convert';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:electricity_app/core/widgets/custom_container.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/solar_result_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
class SubmissionStorage {
  static const String key = 'submissions';

  static Future<List<Map<String, dynamic>>> loadSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> jsonData =  json.decode(jsonString);
    return jsonData.cast<Map<String, dynamic>>();
  }

  static Future<void> saveSubmissions(List<Map<String, dynamic>> submissions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(submissions);
    await prefs.setString(key, jsonString);
  }
}
class SolarLoadView extends StatefulWidget {
  const SolarLoadView({super.key});

  @override
  State<SolarLoadView> createState() => _SolarLoadViewState();
}

class _SolarLoadViewState extends State<SolarLoadView> {
  int _currentStep = 0;
  int _currentFieldIndex = 0; // To track the current input field index
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  final List<List<TextEditingController>> _controllers = List.generate(4, (_) => []);
  final List<int> _wattage = [
    40, 25, 10,
    150, 60, 100, 60,
    75, 100, 1500, 1000, 300, 200, 500, 1000,
    750
  ];
  final int panelCapacity = 350;
  final List<Map<String, dynamic>> _submissions = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadSubmissions();
    interstitialAdController.checkAndShowAdOnVisit();
    bannerAdController.loadBannerAd('ad3');
  }

  void _initializeControllers() {
    final List<int> sectionLengths = [3, 4, 8, 1];
    for (int i = 0; i < sectionLengths.length; i++) {
      _controllers[i] = List.generate(sectionLengths[i], (_) => TextEditingController());
    }
  }

  void _loadSubmissions() async {
    final loadedSubmissions = await SubmissionStorage.loadSubmissions();
    setState(() {
      _submissions.clear();
      _submissions.addAll(loadedSubmissions);
    });
  }

  void _nextField() {
    if (_currentFieldIndex < _controllers[_currentStep].length - 1) {
      FocusScope.of(context).nextFocus(); // Move focus to the next text field
      _currentFieldIndex++; // Increment the current field index
    } else {
      _nextStep(); // If it's the last field, proceed to next step
    }
  }

  void _nextStep() {
    // Validate and default empty/non-numeric inputs to zero
    for (var controller in _controllers[_currentStep]) {
      String text = controller.text.trim();
      if (text.isEmpty || int.tryParse(text) == null) {
        controller.text = '0';
      }
    }
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
        _currentFieldIndex = 0;
      });
      FocusScope.of(context).unfocus();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _currentFieldIndex = 0;
      });
    }
  }

  void _submitForm() async {
    // Save and show ad
    interstitialAdController.checkAndShowAdOnVisit();

    List<int> enteredQuantities = [];
    for (var section in _controllers) {
      for (var controller in section) {
        int quantity = int.tryParse(controller.text) ?? 0;
        enteredQuantities.add(quantity);
      }
    }

    int totalLoad = 0;
    for (int index = 0; index < enteredQuantities.length; index++) {
      totalLoad += enteredQuantities[index] * _wattage[index];
    }

    int panelsRequired = (totalLoad / panelCapacity).ceil();

    final submission = {
      'totalLoad': totalLoad,
      'panelsRequired': panelsRequired,
      'panelCapacity': panelCapacity,
      'enteredQuantities': enteredQuantities,
    };

    // Save submission to list and persist
    _submissions.add(submission);
    await SubmissionStorage.saveSubmissions(_submissions);

    // Navigate to Record Screen
    Get.to(SubmissionRecord(submissions: _submissions));

    // Reset controllers and state
    _initializeControllers();
    setState(() {
      _currentStep = 0;
      _currentFieldIndex = 0;
    });
  }

  Widget _buildStepper() {
    return SizedBox(
      height: 126,
      child: EasyStepper(
        activeStep: _currentStep,
        lineStyle: LineStyle(
          lineLength: 40,
          lineSpace: 6,
          lineType: LineType.dashed,
          lineThickness: 2,
          activeLineColor: AppColors.kDarkGreen1,
          defaultLineColor: AppColors.kGrey8E.withOpacity(0.3),
          finishedLineColor: Colors.blue,
        ),
        stepRadius: 18,
        finishedStepBackgroundColor: Colors.green,
        finishedStepTextColor: Colors.black,
        activeStepTextColor: Colors.blue,
        steps: [
          'Lighting',
          'Electronics',
          'Home Appliances',
          'Utility Equip.'
        ].asMap().entries.map((entry) {
          int index = entry.key;
          String title = entry.value;
          return EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey.shade400,
              child: CircleAvatar(
                  backgroundColor: _currentStep >= index ? Colors.white : Colors.grey),
            ),
            title: title,
            topTitle: index % 2 == 1,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContentForStep() {
    switch (_currentStep) {
      case 0:
        return _buildForm(
            ['Tube light', 'Energy saver', 'LED bulbs'], 0);
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

  Widget _buildForm(List<String> labels, int stepIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(labels.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: TextFormField(
            controller: _controllers[stepIndex][i],
            keyboardType: TextInputType.number,
            textInputAction: i < labels.length - 1
                ? TextInputAction.next
                : TextInputAction.done,
            style: TextStyle(color: AppColors.kDarkGreen1),
            decoration: InputDecoration(
              labelText: labels[i],
              labelStyle: TextStyle(color: AppColors.kGrey8E.withOpacity(0.6)),
              filled: true,
              fillColor: AppColors.kGrey8E.withOpacity(0.2),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onEditingComplete: () {
              if (i < labels.length - 1) {
                _nextField();
              } else {
                FocusScope.of(context).unfocus();
              }
            },
          ),
        );
      }),
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
            icon:
            const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad3'),
      ),
      body: Column(
        children: [
          _buildStepper(),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildContentForStep(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(SubmissionRecord(submissions: _submissions));
                    },
                    child: CustomContainer(
                      height: 46,
                      width: 200,
                      bgColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Text(
                          'Submissions Records',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                  ontap:
                  _currentStep == 3 ? _submitForm : _nextField, // Submit or Next
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

class SubmissionRecord extends StatelessWidget {
  final List<Map<String, dynamic>> submissions;

  SubmissionRecord({super.key, required this.submissions});

  @override
  Widget build(BuildContext context) {
    final BannerAdController bannerAdController = Get.find<BannerAdController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Submissions Record',
          borderColor: AppColors.kDarkGreen2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon:
            const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad2'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (submissions.isNotEmpty) ...[
                for (int index = 0; index < submissions.length; index++)
                  CustomContainer(
                    height: 200,
                    borderRadius: BorderRadius.circular(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    child: InkWell(
                      onTap: () {
                        var submission = submissions[index];
                        Get.to(
                          DetailScreen(
                            totalLoad: submission['totalLoad'],
                            panelsRequired: submission['panelsRequired'],
                            panelCapacity: submission['panelCapacity'],
                            enteredQuantities:
                            List<int>.from(submission['enteredQuantities']),
                          ),
                        );
                      },
                      child: CustomContainer(
                        margin: EdgeInsets.symmetric(horizontal: 16,),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              dense: true,
                              title: regularTextWidget(textTitle: 'Submitted Record: ', textSize: 18, textColor: Colors.black, fontWeight: FontWeight.w600),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 16,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Divider(color: Colors.green, thickness: 2),
                            10.asHeight,
                            CustomContainer(
                              borderRadius: BorderRadius.circular(10),
                              bgColor: Colors.grey.shade300,
                              child: ListTile(
                                dense: true,
                                title: const Text(
                                    'Total Load: ', style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.w600)),
                                trailing: Text(
                                    '${submissions[index]['totalLoad']} Watts', style: TextStyle(fontSize: 16,color: Colors.black, )),
                              ),
                            ),
                            10.asHeight,
                            CustomContainer(
                              borderRadius: BorderRadius.circular(10),
                              bgColor: Colors.grey.shade300,
                              child: ListTile(
                                dense: true,
                                title: const Text('Panels Required: ', style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.w600)),
                                trailing: Text(
                                    '${submissions[index]['panelsRequired']} panels', style: TextStyle(fontSize: 16,color: Colors.green, )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ] else ...[
                const Center(child: Text('No submissions available.')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int totalLoad;
  final int panelsRequired;
  final int panelCapacity;
  final List<int> enteredQuantities;

  const DetailScreen({
    super.key,
    required this.totalLoad,
    required this.panelsRequired,
    required this.panelCapacity,
    required this.enteredQuantities,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      'Tube Light',
      'Energy Saver',
      'LED bulbs',
      'TV',
      'LED TV',
      'Computer',
      'Laptop',
      'Ceiling Fan',
      'Stand Fan',
      'Split AC',
      'Inverter AC',
      'Freezer',
      'Refrigerator',
      'Washing Machine',
      'Iron',
      'Water Pump'
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Solar Load Details',
          borderColor: AppColors.kDarkGreen2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              Wrap(
                children: [
                  regularTextWidget(
                    textTitle: '🔋 Total Load (in watts): ',
                    textSize: 18,
                    textColor: AppColors.kPineGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  regularTextWidget(
                    textTitle: '$totalLoad Watts',
                    textSize: 18,
                    textColor: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColors.kDarkGreen1,
                indent: 60,
                endIndent: 60,
                thickness: 2,
              ),
              Wrap(
                children: [
                  regularTextWidget(
                    textTitle: '☀️ Panels Required: ',
                    textSize: 18,
                    textColor: AppColors.kPineGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  regularTextWidget(
                    textTitle: '$panelsRequired panels',
                    textSize: 18,
                    textColor: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              regularTextWidget(
                textTitle: " (Each $panelCapacity Watts)",
                textSize: 16,
                textColor: AppColors.kBlack,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.kDarkGreen1, thickness: 2),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    bgColor: AppColors.kEmeraldGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        titles[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        '${enteredQuantities[index]}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
