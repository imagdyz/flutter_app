import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'major.dart'; // تأكد أن الصفحة دي موجودة عندك بنفس الاسم

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. تعريف الـ Controllers لسحب البيانات
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // 2. دالة تسجيل الدخول
  Future<void> _signIn() async {
    // التأكد أن الحقول ليست فارغة قبل الإرسال
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال البريد الإلكتروني وكلمة المرور")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // عملية تسجيل الدخول عبر فيربيز
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // التأكد أن الصفحة لسه موجودة قبل الانتقال (لحل مشكلة الخط الأزرق)
      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Major()),
      );

    } on FirebaseAuthException catch (e) {
      // طباعة الخطأ واستخدامه عشان نشيل تحذير unused_catch_clause
      debugPrint("Firebase Error: ${e.code}");
      
      String message = "خطأ في البريد الإلكتروني أو كلمة المرور";
      
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      // إيقاف علامة التحميل
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // تنظيف الـ Controllers
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.sick, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              const Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "بوابة الاطباء المعتمدة لتشخيص الغدة الدرقية",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("اتصال امن ومشفر بالكامل", style: TextStyle(fontSize: 18, color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 40),
              
              // حقل البريد الإلكتروني
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              
              // حقل كلمة المرور
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              
              // زر تسجيل الدخول
              SizedBox(
                width: double.infinity,
                height: 50,
                child: _isLoading 
                  ? const Center(child: CircularProgressIndicator()) 
                  : ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A80F0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('Log In', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}