import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/support/support_contact_option.dart';
import 'package:follower_for_tik_likes_views/Screens/support/support_faq_section.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  void _comingSoon(BuildContext context, String what) {
    // TODO: Open the real action later (email app, chat, phone dialer).
    // Email and phone need the url_launcher package.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$what is coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Help & Support',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 18),

              // ---------- Banner ----------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B2EE0), Color(0xFFB04DF0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'How can we help you?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Contact our team or browse the\nanswers to common questions.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.headset_mic_rounded,
                          color: Colors.white, size: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ---------- Contact options ----------
              Text('Contact us',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 14),
              SupportContactOptions(
                onEmail: () => _comingSoon(context, 'Email support'),
                onChat: () => _comingSoon(context, 'Live chat'),
                onCall: () => _comingSoon(context, 'Calling'),
              ),
              const SizedBox(height: 28),

              // ---------- FAQ ----------
              Text('Frequently asked questions',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 14),
              const SupportFaqSection(),
            ],
          ),
        ),
      ),
    );
  }
}