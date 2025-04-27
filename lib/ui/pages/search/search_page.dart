import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';
import 'package:link_manager/ui/widgets/lists/folder_widget_item.dart';

class SearchFolderPage extends StatefulWidget {
  const SearchFolderPage({super.key});

  @override
  State createState() => _SearchFolderPageState();
}

class _SearchFolderPageState extends State<SearchFolderPage> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
      stream: FirebaseApi.users.doc(userId).snapshots(),
      builder: (context, snapshot) {
        final user = snapshot.data?.data();

        if (user == null) {
          return const Center(child: LinearProgressIndicator());
        }

        final appUser = AppUser.fromJson(user);
        if (appUser.folders.isEmpty) {
          return Center(
            child: Text('No folders found'),
          );
        }

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Search Folders',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchList(
              folders: appUser.folders,
            ),
          ),
        );
      },
    );
  }
}

class SearchList extends StatefulWidget {
  const SearchList({
    super.key,
    required this.folders,
  });
  final List<Folder> folders;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  TextEditingController searchController = TextEditingController();
  late List<Folder> filteredFolders;
  Set<String> selectedFolderIds = {};

  @override
  void initState() {
    super.initState();
    filteredFolders = widget.folders;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    setState(() {
      filteredFolders = widget.folders
          .where((folder) => folder.name != null && folder.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleSelection(String? folderId) {
    if (folderId == null) return;

    setState(() {
      if (selectedFolderIds.contains(folderId)) {
        selectedFolderIds.remove(folderId);
      } else {
        selectedFolderIds.add(folderId);
      }
    });
  }

  bool isSelected(String? folderId) {
    return folderId != null && selectedFolderIds.contains(folderId);
  }

  Future<void> deleteSelectedFolders(BuildContext context) async {
    final state = context.read<AuthBloc>().state;
    if (state is! AuthLoaded) return;
    final user = state.currentUser;
    if (user == null) return;

    final haveApprovement = await AppDialogs.getApprovement(
      context,
      "${S.of(context).remove_selected_folders} (${selectedFolderIds.length})?",
    );

    if (haveApprovement == null || !haveApprovement) {
      return;
    }

    user.folders.removeWhere((folder) => selectedFolderIds.contains(folder.name));

    await FirebaseApi.updateUserById(
      user: user,
      id: FirebaseAuth.instance.currentUser?.uid,
    );

    setState(() {
      selectedFolderIds.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedFolderIds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton.icon(
              onPressed: () => deleteSelectedFolders(context),
              icon: const Icon(Icons.delete),
              label: Text('Delete (${selectedFolderIds.length}) selected'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search folders...',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: onSearch,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredFolders.length,
            itemBuilder: (context, index) {
              final folder = filteredFolders[index];
              final selected = isSelected(folder.name);
              final child = FolderItemWidget(
                folder: folder,
                index: index,
                minHeight: 70,
              );

              final childWithSelect = GestureDetector(
                child: Row(
                  children: [
                    Expanded(child: child),
                    Checkbox(
                      value: selected,
                      onChanged: (_) => toggleSelection(folder.name),
                    ),
                  ],
                ),
                onTap: () => toggleSelection(folder.name),
              );

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selectedFolderIds.isEmpty
                    ? GestureDetector(
                        key: ValueKey('normal_${folder.name}'),
                        onLongPress: () => toggleSelection(folder.name),
                        child: child,
                      )
                    : Container(
                        key: ValueKey('selected_${folder.name}'),
                        child: childWithSelect,
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
