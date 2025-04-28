import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';


class ShowResult extends StatefulWidget {
  const ShowResult({
    super.key,
    required this.results,
  });

  final List<Map<String, dynamic>> results;

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  late List<Map<String, dynamic>> results;

  @override
  void initState() {
    super.initState();
    results = List.from(widget.results); // make a mutable copy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Power Estimation Results',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: results.isEmpty
          ?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No results to show now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ) :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ...results.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                final int wattage = item['wattage'] ?? 0;
                final int quantity = item['quantity'] ?? 0;
                final double dailyUsage = item['dailyUsage']?.toDouble() ?? 0.0;
                final double energy = wattage * quantity * dailyUsage / 1000;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: const {
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(100),
                              2: FixedColumnWidth(60),
                              3: FixedColumnWidth(80),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(color: Colors.grey[300]),
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Device', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Power (W)', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Daily Hrs', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${item['title']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$wattage'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$quantity'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$dailyUsage'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    10.asHeight,
                    Row(
                      children: [
                        CustomContainer(
                          height: 46, width: 240,
                          bgColor: AppColors.kDarkGreen1,
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Text(
                              'Energy Consumed: ${energy.toStringAsFixed(2)} kWh',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: IconButton(
                            icon:  Icon(Icons.delete, color: Colors.deepOrange.shade400, size: 24,),
                            onPressed: () {
                              setState(() {
                                results.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    10.asHeight,
                  ],
                );
              }).toList(),
              SizedBox(
                height: 46, width: 240,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      results.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  child: const Text(
                    'Remove All',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
