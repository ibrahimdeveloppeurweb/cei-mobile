import 'package:cei_mobile/common_widgets/file_preview_card.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilePickerWidget extends StatefulWidget {
  /// The currently selected files
  final List<PlatformFile> selectedFiles;

  /// Called when files are added
  final Function(List<PlatformFile> files) onFilesSelected;

  /// Called when a file is removed
  final Function(PlatformFile file) onFileRemoved;

  /// Custom button text (optional)
  final String? buttonText;

  /// Info text displayed below the button (optional)
  final String? infoText;

  /// Allowed file extensions (default: pdf, doc, docx, jpg, jpeg, png)
  final List<String>? allowedExtensions;

  /// Maximum file size in MB (optional)
  final int? maxFileSize;

  /// Whether to allow multiple file selection (default: false)
  final bool allowMultiple;

  /// Whether to show the selected files list (default: true)
  final bool showFilesList;

  /// Custom title for the selected files list (optional)
  final String? filesListTitle;

  /// Callback when maximum files limit is reached (for single file selection)
  final Function()? onMaxFilesReached;

  const FilePickerWidget({
    Key? key,
    required this.selectedFiles,
    required this.onFilesSelected,
    required this.onFileRemoved,
    this.buttonText,
    this.infoText,
    this.allowedExtensions,
    this.maxFileSize,
    this.allowMultiple = false,
    this.showFilesList = true,
    this.filesListTitle,
    this.onMaxFilesReached,
  }) : super(key: key);

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  bool _isPickingFiles = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppButton(
          shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
          elevation: 0.0,
          color: Colors.grey[300],
          onTap: _pickFiles,
          child: _isPickingFiles
              ? const CircularProgressIndicator()
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.attach_file, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Text(
                widget.buttonText ?? 'Joindre des fichiers',
                style: boldTextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
        if (widget.infoText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.infoText!,
            style: AppTextStyles.caption,
          ),
        ],
        if (widget.showFilesList && widget.selectedFiles.isNotEmpty) ...[
          Text(
            widget.filesListTitle ?? 'Fichiers sélectionnés (${widget.selectedFiles.length})',
            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...widget.selectedFiles
              .map((file) => FilePreviewCard(
            file: file,
            onRemove: () => _removeFile(file),
          ))
              .toList(),
        ],
      ],
    );
  }

  Future<void> _pickFiles() async {
    try {
      // Check if we already have a file and are in single file mode
      if (!widget.allowMultiple && widget.selectedFiles.isNotEmpty) {
        // Notify that a file is already selected
        if (widget.onMaxFilesReached != null) {
          widget.onMaxFilesReached!();
        } else {
          toast('Vous ne pouvez sélectionner qu\'un seul fichier. Supprimez le fichier existant d\'abord.');
        }
        return;
      }

      setState(() => _isPickingFiles = true);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: widget.allowMultiple,
        type: FileType.custom,
        allowedExtensions: widget.allowedExtensions ?? ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        onFileLoading: (FilePickerStatus status) {
          // Optional callback for file loading status
        },
      );

      if (result != null) {
        // Filter by size if maxFileSize is specified
        List<PlatformFile> validFiles = result.files;
        if (widget.maxFileSize != null) {
          validFiles = result.files.where((file) {
            // Convert bytes to MB
            final sizeInMB = file.size / (1024 * 1024);
            return sizeInMB <= widget.maxFileSize!;
          }).toList();

          // Notify if some files were too large
          if (validFiles.length < result.files.length) {
            toast('${result.files.length - validFiles.length} fichier(s) ignoré(s) car trop volumineux');
          }
        }

        if (validFiles.isNotEmpty) {
          // For single file mode, replace existing file
          if (!widget.allowMultiple) {
            // We're replacing the old file with the new one
            widget.onFilesSelected([validFiles.first]);
            widget.selectedFiles.clear();
            widget.selectedFiles.addAll([validFiles.first]);
            toast('Fichier sélectionné');
          } else {
            widget.onFilesSelected(validFiles);
            widget.selectedFiles.clear();
            widget.selectedFiles.addAll(validFiles);
            toast('${validFiles.length} fichier(s) sélectionné(s)');
          }
          setState(() {

          });
        }
      }
    } catch (e) {
      toast('Erreur lors de la sélection des fichiers');
      debugPrint('File picking error: $e');
    } finally {
      setState(() => _isPickingFiles = false);
    }
  }

  void _removeFile(PlatformFile file) {
    widget.onFileRemoved(file);
    widget.selectedFiles.remove(file);
    setState(() {});
  }
}