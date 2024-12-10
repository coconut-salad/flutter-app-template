import "dart:convert";

import "package:http/http.dart";
import "../utils/logger.dart";
import "auth_service.dart";
import "base_client.dart" as bc;
import "../models/models.dart";

class ApiClient implements bc.BaseClient {
  final AuthService _authService = AuthService();

  final String _baseUrl = "https://www.yourwebsite.com/api";

  /// Helper method to construct full URLs
  Future<Uri> _buildUrl(String endpoint) async {
    return Uri.parse("$_baseUrl$endpoint");
  }

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

  // Endpoint should include slashes, e.g. /api/v1/users
  Future<Response> authGet(String endpoint,
      {Map<String, String>? headers}) async {
    String? token = await _authService.getCookies();
    String? apiKey = await _authService.getApiKey();

    final url = await _buildUrl(endpoint);

    AppLogger().trace("GET $url");

    return await get(
      url,
      headers: {
        "Cookie": token ?? "",
        "Access-Token": apiKey ?? "",
        ...?headers,
      },
    );
  }

  Future<Response> authPost(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    String? token = await _authService.getCookies();
    String? apiKey = await _authService.getApiKey();

    final url = await _buildUrl(endpoint);

    AppLogger().trace("POST $url");

    return await post(
      url,
      headers: {
        "Cookie": token ?? "",
        "Access-Token": apiKey ?? "",
        ...?headers,
      },
      body: jsonEncode(body),
    );
  }

  Future<Response> authPatch(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    String? token = await _authService.getCookies();
    String? apiKey = await _authService.getApiKey();

    final url = await _buildUrl(endpoint);

    return await patch(
      url,
      headers: {
        "Cookie": token ?? "",
        "Access-Token": apiKey ?? "",
        ...?headers,
      },
      body: jsonEncode(body),
    );
  }

  Future<Response> authDelete(String endpoint,
      {Map<String, String>? headers}) async {
    String? token = await _authService.getCookies();
    String? apiKey = await _authService.getApiKey();

    final url = await _buildUrl(endpoint);

    return await delete(url, headers: {
      "Cookie": token ?? "",
      "Access-Token": apiKey ?? "",
      ...?headers,
    });
  }

  @override
  Future<Result> login(String email, String password) async {
    Response response = await authPost("/api/session", {
      "email": email.trim(),
      "password": password,
    });

    Status status = getStatusFromResponse(response);
    if (status != Status.OK) {
      return Result(status: status, message: response.body);
    }

    String cookies = response.headers["set-cookie"] ?? "";

    Response getSessionResponse = await get(
      await _buildUrl("/api/session"),
      headers: {
        "Cookie": cookies,
      },
    );
    AppLogger().trace("GET /api/session response: ${getSessionResponse.body}");
    Status getSessionStatus = getStatusFromResponse(getSessionResponse);
    if (getSessionStatus != Status.OK) {
      return Result(status: getSessionStatus, message: getSessionResponse.body);
    }

    final int userId = int.parse(getJson(getSessionResponse)["user"]);
    Response getUserResponse = await get(
      await _buildUrl("/api/users/$userId"),
      headers: {
        "Cookie": cookies,
      },
    );
    AppLogger().trace("/api/users/$userId response: ${getUserResponse.body}");
    Status getUserStatus = getStatusFromResponse(getUserResponse);
    if (getUserStatus != Status.OK) {
      return Result(status: getUserStatus, message: getUserResponse.body);
    }

    final bool isAdmin = getJson(getUserResponse)["admin"];
    AppLogger().trace("Is admin: $isAdmin");
    if (!isAdmin) {
      return Result(status: Status.FORBIDDEN, message: "User is not an admin");
    }

    // Set session
    await _authService.setCookies(cookies);

    return Result(status: status, message: response.body);
  }

  @override
  Future<Result<List<Badge>>> getBadges() async {
    Response response = await authGet("/api/badges");

    Status status = getStatusFromResponse(response);
    if (status == Status.OK) {
      return Result(
        status: status,
        data: (getJson(response) as List)
            .map((badge) => Badge.fromJson(badge))
            .toList()
            .cast<Badge>(),
      );
    }

    AppLogger()
        .error("/api/badges failed. Status: $status, body: ${response.body}");

    return Result(status: status, message: response.body);
  }

  @override
  Future<Result<String>> createBadge(String uid, int? userId) async {
    Response response = await authPost("/api/badges", {
      "uid": uid,
      "userId": userId,
    });

    Status status = getStatusFromResponse(response);
    if (status == Status.OK) {
      return Result(status: status, data: response.body);
    }

    AppLogger()
        .error("/api/badges failed. Status: $status, body: ${response.body}");

    return Result(status: status, message: response.body);
  }

  @override
  Future<Result<String>> updateBadge(int badgeId, dynamic params) async {
    Response response = await authPatch("/api/badges/$badgeId", params);

    Status status = getStatusFromResponse(response);
    if (status == Status.OK) {
      return Result(status: status, data: response.body);
    }

    AppLogger().error(
        "/api/badges/$badgeId failed. Status: $status, body: ${response.body}");

    return Result(status: status, message: response.body);
  }

  @override
  Future<Result<String>> deleteBadge(int badgeId) async {
    Response response = await authDelete("/api/badges/$badgeId");

    Status status = getStatusFromResponse(response);
    if (status == Status.OK) {
      return Result(status: status, data: response.body);
    }

    AppLogger().error(
        "/api/badges/$badgeId failed. Status: $status, body: ${response.body}");

    return Result(status: status, message: response.body);
  }
}
