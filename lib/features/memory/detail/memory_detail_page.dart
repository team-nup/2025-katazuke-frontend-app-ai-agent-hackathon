import 'package:flutter/material.dart';
import '../../../core/models/shared/memory.dart';
import '../../record/edit/record_edit_page.dart';
import 'components/memory_info.dart';
import 'components/memory_images.dart';

class MemoryDetailPage extends StatefulWidget {
  final Memory memory;

  const MemoryDetailPage({
    super.key,
    required this.memory,
  });

  @override
  State<MemoryDetailPage> createState() => _MemoryDetailPageState();
}

class _MemoryDetailPageState extends State<MemoryDetailPage> {
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
        builder: (context) => RecordEditPage(memory: _currentMemory),
      ),
    );

    if (updatedMemory != null) {
      setState(() {
        _currentMemory = updatedMemory;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('思い出が更新されました')),
      );
      // 詳細ページから一覧ページに戻る時にも更新されたことを伝える
      _hasBeenUpdated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 詳細ページから戻る時に更新フラグを返す
        Navigator.of(context).pop(_hasBeenUpdated);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('思い出詳細'),
          backgroundColor: Colors.teal.shade50,
          actions: [
            IconButton(
              onPressed: _navigateToEdit,
              icon: const Icon(Icons.edit),
              tooltip: '編集',
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemoryInfo(memory: _currentMemory),
            if (_currentMemory.imagePaths != null &&
                _currentMemory.imagePaths!.isNotEmpty) ...[
              const SizedBox(height: 16),
              MemoryImages(imagePaths: _currentMemory.imagePaths!),
            ],
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToEdit,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
