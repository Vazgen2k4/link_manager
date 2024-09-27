import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToKosButton extends StatelessWidget {
  const ToKosButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_month_outlined),
      tileColor: AppColors.main.withOpacity(.3),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 3,
          color: AppColors.main,
        ),
      ),
      title: const Text.rich(
        TextSpan(
          text: 'Сcылка на расписание',
          children: [
            TextSpan(
              text: "\tKOS",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        style: TextStyle(fontSize: 20),
      ),
      onTap: () async {
        final url = Uri.parse('https://kos.cvut.cz/schedule');
        await launchUrl(url);
      },
    );
  }
}
