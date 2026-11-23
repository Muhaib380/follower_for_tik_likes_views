import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/custom_button.dart';

/// "Enter your TikTok username" dialog.
/// Save dabane par username (bina @ ke) wapas deta hai, cancel par null.
class TiktokUsernameDialog extends StatefulWidget {
  final String? initial;

  const TiktokUsernameDialog({super.key, this.initial});

  @override
  State<TiktokUsernameDialog> createState() => _TiktokUsernameDialogState();
}

class _TiktokUsernameDialogState extends State<TiktokUsernameDialog> {
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.initial ?? '');
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    // Agar user ne @ likh diya to hata do
    final value = _ctrl.text.trim().replaceFirst('@', '');

    if (value.isEmpty) {
      setState(() => _error = 'Username likhein');
      return;
    }
    // Sirf letters, numbers, underscore aur period. 2 se 24 characters.
    if (!RegExp(r'^[A-Za-z0-9_.]{2,24}$').hasMatch(value)) {
      setState(() => _error = '2 se 24 characters: letters, numbers, _ aur .');
      return;
    }
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your TikTok username',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 22),

            // ---------- Username field ----------
            TextField(
              controller: _ctrl,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9_.@]')),
              ],
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'TikTok username',
                prefixText: '@',
                prefixStyle: theme.textTheme.bodyLarge
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                errorText: _error,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  '*TikTok username only contains letters, numbers, underscores, and periods.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            CustomButton(text: 'Save', onPressed: _submit),
            const SizedBox(height: 16),

            const Text(
              "Please make sure you aren't using a private profile",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
