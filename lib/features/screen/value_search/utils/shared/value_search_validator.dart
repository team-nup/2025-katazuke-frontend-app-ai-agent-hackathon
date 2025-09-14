class ValueSearchValidator {
  static String? validateTitle(String title) {
    if (title.trim().isEmpty) {
      return 'タイトルは必須です';
    }
    
    if (title.trim().length > 100) {
      return 'タイトルは100文字以内で入力してください';
    }
    
    return null;
  }

  static String? validateDetail(String? detail) {
    if (detail != null && detail.length > 1000) {
      return '詳細は1000文字以内で入力してください';
    }
    
    return null;
  }

  static String? validateImagePaths(List<String> imagePaths) {
    if (imagePaths.isEmpty) {
      return '写真は最低1枚必要です';
    }
    
    if (imagePaths.length > 10) {
      return '写真は最大10枚まで追加できます';
    }
    
    return null;
  }

  static String? validateDetectedProductName(String detectedProductName) {
    if (detectedProductName.trim().isEmpty) {
      return '商品名の検出に失敗しました';
    }
    
    return null;
  }

  static String? validateAll({
    String? productNameHint,
    required List<String> imagePaths,
    required String detectedProductName,
  }) {
    return validateDetail(productNameHint) ??
        validateImagePaths(imagePaths) ??
        validateDetectedProductName(detectedProductName);
  }
}