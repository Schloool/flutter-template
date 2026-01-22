import 'package:flutter_template/shared/result.dart';
import 'package:get_storage/get_storage.dart';

import 'logger.dart';

/// Base class for repositories that use [GetStorage] as local persistence.
abstract class LocalRepository {
  const LocalRepository(this.storage);

  final GetStorage storage;

  /// Helper method to read a value safely and wrap it in a [Result].
  Result<T> readValue<T>(String key, {String? errorMessage}) {
    try {
      final value = storage.read<T>(key);
      if (value == null) {
        return Result.failure(errorMessage ?? 'No value found for "$key"');
      }

      return Result.success(value);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to read value for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to read value for "$key": $e');
    }
  }

  Result<List<T>> readValueAsList<T>(String key, {String? errorMessage}) {
    try {
      final value = storage.read<List>(key);
      if (value == null) {
        return Result.failure(errorMessage ?? 'No value found for "$key"');
      }

      final castedList = value.cast<T>();
      return Result.success(castedList);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to read value for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to read value for "$key": $e');
    }
  }

  /// Helper method to write a value and wrap it in a [Result].
  Future<Result> writeValue(String key, dynamic value) async {
    try {
      await storage.write(key, value);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to write value for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to write value for "$key": $e');
    }
    return const Result.success(null);
  }

  Result<T> readEnum<T extends Enum>(
    String key,
    List<T> values, {
    String? errorMessage,
  }) {
    try {
      if (values.isEmpty) {
        return Result.failure('Enum values list for "$key" is empty');
      }

      final stored = storage.read<String>(key);
      if (stored == null) {
        return Result.failure(errorMessage ?? 'No value found for "$key"');
      }

      final match = values.firstWhere((e) => e.name == stored);
      return Result.success(match);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to read enum for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to read enum for "$key": $e');
    }
  }

  /// Writes an enum value using its [Enum.name].
  Future<Result> writeEnum(String key, Enum value) async {
    await storage.write(key, value.name);
    return const Result.success(null);
  }

  Future<Result> removeValue(String key) async {
    try {
      await storage.remove(key);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to remove value for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to remove value for "$key": $e');
    }
    return const Result.success(null);
  }

  Result<List<T>> readEnumList<T extends Enum>(
    String key,
    List<T> values, {
    String? errorMessage,
  }) {
    try {
      if (values.isEmpty) {
        return Result.failure('Enum values list for "$key" is empty');
      }

      final storedList = storage.read<List>(key);
      if (storedList == null) {
        return Result.failure(errorMessage ?? 'No list found for "$key"');
      }

      final names = storedList.cast<String>();
      final enumList =
          names.map((name) {
            return values.firstWhere(
              (v) => v.name == name,
              orElse:
                  () =>
                      throw StateError(
                        'Invalid enum name "$name" for key "$key"',
                      ),
            );
          }).toList();

      return Result.success(enumList);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to read enum list for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to read enum list for "$key": $e');
    }
  }

  Future<Result> writeEnumList(String key, List<Enum> values) async {
    try {
      await storage.write(key, values.map((e) => e.name).toList());
      return const Result.success(null);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to write enum list for "$key"',
        error: e,
        stackTrace: stackTrace,
      );
      return Result.failure('Failed to write enum list for "$key": $e');
    }
  }
}
