import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../../../../core/database/repositories/memory_repository.dart';
import '../../memory_record/containers/record_edit_container.dart';
import '../components/detail/delete_confirmation_dialog.dart';
import '../pages/memory_detail_page.dart';

class MemoryDetailContainer extends StatefulWidget {
  final Memory memory;

  const MemoryDetailContainer({
    super.key,
    required this.memory,
  });

  @override
  State<MemoryDetailContainer> createState() => _MemoryDetailContainerState();
}

class _MemoryDetailContainerState extends State<MemoryDetailContainer> {
  late Memory _currentMemory;
  bool _hasBeenUpdated = false;

  @override
  void initState() {
    super.initState();
    _currentMemory = widget.memory;
  }

  Future<void> _navigateToEdit() async {
    final updatedMemory = await Navigator.of(context).push<Memory>(
      MaterialPageRoute(
        builder: (context) => RecordEditContainer(memory: _currentMemory),
      ),
    );

    if (updatedMemory != null) {
      setState(() {
        _currentMemory = updatedMemory;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('思い出が更新されました')),
      );
      _hasBeenUpdated = true;
    }
  }

  Future<void> _showDeleteConfirmDialog() async {
    final result = await DeleteConfirmationDialog.show(context, _currentMemory);

    if (result == true) {
      await _deleteMemory();
    }
  }

  Future<void> _deleteMemory() async {
    try {
      await MemoryRepository.delete(_currentMemory.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('思い出を削除しました')),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除エラー: $e')),
        );
      }
    }
  }

  void _onPopInvoked(bool didPop, dynamic result) {
    if (!didPop) {
      Navigator.of(context).pop(_hasBeenUpdated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MemoryDetailPage(
      memory: _currentMemory,
      onEdit: _navigateToEdit,
      onDelete: _showDeleteConfirmDialog,
      onPopInvoked: _onPopInvoked,
    );
  }
}