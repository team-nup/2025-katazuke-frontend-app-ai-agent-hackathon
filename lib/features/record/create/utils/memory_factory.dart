import 'package:uuid/uuid.dart';
import '../../../../core/models/shared/memory.dart';
import '../../../../core/models/shared/memory_status.dart';

class MemoryFactory {
  static Memory createFromForm({
    required String title,
    String? detail,
    int? startAge,
    int? endAge,
    List<String>? imagePaths,
    required MemoryStatus status,
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
      disposedAt: status == MemoryStatus.disposed ? now : null,
      insertedAt: now,
      updatedAt: now,
    );
  }
}
