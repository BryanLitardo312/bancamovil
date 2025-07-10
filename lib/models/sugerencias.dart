class Sugerencias {
  
  final String BOD;
  final String EESS;
  final String mensaje;
  
  


  Sugerencias({
    
    required this.BOD,
    required this.EESS,
    required this.mensaje,
    
    
  });
  factory Sugerencias.fromMap(Map<String, dynamic> map) {
    return Sugerencias(
      
      BOD: map['BOD'] as String,
      EESS: map['EESS'] as String,
      mensaje: map['mensaje'] as String,
      
    );
  }
  Map <String, dynamic> toMap() {
    return {
      'BOD': BOD,
      'EESS': EESS,
      'mensaje': mensaje,
      
      
    };
  }
}