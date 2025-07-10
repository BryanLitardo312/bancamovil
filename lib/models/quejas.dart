class BancoQuejas {
  
  final String bodega;
  final String estacion;
  final String proceso;
  final String detalle;
  final String salida;
  final String observacion;
  


  BancoQuejas({
    
    required this.bodega,
    required this.estacion,
    required this.proceso,
    required this.detalle,
    required this.salida,
    required this.observacion,
    
  });
  factory BancoQuejas.fromMap(Map<String, dynamic> map) {
    return BancoQuejas(
      
      bodega: map['bodega'] as String,
      estacion: map['estacion'] as String,
      proceso: map['proceso'] as String,
      detalle: map['detalle'] as String,
      salida: map['salida'] as String,
      observacion: map['observacion'] as String,
      
    );
  }
  Map <String, dynamic> toMap() {
    return {
      'bodega': bodega,
      'estacion': estacion,
      'proceso': proceso,
      'detalle': detalle,
      'salida': salida,
      'observacion': observacion,
      
    };
  }
}