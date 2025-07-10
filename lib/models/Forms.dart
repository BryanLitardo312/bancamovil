class Forms {
  
  final String estacion;
  final String process;
  final String detail;
  Forms({
    required this.estacion,
    required this.process,
    required this.detail,
  });
  factory Forms.fromMap(Map<String, dynamic> map) {
    return Forms(
      estacion: map['estacion'] as String,
      process: map['process'] as String,
      detail: map['detail'] as String,
    );
  }

  Map <String, dynamic> toMap() {
    return {
      'estacion': estacion,
      'process': process,
      'detail': detail,
    };
  }
}