class BancoDevoluciones {
  
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
  final String? URL_PUBLICA;
  final String? COMENTARIOS;
  final String? USUARIO;
  final String? STATUS;
  final String? COMENTARIO_RECHAZO;


  BancoDevoluciones({
    
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
    this.URL_PUBLICA,
    this.COMENTARIOS,
    this.USUARIO,
    this.STATUS,
    this.COMENTARIO_RECHAZO,
  });
  factory BancoDevoluciones.fromMap(Map<String, dynamic> map) {
    return BancoDevoluciones(
      
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
      URL_PUBLICA: map['URL_PUBLICA'] as String,
      COMENTARIOS: map['COMENTARIOS'] as String,
      USUARIO: map['USUARIO'] as String,
      STATUS: map['STATUS'] as String,
      COMENTARIO_RECHAZO: map['COMENTARIO_RECHAZO'] as String,
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
      'URL_PUBLICA': URL_PUBLICA,
      'COMENTARIOS': COMENTARIOS,
      'USUARIO': USUARIO,
      'STATUS': STATUS,
      'COMENTARIO_RECHAZO': COMENTARIO_RECHAZO,
    };
  }
}