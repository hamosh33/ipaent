import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(TextEncryptorApp());
}

class TextEncryptorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextEncryptorScreen(),
    );
  }
}

class TextEncryptorScreen extends StatefulWidget {
  @override
  _TextEncryptorScreenState createState() => _TextEncryptorScreenState();
}

class _TextEncryptorScreenState extends State<TextEncryptorScreen> {
  TextEditingController _inputController = TextEditingController();
  String _outputText = '';

  void _encodeText() {
    final inputText = _inputController.text;
    final encodedText = base64.encode(utf8.encode(inputText));
    setState(() {
      _outputText = encodedText;
    });
  }

  void _decodeText() {
    final inputText = _inputController.text;
    final decodedText = utf8.decode(base64.decode(inputText));
    setState(() {
      _outputText = decodedText;
    });
  }

  void _copyTextToClipboard() {
    Clipboard.setData(ClipboardData(text: _outputText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم نسخ النص المشفر إلى الحافظة'),
        backgroundColor: Colors.black.withOpacity(0.7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تشفير وفك تشفير النصوص'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.content_copy),
            onPressed: _copyTextToClipboard,
          ),
        ],
        backgroundColor: Colors.orange, // لون الخلفية لشريط العنوان
        elevation: 0, // إزالة الظل
        titleTextStyle: TextStyle(
          fontSize: 24, // حجم النص
          fontWeight: FontWeight.bold, // نمط الخط
          color: Colors.white, // لون النص
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
        ),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'النص المدخل',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: _encodeText,
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // لون الزر
              ),
              child: Text('تشفير'),
            ),
            ElevatedButton(
              onPressed: _decodeText,
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // لون الزر
              ),
              child: Text('فك التشفير'),
            ),
            ElevatedButton(
              onPressed: _copyTextToClipboard,
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // لون الزر
              ),
              child: Text('نسخ النص المشفر'),
            ),
            SizedBox(height: 16),
            Text('النص المشفر/المفكوك:', style: TextStyle(color: Colors.white)),
            Text(
              _outputText,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
