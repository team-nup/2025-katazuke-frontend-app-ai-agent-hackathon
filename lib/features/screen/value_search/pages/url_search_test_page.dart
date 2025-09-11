import 'package:flutter/material.dart';
import '../../../../services/api/google/custom_search_service.dart';

class UrlSearchTestPage extends StatefulWidget {
  const UrlSearchTestPage({super.key});

  @override
  State<UrlSearchTestPage> createState() => _UrlSearchTestPageState();
}

class _UrlSearchTestPageState extends State<UrlSearchTestPage> {
  final CustomSearchService _searchService = CustomSearchService();
  final TextEditingController _urlController = TextEditingController();
  List<SearchResult> _results = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _searchService.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _testSearch() async {
    if (_urlController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'URLを入力してください';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _results = [];
    });

    try {
      // テスト用のURL配列（通常はVision APIから取得）
      final testUrls = [_urlController.text.trim()];

      final results =
          await _searchService.getPageTitlesFromSimilarImages(testUrls);

      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'エラーが発生しました: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL検索テスト'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: '画像URL',
                hintText: 'https://example.com/image.jpg',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _testSearch,
              child: _isLoading
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('検索中...'),
                      ],
                    )
                  : const Text('検索実行'),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red.shade700),
                ),
              ),
            ],
            const SizedBox(height: 24),
            const Text(
              '検索結果:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _results.isEmpty
                  ? const Center(
                      child: Text('検索結果がここに表示されます'),
                    )
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final result = _results[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  result.url,
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                if (result.snippet.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    result.snippet,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                                if (result.sourceImageUrl != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    '元画像URL: ${result.sourceImageUrl}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
