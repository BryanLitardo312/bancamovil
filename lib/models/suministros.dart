
class Suministros {
  final int requests;
  final String? bodega;
  final String? estacion;
  final String? detalle;
  final String? URL_PUBLICA;
  final String? COMENTARIOS;
  final String? USUARIO;
  final String? STATUS;
  final String? COMENTARIO_RECHAZO;

  Suministros({
    required this.requests,
    this.bodega,
    this.estacion,
    this.detalle,
    this.URL_PUBLICA,
    this.COMENTARIOS,
    this.USUARIO,
    this.STATUS,
    this.COMENTARIO_RECHAZO,
  });
  factory Suministros.fromMap(Map<String, dynamic> map) {
    return Suministros(
      requests: map['requests'] as int,
      bodega: map['bodega'] as String,
      estacion: map['estacion'] as String,
      detalle: map['detalle'] as String,
      URL_PUBLICA: map['URL_PUBLICA'] as String,
      COMENTARIOS: map['COMENTARIOS'] as String,
      USUARIO: map['USUARIO'] as String,
      STATUS: map['STATUS'] as String,
      COMENTARIO_RECHAZO: map['COMENTARIO_RECHAZO'] as String,
    );
  }
  Map <String, dynamic> toMap() {
    return {
      //'requests':requests,
      'bodega': bodega,
      'estacion': estacion,
      'detalle': detalle,
      'URL_PUBLICA': URL_PUBLICA,
      'COMENTARIOS': COMENTARIOS,
      'USUARIO': USUARIO,
      'STATUS': STATUS,
      'COMENTARIO_RECHAZO': COMENTARIO_RECHAZO,
    };
  }
}