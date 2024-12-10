import "dart:convert";

import "package:http/http.dart";
import "../models/models.dart";
import "../utils/logger.dart";
import "base_client.dart" as bc;

class Client {
  final bc.BaseClient client;

  Client({required this.client});

  Status getStatusFromResponse(Response response) {
    if (response.statusCode == 200) {
      return Status.OK;
    } else if (response.statusCode == 403) {
      return Status.FORBIDDEN;
    } else {
      return Status.ERROR;
    }
  }

  dynamic getJson(Response response) {
    try {
      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      AppLogger().error("getJson failed. Exception: $e", error: e);
    }
  }

  Future<Result> login(String email, String password) =>
      client.login(email, password);

  Future<Result<List<Badge>>> getBadges() => client.getBadges();

  Future<Result<String>> createBadge(String badgeId, int? userId) =>
      client.createBadge(badgeId, userId);

  Future<Result<String>> updateBadge(int badgeId, dynamic params) =>
      client.updateBadge(badgeId, params);

  Future<Result<String>> deleteBadge(int badgeId) =>
      client.deleteBadge(badgeId);
}
