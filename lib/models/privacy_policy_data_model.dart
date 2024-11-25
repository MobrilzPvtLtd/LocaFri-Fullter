class PrivacyPolicyDataModel {
  String? title;
  String? companyName;
  String? appUrl;
  String? appEmail;
  Content? content;

  PrivacyPolicyDataModel(
      {this.title, this.companyName, this.appUrl, this.appEmail, this.content});

  PrivacyPolicyDataModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["company_name"] is String) {
      companyName = json["company_name"];
    }
    if (json["app_url"] is String) {
      appUrl = json["app_url"];
    }
    if (json["app_email"] is String) {
      appEmail = json["app_email"];
    }
    if (json["content"] is Map) {
      content =
          json["content"] == null ? null : Content.fromJson(json["content"]);
    }
  }

  static List<PrivacyPolicyDataModel> fromList(
      List<Map<String, dynamic>> list) {
    return list.map(PrivacyPolicyDataModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["company_name"] = companyName;
    _data["app_url"] = appUrl;
    _data["app_email"] = appEmail;
    if (content != null) {
      _data["content"] = content?.toJson();
    }
    return _data;
  }
}

class Content {
  String? introduction;
  LogFiles? logFiles;

  Content({this.introduction, this.logFiles});

  Content.fromJson(Map<String, dynamic> json) {
    if (json["introduction"] is String) {
      introduction = json["introduction"];
    }
    if (json["log_files"] is Map) {
      logFiles = json["log_files"] == null
          ? null
          : LogFiles.fromJson(json["log_files"]);
    }
  }

  static List<Content> fromList(List<Map<String, dynamic>> list) {
    return list.map(Content.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["introduction"] = introduction;
    if (logFiles != null) {
      _data["log_files"] = logFiles?.toJson();
    }
    return _data;
  }
}

class LogFiles {
  String? title;
  String? description;

  LogFiles({this.title, this.description});

  LogFiles.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
  }

  static List<LogFiles> fromList(List<Map<String, dynamic>> list) {
    return list.map(LogFiles.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["description"] = description;
    return _data;
  }
}
