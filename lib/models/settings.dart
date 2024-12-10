class Settings {
  final bool showBadges;

  const Settings({
    this.showBadges = true,
  });

  Settings copyWith({
    bool? showBadges,
  }) {
    return Settings(
      showBadges: showBadges ?? this.showBadges,
    );
  }

  Map<String, dynamic> toJson() => {
        "showBadges": showBadges,
      };

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        showBadges: json["showBadges"] ?? true,
      );
}
