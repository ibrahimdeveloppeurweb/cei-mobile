import 'dart:io';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:file_icon/file_icon.dart';

class FilePreviewCard extends StatelessWidget {
  final PlatformFile file;
  final VoidCallback? onRemove;

  const FilePreviewCard({
    super.key,
    required this.file,
     this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isImage = _isImageFile(file.name);
    final isPDF = file.name.toLowerCase().endsWith('.pdf');

    return Card(
      elevation: 0,
      color: AppColors.primary.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _openFile(file.path!),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isImage)
                    _buildImageThumbnail(file)

                  else
                    FileIcon(file.name, size: 48),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          file.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${(file.size / 1024).toStringAsFixed(2)} KB',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if(onRemove != null)  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: onRemove,
                  ),
                ],
              ),
              if (file.extension != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Chip(
                    label: Text(
                      file.extension!.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(PlatformFile file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(file.path!),
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 48,
          height: 48,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image),
        ),
      ),
    );
  }


  bool _isImageFile(String filename) {
    final ext = filename.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext);
  }

  Future<void> _openFile(String path) async {
    try {
      await OpenFilex.open(path);
    } catch (e) {
      debugPrint('Error opening file: $e');
    }
  }
}