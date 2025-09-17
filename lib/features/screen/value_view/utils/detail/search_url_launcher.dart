import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchUrlLauncher {
  static Future<void> launchSearchUrl(
    String productName,
    String platform,
    BuildContext context,
  ) async {
    String url;
    String encodedProductName = Uri.encodeComponent(productName);

    switch (platform) {
      case 'mercari':
        url = 'https://jp.mercari.com/search?keyword=$encodedProductName';
        break;
      case 'yahoo':
        url = 'https://auctions.yahoo.co.jp/search/search?auccat=&tab_ex=commerce&ei=utf-8&aq=-1&oq=&sc_i=&fr=auc_top&p=$encodedProductName';
        break;
      default:
        return;
    }

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('URLを開けませんでした')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('URLの起動エラー: $e')),
        );
      }
    }
  }
}