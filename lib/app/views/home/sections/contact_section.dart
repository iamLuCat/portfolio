import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  final bool isDesktop;
  final String langCode;

  const ContactSection({super.key, required this.isDesktop, required this.langCode});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    final lang = widget.langCode;
    if (!_formKey.currentState!.validate()) return;

    final subject = Uri.encodeComponent('Contact from ${_nameCtrl.text}');
    final body = Uri.encodeComponent('${_messageCtrl.text}\n\nFrom: ${_nameCtrl.text} <${_emailCtrl.text}>');
    final mailto = Uri.parse('mailto:vu.pq06@gmail.com?subject=$subject&body=$body');

    setState(() => _isSending = true);
    try {
      final launched = await launchUrl(mailto);
      setState(() => _isSending = false);
      if (launched) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppResources.getString(lang, 'contact_success'))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppResources.getString(lang, 'contact_error'))));
      }
    } catch (_) {
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppResources.getString(lang, 'contact_error'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;
    final lang = widget.langCode;
    return Container(
      color: AppColor.dark,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            AppResources.getString(lang, 'contact_title'),
            style: const TextStyle(color: AppColor.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              children: [
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _contactRow(Icons.phone, "+84 338 953 981"),
                      _contactRow(Icons.email, "vu.pq06@gmail.com"),
                      _contactRow(Icons.location_on, "Ho Chi Minh City"),
                    ],
                  ),
                ),
                SizedBox(height: isDesktop ? 0 : 40, width: 50),
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _inputField(AppResources.getString(lang, 'contact_name_hint'), controller: _nameCtrl),
                        const SizedBox(height: 15),
                        _inputField(AppResources.getString(lang, 'contact_email_hint'), controller: _emailCtrl, keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 15),
                        _inputField(AppResources.getString(lang, 'contact_message_hint'), controller: _messageCtrl, maxLines: 4),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isSending ? null : _sendEmail,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(_isSending ? AppResources.getString(lang, 'contact_sending') : AppResources.getString(lang, 'contact_send'), style: const TextStyle(color: AppColor.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Copyright @2025 Pham Quang Vu. All Rights Reserved.",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.grey),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColor.whiteOpacity10, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: AppColor.primary),
          ),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(color: AppColor.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _inputField(String hint, {int maxLines = 1, TextEditingController? controller, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (v) {
        if (v == null || v.trim().isEmpty) return '${hint} is required';
        if (keyboardType == TextInputType.emailAddress) {
          final email = v.trim();
          final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
          if (!emailRegex.hasMatch(email)) return 'Invalid email';
        }
        if (maxLines > 1 && (v.trim().length < 10)) return 'Message too short';
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}
