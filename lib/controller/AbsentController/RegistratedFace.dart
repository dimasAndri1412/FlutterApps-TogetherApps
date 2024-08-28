// class RegistratedFace {
//   final bool success;
//   final List<double> embedding;
//   final String? message;

//   RegistratedFace({required this.success, required this.embedding, this.message});

//   factory RegistratedFace.fromJson(Map<String, dynamic> json) {
//     String embeddingString = json['embedding'].replaceAll('"', '');
//     List<double> embedding = embeddingString.split(',').map((e) => double.parse(e)).toList();
//     return RegistratedFace(
//       success: json['success'],
//       embedding: embedding,
//       message: json['message'],
//     );
//   }
// }
