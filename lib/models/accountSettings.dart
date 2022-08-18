class AccountSettings {
  bool areNotificationsAllowed;

  AccountSettings({
    required this.areNotificationsAllowed,
  });

  Map<String, dynamic> toJson() {

    return {
      'allow_notifications': this.areNotificationsAllowed,
    };
  }

  factory AccountSettings.fromJson(Map<String, dynamic> map) {
    return AccountSettings(
      areNotificationsAllowed: map['allow_notifications'] as bool,
    );
  }
}