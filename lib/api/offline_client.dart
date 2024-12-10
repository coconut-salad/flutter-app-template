import "../models/models.dart";
import "base_client.dart";

class OfflineClient implements BaseClient {
  @override
  Future<Result<String>> createBadge(String uid, int? userId) {
    // TODO: implement createBadge
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> deleteBadge(int badgeId) {
    // TODO: implement deleteBadge
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Badge>>> getBadges() {
    // TODO: implement getBadges
    throw UnimplementedError();
  }

  @override
  Future<Result> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> updateBadge(int badgeId, params) {
    // TODO: implement updateBadge
    throw UnimplementedError();
  }
}
