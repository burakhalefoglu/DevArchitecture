class LookUp {
  dynamic id;
  String label;

  LookUp({required this.id, required this.label});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
    };
  }

  @override
  factory LookUp.fromMap(Map<String, dynamic> map) {
    return LookUp(
      id: map['id'],
      label: map['label'],
    );
  }
}
