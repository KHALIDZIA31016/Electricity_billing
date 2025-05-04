import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/custom_appBar.dart';
import 'package:electricity_app/core/widgets/custom_container.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../controller/electric_companies_control.dart';

class ElectricCompaniesScreen extends StatefulWidget {
  ElectricCompaniesScreen({super.key});

  @override
  State<ElectricCompaniesScreen> createState() =>
      _ElectricCompaniesScreenState();
}

class _ElectricCompaniesScreenState extends State<ElectricCompaniesScreen> {
  final interstitialAdController = Get.find<InterstitialAdController>();
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  final ElectricCompaniesController controller = Get.put(
    ElectricCompaniesController(),
  );
  final List<Map<String, dynamic>> companies = [
    {
      "name": "IESCO",
      'location': 'Islamabad',
      "image": Assets.iesco.path,
      "url": "https://bill.pitc.com.pk/iescobill",
    },
    {
      "name": "LESCO",
      'location': 'Lahore',
      "image": Assets.lesco.path,
      "url": "https://bill.pitc.com.pk/lescobill",
    },
    {
      "name": "GEPCO",
      'location': 'Gujranwala',
      "image": Assets.gepco.path,
      "url": "https://bill.pitc.com.pk/gepcobill",
    },

    {
      "name": "PESCO",
      'location': 'Peshawar',
      "image": Assets.pesco.path,
      "url": "https://bill.pitc.com.pk/pescobill",
    },
    {
      "name": "FESCO",
      'location': 'Faisalabad',
      "image": Assets.fesco.path,
      "url": "https://bill.pitc.com.pk/fescobill",
    },
    {
      "name": "QESCO",
      'location': 'Quetta',
      "image": Assets.qesco.path,
      "url": "https://bill.pitc.com.pk/qescobill",
    },
    {
      "name": "MEPCO",
      'location': 'Multan',
      "image": Assets.mepco.path,
      "url": "https://bill.pitc.com.pk/mepcobill",
    },
    {
      "name": "HESCO",
      'location': 'Hyderabad ',
      "image": Assets.hesco.path,
      "url": "https://bill.pitc.com.pk/hescobill",
    },

    {
      "name": "K-ELECTRIC",
      'location': 'Karachi',
      "image": Assets.kelectric.path,
      "url": "https://staging.ke.com.pk:24555/",
    },
    {
      "name": "SEPCO",
      'location': 'Sukkur',
      "image": Assets.sepco.path,
      "url": "https://bill.pitc.com.pk/sepcobill",
    },

    {
      "name": "TESCO",
      'location': 'Tribal Areas',
      "image": Assets.teco.path,
      "url": "https://bill.pitc.com.pk/tescobill",
    },



  ];

  @override
  void initState() {
    super.initState();
    interstitialAdController.checkAndShowAdOnVisit();
    bannerAdController.loadBannerAd('ad4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electric Companies',
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad4'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.asHeight,
              Center(
                child: regularTextWidget(
                  textTitle: 'Electricity Supply Companies in Pakistan',
                  textSize: 18,
                  textColor: AppColors.kCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.asHeight,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.6 / 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return CustomContainer(
                    ontap: () {
                      interstitialAdController.checkAndShowAdOnVisit();
                      Get.to(() => ReferenceNumberScreen(
                          url: company["url"],
                          companyName: companies[index]['name']));
                    },
                    padding: const EdgeInsets.all(12),
                    borderRadius: BorderRadius.circular(16),
                    bgColor: AppColors.kWhite,
                    shadowColor: Colors.grey.shade400,
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(company['image'], scale: 3),
                        10.asHeight,
                        regularTextWidget(
                          textTitle: company['name'],
                          textSize: 20,
                          textColor: AppColors.kBlack0D.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                        regularTextWidget(
                          textTitle: company['location'],
                          textSize: 14,
                          textColor: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                },
              ),
              24.asHeight,
            ],
          ),
        ),
      ),
    );
  }
}

class ReferenceNumberScreen extends StatefulWidget {
  final String url;
  final String companyName;

  const ReferenceNumberScreen({super.key, required this.url, required this.companyName});

  @override
  State<ReferenceNumberScreen> createState() => _ReferenceNumberScreenState();
}

class _ReferenceNumberScreenState extends State<ReferenceNumberScreen> {
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  late final WebViewController controller;
  bool isLoading = true;
  TextEditingController refController = TextEditingController();
  List<String> savedReferences = [];

  @override
  void initState() {
    super.initState();
    _loadSavedReferences();
    bannerAdController.loadBannerAd('ad5');
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
            _injectReferenceNumber();
          },
        ),
      );
  }

  Future<void> _loadSavedReferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedReferences = prefs.getStringList('refs_${widget.companyName}') ?? [];
    });
  }
  Future<void> _saveReferenceNumber(String ref) async {
    if (ref.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a reference number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate reference number length
    if (ref.length != 14) {
      Get.snackbar(
        'Error',
        'Reference length must be exactly 14 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    if (!savedReferences.contains(ref)) {
      setState(() {
        savedReferences.add(ref);
      });
      await prefs.setStringList('refs_${widget.companyName}', savedReferences);
      Get.snackbar(
        'Success',
        'Reference number saved',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Info',
        'Reference number already exists',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
  }
  Future<void> _removeReferenceNumber(String ref) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedReferences.remove(ref);
    });
    await prefs.setStringList('refs_${widget.companyName}', savedReferences);
  }

  Future<void> _injectReferenceNumber() async {
    final ref = refController.text.trim();
    if (ref.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 500));

    await controller.runJavaScript('''
    (function() {
      function triggerClick(element) {
        const event = new MouseEvent('click', {
          view: window,
          bubbles: true,
          cancelable: true
        });
        element.dispatchEvent(event);
      }

      function tryInjectAndSearch() {
        const inputs = document.getElementsByTagName('input');
        let foundInput = false;

        for (let i = 0; i < inputs.length; i++) {
          const input = inputs[i];
          if (input.type === 'text' &&
              (input.name.toLowerCase().includes('ref') ||
               input.id.toLowerCase().includes('ref') ||
               input.placeholder.toLowerCase().includes('reference'))) {
            input.value = "$ref";
            foundInput = true;

            const buttons = document.querySelectorAll('button, input[type="submit"], input[type="button"]');
            for (let btn of buttons) {
              const txt = (btn.innerText || btn.value || '').toLowerCase();
              const id = (btn.id || '').toLowerCase();
              const name = (btn.name || '').toLowerCase();
              if (txt.includes('search') || txt.includes('submit') || id.includes('search') || name.includes('search')) {
                 setTimeout(() => triggerClick(btn), 100);
                break;
              }
            }
            break;
          }
        }

        if (!foundInput) {
          const forms = document.getElementsByTagName('form');
          for (let form of forms) {
            if (form.innerHTML.toLowerCase().includes('reference') ||
                form.innerHTML.toLowerCase().includes('consumer') ||
                form.innerHTML.toLowerCase().includes('account')) {
              const formInputs = form.getElementsByTagName('input');
              for (let input of formInputs) {
                if (input.type === 'text') {
                  input.value = "$ref";
                  const submit = form.querySelector('button, input[type="submit"], input[type="button"]');
                  if (submit) {
                    setTimeout(() => triggerClick(submit), 100);
                  }
                  break;
                }
              }
              break;
            }
          }
        }
      }

      if (document.readyState === 'complete') {
        tryInjectAndSearch();
      } else {
        window.addEventListener('load', tryInjectAndSearch);
      }
    })();
  ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: '${widget.companyName.toUpperCase()} Online Bill',
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: bannerAdController.getBannerAdWidget('ad5'), // Display the ad
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: regularTextWidget(
              textTitle: 'Enter your Reference Number here to check your electricity bill online',
              textSize: 18,
              textColor: Colors.black,
            ),
          ),
          10.asHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: refController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Reference Number',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              CustomContainer(
                ontap: () async {
                  final ref = refController.text.trim();
                  if (ref.isNotEmpty) {
                    controller.loadRequest(Uri.parse(widget.url));
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(70),
                        child: CustomAppBar(
                          title: ' ${widget.companyName.toUpperCase()} Bill',
                          leading: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
                          ),
                        ),
                      ),
                      body: Stack(children: [
                        WebViewWidget(controller: controller),
                      ]),
                    )));
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter a reference number',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                height: 46,
                width: 120,
                bgColor: AppColors.kDarkGreen1,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: regularTextWidget(
                    textTitle: 'Search Bill',
                    textSize: 18,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: AppColors.kDarkGreen1, thickness: 2, indent: 40, endIndent: 40),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContainer(
                height: 40,
                width: 160,
                ontap: () async {
                  final ref = refController.text.trim();
                  if (ref.isNotEmpty) {
                    await  _saveReferenceNumber(refController.text.trim());
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter a reference number',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                bgColor: AppColors.kDarkGreen1,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: regularTextWidget(
                      textTitle: 'Save Ref No',
                      textSize: 18,
                      textColor: Colors.white
                  ),
                ),
              ),
              CustomContainer(
                height: 40,
                width: 160,
                ontap: () {
                  if (savedReferences.isNotEmpty) {
                    Get.bottomSheet(
                      StatefulBuilder(  // Wrap with StatefulBuilder to allow setState within the bottom sheet
                        builder: (BuildContext context, StateSetter setModalState) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Saved References',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kDarkGreen1,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: savedReferences.length,
                                    itemBuilder: (context, index) {
                                      final ref = savedReferences[index];
                                      return ListTile(
                                          leading: CircleAvatar(
                                          backgroundColor: AppColors.kDarkGreen1,
                                          child: Text('${index + 1}', style: TextStyle(color: Colors.white))),
                                      title: Text(ref),
                                      trailing: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async {
                                      await _removeReferenceNumber(ref);
                                      setModalState(() {}); // Update the bottom sheet UI
                                      if (savedReferences.isEmpty) {
                                      Get.back(); // Close bottom sheet if no references left
                                      }
                                      },
                                      ),
                                      onTap: () {
                                      refController.text = ref;
                                      Get.back();
                                      },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                CustomContainer(
                                  ontap: () => Get.back(),
                                  height: 40,
                                  width: double.infinity,
                                  bgColor: AppColors.kDarkGreen1,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Center(
                                    child: Text(
                                      'Close',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    Get.snackbar(
                      'Info',
                      'No saved references found',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.blue,
                      colorText: Colors.white,
                    );
                  }
                },
                bgColor: AppColors.kDarkGreen1,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Text(
                    'Choose Ref No',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
