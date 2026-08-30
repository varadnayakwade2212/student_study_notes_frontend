class Doctor {
  final int id;
  final String name;
  final String specialization;
  final int experience;
  final double fee;
  final double rating;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.fee,
    required this.rating,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] is num
          ? (json['id'] as num).toInt()
          : int.tryParse('${json['id']}') ?? 0,

      name: json['name']?.toString() ?? '',

      specialization:
      json['specialization']?.toString() ?? '',

      experience: json['experience'] is num
          ? (json['experience'] as num).toInt()
          : int.tryParse('${json['experience']}') ?? 0,

      fee: json['fee'] is num
          ? (json['fee'] as num).toDouble()
          : double.tryParse('${json['fee']}') ?? 0.0,

      rating: json['rating'] is num
          ? (json['rating'] as num).toDouble()
          : double.tryParse('${json['rating']}') ?? 0.0,
    );
  }
}