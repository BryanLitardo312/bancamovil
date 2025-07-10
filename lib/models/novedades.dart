/*class Novedades {
  //final int? id;
  final int No;
  final String FECHA;
  final String REF;
  final String LUGAR;
  final String DETALLE;
  final String SECUENCIAL;
  final String SIGNO;
  final int VALOR;
  final String BODEGA;
  final String ESTACION;
  final String CRZBANCO;
  final int CODIGO;
  final String UNION;
  final String NOMBRE;


  Novedades({
    //required this.id,
    required this.No,
    required this.FECHA,
    required this.REF,
    required this.LUGAR,
    required this.DETALLE,
    required this.SECUENCIAL,
    required this.SIGNO,
    required this.VALOR,
    required this.BODEGA,
    required this.ESTACION,
    required this.CRZBANCO,
    required this.CODIGO,
    required this.UNION,
    required this.NOMBRE,
  });

  factory Novedades.fromMap(Map<String, dynamic> map) {
    return Novedades(
      //id: map['id'] as int,
      No: map['No'] as int,
      FECHA: map['FECHA'] as String,
      REF: map['REF'] as String,
      LUGAR: map['LUGAR'] as String,
      DETALLE: map['DETALLE'] as String,
      SECUENCIAL: map['SECUENCIAL'] as String,
      SIGNO: map['SIGNO'] as String,
      VALOR: map['VALOR'] as int,
      BODEGA: map['BODEGA'] as String,
      ESTACION: map['ESTACION'] as String,
      CRZBANCO: map['CRZBANCO'] as String,
      CODIGO: map['CODIGO'] as int,
      UNION: map['UNION'] as String,
      NOMBRE: map['NOMBRE'] as String,
    );
  }

  Map <String, dynamic> toMap() {
    return {
      //'id': id,
      'No': No,
      'FECHA': FECHA,
      'REF': REF,
      'LUGAR': LUGAR,
      'DETALLE': DETALLE,
      'SECUENCIAL': SECUENCIAL,
      'SIGNO': SIGNO,
      'VALOR': VALOR,
      'BODEGA': BODEGA,
      'ESTACION': ESTACION,
      'CRZBANCO': CRZBANCO,
      'CODIGO': CODIGO,
      'UNION': UNION,
      'NOMBRE': NOMBRE,
    };
  }

}*/