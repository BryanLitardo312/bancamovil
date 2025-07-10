
class BancoNovedades {
  
  final int No;
  final String FECHA;
  final String REF;
  final String LUGAR;
  final String DETALLE;
  final String SECUENCIAL;
  final String SIGNO;
  final double VALOR;
  final String DESCRIPCION;
  final String EESS;
  final String BODEGA;


  BancoNovedades({
    
    required this.No,
    required this.FECHA,
    required this.REF,
    required this.LUGAR,
    required this.DETALLE,
    required this.SECUENCIAL,
    required this.SIGNO,
    required this.VALOR,
    required this.DESCRIPCION,
    required this.EESS,
    required this.BODEGA,
  });
  factory BancoNovedades.fromMap(Map<String, dynamic> map) {
    return BancoNovedades(
      
      No: map['No'] as int,
      FECHA: map['FECHA'] as String,
      REF: map['REF'] as String,
      LUGAR: map['LUGAR'] as String,
      DETALLE: map['DETALLE'] as String,
      SECUENCIAL: map['SECUENCIAL'] as String,
      SIGNO: map['SIGNO'] as String,
      VALOR: map['VALOR'] as double,
      DESCRIPCION: map['DESCRIPCION'] as String,
      EESS: map['EESS'] as String,
      BODEGA: map['BODEGA'] as String,
    );
  }
  Map <String, dynamic> toMap() {
    return {
      
      'No': No,
      'FECHA': FECHA,
      'REF': REF,
      'LUGAR': LUGAR,
      'DETALLE': DETALLE,
      'SECUENCIAL': SECUENCIAL,
      'SIGNO': SIGNO,
      'VALOR': VALOR,
      'DESCRIPCION': DESCRIPCION,
      'EESS': EESS,
      'BODEGA': BODEGA,
    };
  }
}