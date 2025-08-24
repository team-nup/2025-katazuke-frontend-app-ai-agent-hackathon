import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildPageButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageButtons() {
    List<Widget> pageButtons = [];

    // 前のページボタン
    pageButtons.add(
      IconButton(
        onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        icon: const Icon(Icons.chevron_left),
      ),
    );

    // ページ番号表示の最適化
    if (totalPages <= 7) {
      // 7ページ以下なら全部表示
      for (int i = 1; i <= totalPages; i++) {
        pageButtons.add(_buildPageButton(i));
      }
    } else {
      // 8ページ以上の場合の省略表示
      if (currentPage <= 4) {
        // 最初の方にいる場合: 1,2,3,4,5,...,last
        for (int i = 1; i <= 5; i++) {
          pageButtons.add(_buildPageButton(i));
        }
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text('...'),
        ));
        pageButtons.add(_buildPageButton(totalPages));
      } else if (currentPage >= totalPages - 3) {
        // 最後の方にいる場合: 1,...,last-4,last-3,last-2,last-1,last
        pageButtons.add(_buildPageButton(1));
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text('...'),
        ));
        for (int i = totalPages - 4; i <= totalPages; i++) {
          pageButtons.add(_buildPageButton(i));
        }
      } else {
        // 真ん中にいる場合: 1,...,current-1,current,current+1,...,last
        pageButtons.add(_buildPageButton(1));
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text('...'),
        ));
        for (int i = currentPage - 1; i <= currentPage + 1; i++) {
          pageButtons.add(_buildPageButton(i));
        }
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text('...'),
        ));
        pageButtons.add(_buildPageButton(totalPages));
      }
    }

    // 次のページボタン
    pageButtons.add(
      IconButton(
        onPressed: currentPage < totalPages
            ? () => onPageChanged(currentPage + 1)
            : null,
        icon: const Icon(Icons.chevron_right),
      ),
    );

    return pageButtons;
  }

  Widget _buildPageButton(int pageNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: TextButton(
        onPressed: () => onPageChanged(pageNumber),
        style: TextButton.styleFrom(
          backgroundColor: pageNumber == currentPage ? Colors.teal.shade100 : null,
          minimumSize: const Size(40, 36),
        ),
        child: Text(
          '$pageNumber',
          style: TextStyle(
            fontWeight: pageNumber == currentPage ? FontWeight.bold : FontWeight.normal,
            color: pageNumber == currentPage ? Colors.teal.shade700 : null,
          ),
        ),
      ),
    );
  }
}