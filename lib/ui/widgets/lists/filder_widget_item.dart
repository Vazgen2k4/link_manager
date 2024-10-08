import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/lists/links_list_widget.dart';
import 'package:flutter/material.dart';

class FolderItemWidget extends StatelessWidget {
  const FolderItemWidget({
    super.key,
    required this.folder,
    required this.index,
    this.minHeight = 56,
    this.maxHeight = 120,
  });

  final Folder folder;
  final int index;
  final double minHeight;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromHeight(54)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.main.withOpacity(.3),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: const Color.fromARGB(255, 104, 58, 183),
                    width: 3,
                  ),
                ),
              ),
              child: Icon(Icons.link),
            ),
          ),
          SizedBox(width: 6),
          FolderItemContent(
            folder: folder,
            index: index,
            minHeight: minHeight,
            maxHeight: maxHeight,
          ),
        ],
      ),
    );
  }
}

class FolderItemContent extends StatefulWidget {
  const FolderItemContent({
    super.key,
    required this.folder,
    required this.index,
    this.minHeight = 56,
    this.maxHeight = 120,
  });

  final Folder folder;
  final int index;
  final double minHeight;
  final double maxHeight;

  @override
  State<FolderItemContent> createState() => _FolderItemContentState();
}

class _FolderItemContentState extends State<FolderItemContent> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final height = isOpen ? widget.maxHeight : widget.minHeight;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: AnimatedContainer(
          padding: EdgeInsets.all(6),
          clipBehavior: Clip.antiAlias,
          height: height,
          duration: const Duration(
            milliseconds: 100,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(37, 104, 58, 183),
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(10),
            ),
            border: Border.all(
              color: const Color.fromARGB(255, 104, 58, 183),
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              LinksListWidget(
                folder: widget.folder,
                index: widget.index,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
