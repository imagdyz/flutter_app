import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Thyroid App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorCard(),
              const SizedBox(height: 24),
              _buildSectionTitle("💡 نصائح للوقاية والحماية:"),
              const SizedBox(height: 12),
              _buildInfoSection(
                items: [
                  "تناول غذاء متوازن يحتوي على اليود الطبيعي.",
                  "الابتعاد عن الضغوط النفسية والتوتر المزمن.",
                  "إجراء فحص دوري لهرمونات الغدة (TSH) سنوياً.",
                  "ممارسة الرياضة بانتظام لتنشيط الحرق.",
                  "النوم الكافي لتحسين كفاءة الجهاز المناعي.",
                ],
                icon: Icons.check_circle_outline,
                iconColor: Colors.teal,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle("⚠️ محذورات طبية هامة:"),
              const SizedBox(height: 12),
              _buildInfoSection(
                items: [
                  "تجنب تناول أدوية الغدة بدون استشارة دقيقة.",
                  "إهمال أعراض الخمول أو النشاط الزائد.",
                  "إيقاف الجرعات فجأة دون الرجوع للطبيب المختص.",
                  "تناول المكملات العشبية مجهولة المصدر.",
                  "تجاهل تضخم الرقبة أو صعوبة البلع.",
                ],
                icon: Icons.error_outline,
                iconColor: Colors.redAccent,
                isWarning: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade400, Colors.teal.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Padding(
        padding:  EdgeInsets.all(20),
        child: Row(
          children: [
             CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white, size: 45),
            ),
             SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                   Text(
                    "د/ أحمد محمود",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 4),
                   Text(
                    "استشاري أمراض الغدد الصماء ,السكري",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                   Divider(color: Colors.white30, thickness: 1),
                   Text(
                    "خبرة +15 عاماً في اضطرابات الغدة.",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoSection({
    required List<String> items,
    required IconData icon,
    required Color iconColor,
    bool isWarning = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: iconColor.withValues(alpha: .2)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[100],
          height: 1,
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(icon, color: iconColor, size: 22),
            title: Text(
              items[index],
              style: TextStyle(
                fontSize: 14,
                color: isWarning ? Colors.red[900] : Colors.black87,
                height: 1.4,
              ),
            ),
          );
        },
      ),
    );
  }
}