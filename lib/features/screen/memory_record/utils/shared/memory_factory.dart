import 'package:uuid/uuid.dart';
import '../../../../../core/models/DB/memory.dart';
import '../../../../../core/models/DB/memory_status.dart';

class MemoryFactory {
  static Memory createFromForm({
    required String title,
    String? detail,
    int? startAge,
    int? endAge,
    List<String>? imagePaths,
    required ItemKeepStatus status,
  }) {
    final now = DateTime.now();
    return Memory(
      id: const Uuid().v4(),
      title: title.trim(),
      detail: detail?.isEmpty == true ? null : detail?.trim(),
      startAge: startAge,
      endAge: endAge,
      imagePaths: imagePaths?.isEmpty == true ? null : imagePaths,
      status: status,
      disposedAt: status == ItemKeepStatus.disposed ? now : null,
      insertedAt: now,
      updatedAt: now,
    );
  }
}
