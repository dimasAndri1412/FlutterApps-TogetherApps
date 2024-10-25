class MemberStatuspaidleave {
  String status;
  bool selected;

  MemberStatuspaidleave({required this.status, this.selected = false});
  factory MemberStatuspaidleave.fromJson(Map<String, dynamic> json) {
    return MemberStatuspaidleave(
      status: json['status'] ?? '',
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'MemberStatuspaidleave{status: $status}';
  }
}
