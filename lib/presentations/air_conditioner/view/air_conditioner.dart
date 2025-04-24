import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';

class AcSizeCalculatorScreen extends StatefulWidget {
  @override
  _AcSizeCalculatorScreenState createState() => _AcSizeCalculatorScreenState();
}

class _AcSizeCalculatorScreenState extends State<AcSizeCalculatorScreen> {
  final TextEditingController roomLengthController = TextEditingController();
  final TextEditingController roomWidthController = TextEditingController();
  final TextEditingController roomHeightController = TextEditingController();
  final TextEditingController numberOfPersonsController = TextEditingController();

  String selectedLengthUnit = 'ft';
  String selectedWidthUnit = 'ft';
  String selectedHeightUnit = 'ft';

  final List<String> unitOptions = ['ft', 'm', 'cm'];

  String result = '';

  void calculateACSize() {
    double length = double.tryParse(roomLengthController.text) ?? 0;
    double width = double.tryParse(roomWidthController.text) ?? 0;
    double height = double.tryParse(roomHeightController.text) ?? 0;
    int persons = int.tryParse(numberOfPersonsController.text) ?? 0;

    double volume = length * width * height;
    double baseBTU = volume * 5;

    // Add 600 BTU per person
    double totalBTU = baseBTU + (persons * 600);

    double tons = totalBTU / 12000;

    setState(() {
      result = '${tons.toStringAsFixed(2)} ton';
    });
  }

  void resetFields() {
    roomLengthController.clear();
    roomWidthController.clear();
    roomHeightController.text = '8';
    numberOfPersonsController.text = '1';
    setState(() {
      result = '';
    });
  }

  Widget buildTextField(String label, TextEditingController controller, String selectedUnit, void Function(String?) onChanged) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: label,
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedUnit,
                isExpanded: true,
                onChanged: onChanged,
                items: unitOptions.map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Center(child: Text(unit)),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'AC size Calculator',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhite,
              size: 22,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              CustomContainer(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                bgColor: AppColors.kDarkGreen1.withValues(alpha: .44),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temperature:', style: TextStyle(fontSize: 16)),
                    Center(child: Text('50°C', style: TextStyle(fontSize: 16))),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Required Data :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              buildTextField('Room Length', roomLengthController, selectedLengthUnit,
                      (value) => setState(() => selectedLengthUnit = value!)),
              buildTextField('Room Width', roomWidthController, selectedWidthUnit,
                      (value) => setState(() => selectedWidthUnit = value!)),
              buildTextField('Room height', roomWidthController, selectedHeightUnit,
                      (value) => setState(() => selectedHeightUnit = value!)),

              const SizedBox(height: 12),

              TextField(
                controller: numberOfPersonsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number Of Persons',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 20),
             Wrap(
               spacing: 20,
               children: [
                 SizedBox(
                   height: 46,
                   child: ElevatedButton(
                     style: ButtonStyle(
                         backgroundColor: WidgetStatePropertyAll(AppColors.kDarkGreen1.withValues(alpha: .43)),
                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8.0), // Adjust this value
                             ))),
                     onPressed: calculateACSize,
                     child: regularTextWidget(textTitle: 'Calculate Power', textSize: 18, textColor: AppColors.kWhite),
                   ),
                 ),
                 SizedBox(
                   height: 46,
                   child: ElevatedButton(
                     style: ButtonStyle(
                         backgroundColor: WidgetStatePropertyAll(AppColors.kDarkLighter.withValues(alpha: .23)),
                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8.0), // Adjust this value
                             ))),
                     onPressed: resetFields,
                     child: regularTextWidget(textTitle: 'Reset Fields', textSize: 18, textColor: AppColors.kWhite),
                   ),
                 ),
               ],
             ),

              const SizedBox(height: 40),
              CustomContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                bgColor: Colors.blue[300],
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    const Text(
                      '(AC Size) Air Conditioner Size',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      result.isEmpty ? 'Result Will Show Here' : result,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
