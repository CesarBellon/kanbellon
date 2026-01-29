import 'dart:convert';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'full_screen_image_viewer.dart';

class CardDialog extends StatefulWidget {
  final String? title;
  final String? description;
  final String? existingImageBase64;
  final Function(String title, String description, String? imageBase64) onSave;

  const CardDialog({
    super.key,
    this.title,
    this.description,
    this.existingImageBase64,
    required this.onSave
  });

  @override
  State<CardDialog> createState() => _CardDialogState();
}

class _CardDialogState extends State<CardDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descController = TextEditingController(text: widget.description);
    _imageBase64 = widget.existingImageBase64;
  }

  Future<void> _pickImage() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png', 'jpeg'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) return;
    
    // Check size limit (e.g., 2MB) to prevent UI freeze
    final int size = await file.length();
    if (size > 2 * 1024 * 1024) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image is too large (max 2MB)'))
        );
      }
      return;
    }

    final bytes = await file.readAsBytes();
    if (mounted) {
        setState(() {
            _imageBase64 = base64Encode(bytes);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title == null ? 'New Card' : 'Edit Card'),
        content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(labelText: 'Title'),
                            autofocus: true,
                        ),
                        TextField(
                            controller: _descController,
                            decoration: const InputDecoration(labelText: 'Description'),
                            maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                         if (_imageBase64 != null)
                             Stack(
                                 children: [
                                     GestureDetector(
                                         onTap: () {
                                             Navigator.push(
                                                 context, 
                                                 MaterialPageRoute(builder: (_) => FullScreenImageViewer(imageBase64: _imageBase64!))
                                             );
                                         },
                                         child: Image.memory(
                                             base64Decode(_imageBase64!),
                                             height: 150,
                                             width: double.infinity,
                                             fit: BoxFit.cover
                                         ),
                                     ),
                                      Positioned(
                                         right: 4, 
                                         top: 4, 
                                         child: IconButton(
                                             color: Colors.red,
                                             icon: const Icon(Icons.delete),
                                             onPressed: () => setState(() => _imageBase64 = null),
                                         )
                                     )
                                 ],
                             )
                        else
                             OutlinedButton.icon(
                                 onPressed: _pickImage,
                                 icon: const Icon(Icons.image),
                                 label: const Text('Add Image')
                             ),
                         const SizedBox(height: 8),
                         const Text("Or Paste Image logic here (system specific implementations required)", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                ),
            ),
        ),
        actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')
            ),
            FilledButton(
                onPressed: () {
                    if (_titleController.text.isNotEmpty) {
                        widget.onSave(
                            _titleController.text,
                            _descController.text,
                            _imageBase64
                        );
                        Navigator.pop(context);
                    }
                },
                child: const Text('Save')
            )
        ],
    );
  }
}
