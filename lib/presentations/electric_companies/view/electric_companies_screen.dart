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
      "name": "SEPCO",
      'location': 'Sukkur',
      "image": Assets.sepco.path,
      "url": "https://bill.pitc.com.pk/sepcobill",
    },

    {
      "name": "LESCO",
      'location': 'Lahore',
      "image": Assets.lesco.path,
      "url": "https://bill.pitc.com.pk/lescobill",
    },

    {
      "name": "PESCO",
      'location': 'Peshawar',
      "image": Assets.pesco.path,
      "url": "https://bill.pitc.com.pk/pescobill",
    },

    {
      "name": "QESCO",
      'location': 'Quetta',
      "image": Assets.qesco.path,
      "url": "https://bill.pitc.com.pk/qescobill",
    },

    {
      "name": "TESCO",
      'location': 'Tribal Areas',
      "image": Assets.teco.path,
      "url": "https://bill.pitc.com.pk/tescobill",
    },

    {
      "name": "GEPCO",
      'location': 'Gujranwala',
      "image": Assets.gepco.path,
      "url": "https://bill.pitc.com.pk/gepcobill",
    },

    {
      "name": "FESCO",
      'location': 'Faisalabad',
      "image": Assets.fesco.path,
      "url": "https://bill.pitc.com.pk/fescobill",
    },

    {
      "name": "MEPCO",
      'location': 'Faisalabad',
      "image": Assets.mepco.path,
      "url": "https://bill.pitc.com.pk/mepcobill",
    },

    {
      "name": "HESCO",
      'location': 'Faisalabad',
      "image": Assets.hesco.path,
      "url": "https://bill.pitc.com.pk/hescobill",

    },

    {
      "name": "K-ELECTRIC",
      'location': 'Karachi',
      "image": Assets.kelectric.path,
      "url": "https://staging.ke.com.pk:24555/",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
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
        child: bannerAdController.getBannerAdWidget('ad4'), // Display the ad
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

  const ReferenceNumberScreen({
    super.key,
    required this.url,
    required this.companyName
  });

  @override
  State<ReferenceNumberScreen> createState() => _ReferenceNumberScreenState();
}

class _ReferenceNumberScreenState extends State<ReferenceNumberScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  String? referenceNumber;
  TextEditingController refController = TextEditingController();
  List<String> savedReferences = []; // List to store all saved references

  @override
  void initState() {
    super.initState();
    _loadSavedReferenceNumbers(); // Load all saved references
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

  // Load all saved reference numbers for this company
  Future<void> _loadSavedReferenceNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Get the current reference number
      referenceNumber = prefs.getString('ref_${widget.companyName}') ?? '';
      refController.text = referenceNumber!;

      // Get all saved references for this company
      savedReferences = prefs.getStringList('refs_${widget.companyName}') ?? [];
      if (referenceNumber!.isNotEmpty && !savedReferences.contains(referenceNumber)) {
        savedReferences.add(referenceNumber!);
      }
    });
  }

  // Save reference number and add to list
  Future<void> _saveReferenceNumber(String ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ref_${widget.companyName}', ref);

    // Add to saved references list if not already there
    if (!savedReferences.contains(ref)) {
      setState(() {
        savedReferences.add(ref);
      });
      await prefs.setStringList('refs_${widget.companyName}', savedReferences);
    }
  }

  // Remove a reference number from saved list
  Future<void> _removeReferenceNumber(String ref) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedReferences.remove(ref);
    });
    await prefs.setStringList('refs_${widget.companyName}', savedReferences);

    // If we're removing the current reference, clear the text field
    if (refController.text == ref) {
      setState(() {
        refController.text = '';
      });
      await prefs.remove('ref_${widget.companyName}');
    }
  }

  Future<void> _injectReferenceNumber() async {
    final ref = refController.text.trim();
    if (ref.isEmpty) return;

    // Wait an extra delay to ensure the page is fully ready
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

            // Try to find the matching submit or search button
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

      // Wait until DOM is stable
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
          title: widget.companyName.toUpperCase(),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(26.0),
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
                await _saveReferenceNumber(ref);
                controller.loadRequest(Uri.parse(widget.url));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
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
                      body: Stack(
                        children: [
                          WebViewWidget(controller: controller),

                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            height: 46,
            width: 180,
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
          const SizedBox(height: 20),
          Divider(color: AppColors.kDarkGreen1,thickness: 2, indent: 40, endIndent: 40,),
          const SizedBox(height: 60),
          CustomContainer(
            height: 50,
            width: double.infinity,
            ontap: () {
              Get.to(() => SavedReferencesScreen(companyName: widget.companyName));
            },
            margin: EdgeInsets.symmetric(horizontal: 20),
            bgColor: AppColors.kDarkGreen1,
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                'Saved Reference Numbers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kWhite,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class SavedReferencesScreen extends StatefulWidget {
  final String companyName;

  const SavedReferencesScreen({super.key, required this.companyName});

  @override
  State<SavedReferencesScreen> createState() => _SavedReferencesScreenState();
}

class _SavedReferencesScreenState extends State<SavedReferencesScreen> {
  List<String> savedReferences = [];

  @override
  void initState() {
    super.initState();
    _loadSavedReferences();
  }

  Future<void> _loadSavedReferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedReferences = prefs.getStringList('refs_${widget.companyName}') ?? [];
    });
  }

  Future<void> _removeReference(String ref) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedReferences.remove(ref);
    });
    await prefs.setStringList('refs_${widget.companyName}', savedReferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Saved References',
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: savedReferences.length,
        itemBuilder: (context, index) {
          final ref = savedReferences[index];
          return CustomContainer(
            height: 60,
            width: double.infinity,
            bgColor: Colors.grey.shade200,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('${index + 1}'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reference Number:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(ref, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeReference(ref),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//
// class ReferenceNumberScreen extends StatefulWidget {
//   final String url;
//   final String companyName;
//
//   const ReferenceNumberScreen({
//     super.key,
//     required this.url,
//     required this.companyName
//   });
//
//   @override
//   State<ReferenceNumberScreen> createState() => _ReferenceNumberScreenState();
// }
//
// class _ReferenceNumberScreenState extends State<ReferenceNumberScreen> {
//   late final WebViewController controller;
//   bool isLoading = true;
//   String? referenceNumber;
//   TextEditingController refController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedReferenceNumber();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             setState(() => isLoading = true);
//           },
//           onPageFinished: (url) {
//             setState(() => isLoading = false);
//             _injectReferenceNumber();
//           },
//         ),
//       );
//   }
//
//   // Modified to load reference number specific to this company
//   Future<void> _loadSavedReferenceNumber() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       referenceNumber = prefs.getString('ref_${widget.companyName}') ?? '';
//       refController.text = referenceNumber!;
//     });
//   }
//
//   // Modified to save reference number specific to this company
//   Future<void> _saveReferenceNumber(String ref) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('ref_${widget.companyName}', ref);
//   }
//
//   Future<void> _injectReferenceNumber() async {
//     final ref = refController.text.trim();
//     if (ref.isNotEmpty) {
//       await controller.runJavaScript('''
//       // Function to trigger a click event
//       function triggerClick(element) {
//         const event = new MouseEvent('click', {
//           view: window,
//           bubbles: true,
//           cancelable: true
//         });
//         element.dispatchEvent(event);
//       }
//
//       // Try to find input fields that might be for reference number
//       const inputs = document.getElementsByTagName('input');
//       let foundInput = false;
//
//       for (let i = 0; i < inputs.length; i++) {
//         const input = inputs[i];
//         // Check for common attributes that might indicate a reference number field
//         if (input.type === 'text' &&
//             (input.name.includes('ref') ||
//              input.id.includes('ref') ||
//              input.placeholder.toLowerCase().includes('reference'))) {
//           input.value = '$ref';
//           foundInput = true;
//
//           // Try to find and click the search button
//           setTimeout(() => {
//             // Look for buttons that might be the search button
//             const buttons = document.getElementsByTagName('button');
//             for (let j = 0; j < buttons.length; j++) {
//               const button = buttons[j];
//               if (button.innerText.toLowerCase().includes('search') ||
//                   button.innerText.toLowerCase().includes('submit') ||
//                   button.id.includes('search') ||
//                   button.name.includes('search')) {
//                 triggerClick(button);
//                 break;
//               }
//             }
//
//             // Also check input elements of type submit or button
//             const submitInputs = document.querySelectorAll('input[type="submit"], input[type="button"]');
//             for (let k = 0; k < submitInputs.length; k++) {
//               const submitInput = submitInputs[k];
//               if (submitInput.value.toLowerCase().includes('search') ||
//                   submitInput.value.toLowerCase().includes('submit')) {
//                 triggerClick(submitInput);
//                 break;
//               }
//             }
//           }, 500);
//
//           break;
//         }
//       }
//
//       // If we didn't find a specific input field, try to find any search form
//       if (!foundInput) {
//         setTimeout(() => {
//           const forms = document.getElementsByTagName('form');
//           for (let l = 0; l < forms.length; l++) {
//             const form = forms[l];
//             if (form.innerHTML.toLowerCase().includes('reference') ||
//                 form.innerHTML.toLowerCase().includes('consumer') ||
//                 form.innerHTML.toLowerCase().includes('account')) {
//               const inputs = form.getElementsByTagName('input');
//               for (let m = 0; m < inputs.length; m++) {
//                 if (inputs[m].type === 'text') {
//                   inputs[m].value = '$ref';
//                   const submit = form.querySelector('button, input[type="submit"], input[type="button"]');
//                   if (submit) {
//                     triggerClick(submit);
//                   }
//                   break;
//                 }
//               }
//               break;
//             }
//           }
//         }, 500);
//       }
//     ''');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: CustomAppBar(
//           title: widget.companyName.toUpperCase(),
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(26.0),
//             child: TextFormField(
//               controller: refController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter Reference Number',
//                 labelStyle: const TextStyle(color: Colors.grey),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//           CustomContainer(
//             ontap: () async {
//               final ref = refController.text.trim();
//               if (ref.isNotEmpty) {
//                 await _saveReferenceNumber(ref);
//                 controller.loadRequest(Uri.parse(widget.url));
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         Scaffold(
//                           appBar: AppBar(title: Text('${widget
//                               .companyName} Bill')),
//                           body: Stack(
//                             children: [
//                               WebViewWidget(controller: controller),
//                               if (isLoading)
//                                 Center(child: CircularProgressIndicator()),
//                             ],
//                           ),
//                         ),
//                   ),
//                 );
//               }
//             },
//             height: 46,
//             width: 180,
//             bgColor: AppColors.kDarkGreen1,
//             borderRadius: BorderRadius.circular(10),
//             child: Center(
//               child: regularTextWidget(
//                 textTitle: 'Search Bill',
//                 textSize: 18,
//                 textColor: Colors.white,
//               ),
//             ),
//           ),
//
//
//           CustomContainer(
//             margin: EdgeInsets.symmetric(vertical: 30),
//             height: 50,
//             width: 300,
//             borderRadius: BorderRadius.circular(10),
//             bgColor: AppColors.kDarkGreen1,
//             child: Center(child: regularTextWidget(
//                 textTitle: 'Choose Reference Number',
//                 textSize: 16,
//                 textColor: Colors.white)),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }




//
// class ReferenceNumberScreen extends StatefulWidget {
//   final String url;
//   final String companyName;
//
//   const ReferenceNumberScreen({
//     super.key,
//     required this.url,
//     required this.companyName
//   });
//
//   @override
//   State<ReferenceNumberScreen> createState() => _ReferenceNumberScreenState();
// }
//
// class _ReferenceNumberScreenState extends State<ReferenceNumberScreen> {
//   late final WebViewController controller;
//   bool isLoading = true;
//   String? referenceNumber;
//   TextEditingController refController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedReferenceNumber();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             setState(() => isLoading = true);
//           },
//           onPageFinished: (url) {
//             setState(() => isLoading = false);
//             // Inject JavaScript after page loads
//             _injectReferenceNumber();
//           },
//         ),
//       );
//   }
//
//   Future<void> _loadSavedReferenceNumber() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       referenceNumber = prefs.getString('referenceNumber') ?? '';
//       refController.text = referenceNumber!;
//     });
//   }
//
//   Future<void> _saveReferenceNumber(String ref) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('referenceNumber', ref);
//   }
//
//   Future<void> _injectReferenceNumber() async {
//     final ref = refController.text.trim();
//     if (ref.isNotEmpty) {
//       await controller.runJavaScript('''
//       // Function to trigger a click event
//       function triggerClick(element) {
//         const event = new MouseEvent('click', {
//           view: window,
//           bubbles: true,
//           cancelable: true
//         });
//         element.dispatchEvent(event);
//       }
//
//       // Try to find input fields that might be for reference number
//       const inputs = document.getElementsByTagName('input');
//       let foundInput = false;
//
//       for (let i = 0; i < inputs.length; i++) {
//         const input = inputs[i];
//         // Check for common attributes that might indicate a reference number field
//         if (input.type === 'text' &&
//             (input.name.includes('ref') ||
//              input.id.includes('ref') ||
//              input.placeholder.toLowerCase().includes('reference'))) {
//           input.value = '$ref';
//           foundInput = true;
//
//           // Try to find and click the search button
//           setTimeout(() => {
//             // Look for buttons that might be the search button
//             const buttons = document.getElementsByTagName('button');
//             for (let j = 0; j < buttons.length; j++) {
//               const button = buttons[j];
//               if (button.innerText.toLowerCase().includes('search') ||
//                   button.innerText.toLowerCase().includes('submit') ||
//                   button.id.includes('search') ||
//                   button.name.includes('search')) {
//                 triggerClick(button);
//                 break;
//               }
//             }
//
//             // Also check input elements of type submit or button
//             const submitInputs = document.querySelectorAll('input[type="submit"], input[type="button"]');
//             for (let k = 0; k < submitInputs.length; k++) {
//               const submitInput = submitInputs[k];
//               if (submitInput.value.toLowerCase().includes('search') ||
//                   submitInput.value.toLowerCase().includes('submit')) {
//                 triggerClick(submitInput);
//                 break;
//               }
//             }
//           }, 500);
//
//           break;
//         }
//       }
//
//       // If we didn't find a specific input field, try to find any search form
//       if (!foundInput) {
//         setTimeout(() => {
//           const forms = document.getElementsByTagName('form');
//           for (let l = 0; l < forms.length; l++) {
//             const form = forms[l];
//             if (form.innerHTML.toLowerCase().includes('reference') ||
//                 form.innerHTML.toLowerCase().includes('consumer') ||
//                 form.innerHTML.toLowerCase().includes('account')) {
//               const inputs = form.getElementsByTagName('input');
//               for (let m = 0; m < inputs.length; m++) {
//                 if (inputs[m].type === 'text') {
//                   inputs[m].value = '$ref';
//                   const submit = form.querySelector('button, input[type="submit"], input[type="button"]');
//                   if (submit) {
//                     triggerClick(submit);
//                   }
//                   break;
//                 }
//               }
//               break;
//             }
//           }
//         }, 500);
//       }
//     ''');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: CustomAppBar(
//           title: widget.companyName.toUpperCase(),
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(26.0),
//             child: TextFormField(
//               controller: refController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter Reference Number',
//                 labelStyle: const TextStyle(color: Colors.grey),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//           CustomContainer(
//             ontap: () async {
//               final ref = refController.text.trim();
//               if (ref.isNotEmpty) {
//                 await _saveReferenceNumber(ref);
//                 // Load the URL without parameters (some sites might not use them)
//                 controller.loadRequest(Uri.parse(widget.url));
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => Scaffold(
//                       appBar: AppBar(title: Text('${widget.companyName} Bill')),
//                       body: Stack(
//                         children: [
//                           WebViewWidget(controller: controller),
//                           // if (isLoading)
//                             // Center(child: CircularProgressIndicator()),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//             height: 46,
//             width: 180,
//             bgColor: AppColors.kDarkGreen1,
//             borderRadius: BorderRadius.circular(10),
//             child: Center(
//               child: regularTextWidget(
//                 textTitle: 'Search Bill',
//                 textSize: 18,
//                 textColor: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





