import 'package:flutter/material.dart';

class ToastHelper {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('エラー: $message')),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showCreateSuccess(BuildContext context) {
    showSuccess(context, '保存完了');
  }

  static void showUpdateSuccess(BuildContext context) {
    showSuccess(context, '更新完了');
  }
}