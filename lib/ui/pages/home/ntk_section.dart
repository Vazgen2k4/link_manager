import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/ntk_api.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

class NtkSection extends StatefulWidget {
  const NtkSection({super.key});

  @override
  State<NtkSection> createState() => _NtkSectionState();
}

class _NtkSectionState extends State<NtkSection> {
  @override
  Widget build(BuildContext context) {
    return Section(
      title: S.of(context).ntk_title,
      child: FutureBuilder<int?>(
        future: NTKApi.getPeopleCount(),
        builder: (context, snapshot) {
          final peopleCount = snapshot.data;
          final isLoading = snapshot.connectionState == ConnectionState.waiting;

          return NTKPeopleTile(
            peopleCount: peopleCount,
            isLoading: isLoading,
            onRefresh: () async => setState(() {}),
          );
        },
      ),
    );
  }
}

class NTKPeopleTile extends StatelessWidget {
  final int? peopleCount;
  final Future<void> Function() onRefresh;
  final bool isLoading;

  const NTKPeopleTile({
    super.key,
    required this.peopleCount,
    required this.onRefresh,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.main.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.main,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).ntk_people,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          AnimatedFlipCounter(
            value: peopleCount!,
            duration: const Duration(milliseconds: 800),
            textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
          IconButton(
            icon: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            onPressed: isLoading ? null : onRefresh,
          )
        ],
      ),
    );
  }
}
