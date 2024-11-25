class Projects {
  int? id;
  String project_name;

  Projects({required this.project_name, required this.id});

  Map<String, dynamic> toJson() {
    return {
      "project_name": project_name,
    };
  }

  factory Projects.fromJson(Map<String, dynamic> json){
    return Projects(
        id: json['id'] ?? 0,
        project_name: json['project_name'] ?? ""
    );
  }
}
