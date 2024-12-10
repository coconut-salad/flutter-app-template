import "../models/models.dart";

abstract class BaseClient {
  Future<Result> login(String email, String password);

  Future<Result<List<Badge>>> getBadges();

  Future<Result<String>> createBadge(String uid, int? userId);

  Future<Result<String>> updateBadge(int badgeId, dynamic params);

  Future<Result<String>> deleteBadge(int badgeId);
}
