import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/lists/filder_widget_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoldersWidgetList extends StatelessWidget {
  const FoldersWidgetList({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
      stream: FirebaseApi.users.doc(userId).snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();

        if (data == null) {
          return const Center(child: LinearProgressIndicator());
        }
        final user = AppUser.fromJson(data);
        if (user.folders.isEmpty) {
          return  Center(
            child: Text(S.of(context).no_folders),
          );
        }

        return ReorderedList(key: UniqueKey(), user: user);
      },
    );
  }
}

class ReorderedList extends StatefulWidget {
  const ReorderedList({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  State<ReorderedList> createState() => _ReorderedListState();
}

class _ReorderedListState extends State<ReorderedList> {
  bool _haveReorder = false;
  List<Folder> _oldList = [];
  List<Folder> _curentList = [];

  @override
  void initState() {
    _oldList = [...widget.user.folders];
    _curentList = [...widget.user.folders];

    super.initState();
  }

  void _reorder(oldIndex, newIndex) async {
    if (_curentList.length < 2) {
      return;
    }

    if (oldIndex < newIndex) {
      newIndex--;
    }

    final old = _curentList.removeAt(oldIndex);
    _curentList.insert(newIndex, old);
  }

  Widget _reodrerOermisionButton({
    required VoidCallback onPressed,
    required Color mainColor,
    required IconData icon,
  }) {
    return AnimatedOpacity(
      opacity: _haveReorder ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        style: ButtonStyle(
          backgroundColor: getProperty(mainColor.withOpacity(.3)),
          shape: getProperty(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: mainColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.of(context).links,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const Spacer(),
            _reodrerOermisionButton(
              onPressed: _confirmReorder,
              mainColor: AppColors.correct,
              icon: Icons.check,
            ),
            _reodrerOermisionButton(
              mainColor: AppColors.error,
              icon: Icons.close,
              onPressed: _stopReorder,
            ),
          ],
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: _curentList.length,
            onReorder: _reorder,
            onReorderStart: (_) {
              setState(() {
                _haveReorder = true;
              });
            },
            itemBuilder: (context, index) {
              final folder = _curentList[index];

              return FolderItemWidget(
                key: ValueKey(index),
                folder: folder,
                index: index,
                padding: 6,
              );
            },
          ),
        ),
      ],
    );
  }

  void _stopReorder() {
    if (!_haveReorder) {
      return;
    }

    setState(() {
      _curentList = [..._oldList];
      _haveReorder = false;
    });
  }

  void _confirmReorder() async {
    if (!_haveReorder) {
      return;
    }

    await FirebaseApi.updateUserById(
      user: widget.user.copyWith(folders: _curentList),
      id: FirebaseAuth.instance.currentUser?.uid,
    );

  }
}
