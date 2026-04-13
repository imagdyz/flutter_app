import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SymptomsPage extends StatefulWidget {
  const SymptomsPage({super.key});

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  final List<Map<String, dynamic>> symptomsData = [
    // Hypo
    {
      'id': 'weight_gain',
      'title': 'زيادة الوزن',
      'icon': Icons.add_chart,
      'type': 'hypo',
    },
    {
      'id': 'extreme_fatigue',
      'title': 'الإرهاق الشديد',
      'icon': Icons.battery_alert,
      'type': 'hypo',
    },
    {
      'id': 'slow_heartbeat',
      'title': 'بطء ضربات القلب',
      'icon': Icons.favorite_border,
      'type': 'hypo',
    },
    {
      'id': 'depression',
      'title': 'الاكتئاب',
      'icon': Icons.sentiment_dissatisfied,
      'type': 'hypo',
    },
    {
      'id': 'slow_thinking',
      'title': 'بطء التفكير وضعف التركيز',
      'icon': Icons.psychology_alt,
      'type': 'hypo',
    },
    {
      'id': 'dry_skin',
      'title': 'جفاف الجلد',
      'icon': Icons.dry_cleaning,
      'type': 'hypo',
    },
    {
      'id': 'sensitivity_to_cold',
      'title': 'الحساسية للبرد',
      'icon': Icons.ac_unit,
      'type': 'hypo',
    },
    {
      'id': 'constipation',
      'title': 'الإمساك',
      'icon': Icons.airline_seat_legroom_reduced,
      'type': 'hypo',
    },
    {
      'id': 'facial_swelling',
      'title': 'تورم الوجه',
      'icon': Icons.face,
      'type': 'hypo',
    },
    {
      'id': 'puffy_eyes',
      'title': 'انتفاخ حول العين',
      'icon': Icons.remove_red_eye,
      'type': 'hypo',
    },
    {
      'id': 'hoarseness',
      'title': 'بحة الصوت',
      'icon': Icons.record_voice_over,
      'type': 'hypo',
    },
    {
      'id': 'cold_extremities',
      'title': 'برودة الأطراف',
      'icon': Icons.pan_tool,
      'type': 'hypo',
    },
    {
      'id': 'heavy_periods',
      'title': 'غزارة الدورة الشهرية',
      'icon': Icons.water_drop,
      'type': 'hypo',
    },
    {
      'id': 'slow_movement',
      'title': 'بطء الحركة',
      'icon': Icons.directions_walk,
      'type': 'hypo',
    },

    // Hyper
    {
      'id': 'weight_loss',
      'title': 'فقدان الوزن رغم زيادة الشهية',
      'icon': Icons.trending_down,
      'type': 'hyper',
    },
    {
      'id': 'fast_heartbeat',
      'title': 'تسارع ضربات القلب',
      'icon': Icons.monitor_heart,
      'type': 'hyper',
    },
    {
      'id': 'palpitations',
      'title': 'خفقان القلب',
      'icon': Icons.monitor_heart,
      'type': 'hyper',
    },
    {
      'id': 'excessive_sweating',
      'title': 'التعرق الزائد',
      'icon': Icons.water_drop,
      'type': 'hyper',
    },
    {
      'id': 'hand_tremors',
      'title': 'رعشة اليد',
      'icon': Icons.back_hand,
      'type': 'hyper',
    },
    {
      'id': 'stress_and_anxiety',
      'title': 'توتر وقلق',
      'icon': Icons.psychology,
      'type': 'hyper',
    },
    {
      'id': 'mood_swings',
      'title': 'تقلبات مزاجية',
      'icon': Icons.mood_bad,
      'type': 'hyper',
    },
    {
      'id': 'insomnia',
      'title': 'الأرق',
      'icon': Icons.bedtime,
      'type': 'hyper',
    },
    {
      'id': 'frequent_diarrhea',
      'title': 'الإسهال المتكرر',
      'icon': Icons.wc,
      'type': 'hyper',
    },
    {
      'id': 'heat_intolerance',
      'title': 'عدم تحمل الحرارة',
      'icon': Icons.thermostat,
      'type': 'hyper',
    },
    {
      'id': 'bulging_eyes',
      'title': 'جحوظ العينين',
      'icon': Icons.remove_red_eye,
      'type': 'hyper',
    },
    {
      'id': 'hyperactivity',
      'title': 'نشاط زائد / فرط حركة',
      'icon': Icons.directions_run,
      'type': 'hyper',
    },
    {
      'id': 'menstrual_irregularities',
      'title': 'اضطراب الدورة الشهرية',
      'icon': Icons.water_drop,
      'type': 'hyper',
    },

    // Both
    {
      'id': 'goiter',
      'title': 'تضخم الغدة (تورم بالرقبة)',
      'icon': Icons.person_pin,
      'type': 'both',
    },
    {
      'id': 'hair_loss',
      'title': 'تساقط الشعر',
      'icon': Icons.content_cut,
      'type': 'both',
    },
    {
      'id': 'muscle_weakness',
      'title': 'ضعف العضلات',
      'icon': Icons.fitness_center,
      'type': 'both',
    },
  ];

  List<String> selectedSymptoms = [];
  bool isLoading = false;

  String _calculateDiagnosis() {
    int hypo = 0;
    int hyper = 0;

    for (var id in selectedSymptoms) {
      var s = symptomsData.firstWhere((e) => e['id'] == id);
      if (s['type'] == 'hypo') {
        hypo++;
      } else if (s['type'] == 'hyper') {
        hyper++;
      } else {
        hypo++;
        hyper++;
      }
    }

    if (selectedSymptoms.length < 2) {
      return "يرجى اختيار عرضين على الأقل للتشخيص.";
    }

    if (hypo > hyper) {
      return "يوجد اشتباه في خمول الغدة الدرقية (Hypothyroidism).";
    } else if (hyper > hypo) {
      return "يوجد اشتباه في نشاط الغدة الدرقية (Hyperthyroidism).";
    } else {
      return "الأعراض مختلطة، يرجى إجراء فحص TSH للتأكد.";
    }
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.medical_information, color: Colors.blue, size: 50),
            SizedBox(height: 10),
            Text(
              "نتيجة التشخيص المبدئي",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          result,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("موافق", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    if (selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("برجاء اختيار الأعراض أولاً")),
      );
      return;
    }

    setState(() => isLoading = true);

    String result = _calculateDiagnosis();

    try {
      await FirebaseFirestore.instance.collection('results').add({
        'symptoms': selectedSymptoms,
        'diagnosis': result,
        'date': DateTime.now(),
      });

      _showResultDialog(result);
    } catch (e) {
      _showResultDialog("حدث خطأ أثناء حفظ البيانات");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Thyroid App"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "اختر الأعراض التي تشعر بها:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: symptomsData.length,
                  itemBuilder: (context, index) {
                    final item = symptomsData[index];
                    final isSelected = selectedSymptoms.contains(item['id']);

                    return GestureDetector(
                      onTap: () => setState(() {
                        isSelected
                            ? selectedSymptoms.remove(item['id'])
                            : selectedSymptoms.add(item['id']);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.withValues(alpha: 0.1)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item['icon'],
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                if (selectedSymptoms.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.analytics, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "التشخيص المبدئي الفوري:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _calculateDiagnosis(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  // child: ElevatedButton(
                  //   onPressed: isLoading ? null : _handleSave,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blue,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  //   child: isLoading
                  //       ? const CircularProgressIndicator(color: Colors.white)
                  //       : const Text(
                  //           "حفظ البيانات وإظهار التشخيص النهائي",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  // ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
