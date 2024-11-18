class Projects {
  String project_name;

  Projects({required this.project_name});

  Map<String, dynamic> toJson() {
    return {
      "project_name": project_name,
    };
  }
}
