import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/provider/tag_provider.dart';
import 'package:expense_app/models/Tag.dart';

class TagManagementScreen extends StatefulWidget {
  const TagManagementScreen({super.key});

  @override
  State<TagManagementScreen> createState() => _TagManagementScreenState();
}

class _TagManagementScreenState extends State<TagManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Tags")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddTagDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<TagProvider>(
        builder: (context, tagProvider, child) {
          final tags = tagProvider.tags;
          if (tags.isEmpty) {
            return Center(child: Text("No tags added yet"));
          }
          return ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final Tag tag = tags[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                child: ListTile(
                  title: Text(tag.name),
                  trailing: IconButton(
                    onPressed: () => _confirmDelete(context, tag.id),
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String tagId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete this tag?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TagProvider>(context, listen: false).removeTag(tagId);
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}


class AddTagDialog extends StatefulWidget {
  const AddTagDialog({super.key});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Tag"),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: "Tag Name",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final tagName = _nameController.text.trim();
            if (tagName.isNotEmpty) {
              _saveTag(context, tagName);
              Navigator.pop(context);
            }
          },
          child: Text("Add"),
        ),
      ],
    );
  }

  void _saveTag(BuildContext context, String name) {
    final tag = Tag(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    Provider.of<TagProvider>(context, listen: false).addTags(tag);
  }
}
