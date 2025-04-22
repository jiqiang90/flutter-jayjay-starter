import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jayjay_starter/models/business.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/services/premium/premium_service.dart';
import 'package:jayjay_starter/services/database/database_helper.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class BusinessService {
  static final BusinessService _instance = BusinessService._internal();
  factory BusinessService() => _instance;
  BusinessService._internal();

  late final Database _database;
  final int _freeLimit = 3;
  late AppLocalizations l10n;

  Future<void> initialize() async {
    try {
      _database = await DatabaseHelper().database;
      await _createTables();
      debugPrint('BusinessService initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize BusinessService: $e');
      rethrow;
    }
  }

  void setL10n(AppLocalizations l10n) {
    this.l10n = l10n;
  }

  Future<void> _createTables() async {
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS businesses (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    await _database.execute('''
      CREATE TABLE IF NOT EXISTS user_operations (
        userId TEXT PRIMARY KEY,
        count INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // 获取用户的所有业务
  Future<List<Business>> getUserBusinesses(String userId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'businesses',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Business(
        id: maps[i]['id'] as String,
        name: maps[i]['name'] as String,
        description: maps[i]['description'] as String,
        createdAt: DateTime.parse(maps[i]['createdAt'] as String),
        updatedAt: DateTime.parse(maps[i]['updatedAt'] as String),
        userId: maps[i]['userId'] as String,
      );
    });
  }

  // 创建新业务
  Future<Business?> createBusiness({
    required String name,
    required String description,
    required String userId,
  }) async {
    try {
      final premiumService = ServiceFactory.premiumService;
      if (premiumService == null) return null;

      if (!premiumService.isPremium) {
        final userBusinesses = await getUserBusinesses(userId);
        if (userBusinesses.length >= _freeLimit) {
          throw Exception(l10n.errorBusinessLimitReached);
        }
      }

      // 检查用户操作次数
      final operationCount = await _getUserOperationCount(userId);
      if (!premiumService.isPremium && operationCount >= 10) {
        throw Exception(l10n.errorOperationLimitReached);
      }

      // 更新操作次数
      await _updateUserOperationCount(userId, operationCount + 1);

      final business = Business(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: userId,
      );

      await _database.insert(
        'businesses',
        business.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return business;
    } catch (e) {
      debugPrint('创建业务失败: $e');
      rethrow;
    }
  }

  // 更新业务
  Future<Business?> updateBusiness(Business business) async {
    try {
      final premiumService = ServiceFactory.premiumService;
      if (premiumService == null) return null;

      final operationCount = await _getUserOperationCount(business.userId);
      if (!premiumService.isPremium && operationCount >= 10) {
        throw Exception(l10n.errorOperationLimitReached);
      }

      await _updateUserOperationCount(business.userId, operationCount + 1);

      final updatedBusiness = Business(
        id: business.id,
        name: business.name,
        description: business.description,
        createdAt: business.createdAt,
        updatedAt: DateTime.now(),
        userId: business.userId,
      );

      await _database.update(
        'businesses',
        updatedBusiness.toJson(),
        where: 'id = ?',
        whereArgs: [business.id],
      );

      return updatedBusiness;
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  // 删除业务
  Future<bool> deleteBusiness(String businessId, String userId) async {
    try {
      final premiumService = ServiceFactory.premiumService;
      if (premiumService == null) return false;

      final operationCount = await _getUserOperationCount(userId);
      if (!premiumService.isPremium && operationCount >= 10) {
        throw Exception(l10n.errorOperationLimitReached);
      }

      await _updateUserOperationCount(userId, operationCount + 1);

      final count = await _database.delete(
        'businesses',
        where: 'id = ? AND userId = ?',
        whereArgs: [businessId, userId],
      );

      return count > 0;
    } catch (e) {
      debugPrint('删除业务失败: $e');
      rethrow;
    }
  }

  // 获取用户操作次数
  Future<int> _getUserOperationCount(String userId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'user_operations',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isEmpty) {
      return 0;
    }

    return maps[0]['count'] as int;
  }

  // 更新用户操作次数
  Future<void> _updateUserOperationCount(String userId, int count) async {
    await _database.insert(
      'user_operations',
      {'userId': userId, 'count': count},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 获取用户剩余操作次数
  Future<int> getRemainingOperations(String userId) async {
    final premiumService = ServiceFactory.premiumService;
    if (premiumService == null) return 0;

    if (premiumService.isPremium) {
      return -1;
    }

    final usedOperations = await _getUserOperationCount(userId);
    return 10 - usedOperations;
  }

  // 获取用户剩余可创建业务数量
  Future<int> getRemainingBusinesses(String userId) async {
    final premiumService = ServiceFactory.premiumService;
    if (premiumService == null) return 0;

    if (premiumService.isPremium) {
      return -1;
    }

    final userBusinesses = await getUserBusinesses(userId);
    return _freeLimit - userBusinesses.length;
  }

  // 清除所有数据（用于测试）
  Future<void> clearAllData() async {
    await _database.delete('businesses');
    await _database.delete('user_operations');
  }

  // 关闭数据库连接
  Future<void> close() async {
    await _database.close();
  }
} 