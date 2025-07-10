
class Suministros {
  
  final String bodega;
  final String estacion;
  final String detalle;

  Suministros({
    
    required this.bodega,
    required this.estacion,
    required this.detalle,
  });
  factory Suministros.fromMap(Map<String, dynamic> map) {
    return Suministros(
      
      bodega: map['bodega'] as String,
      estacion: map['estacion'] as String,
      detalle: map['detalle'] as String,
    );
  }
  Map <String, dynamic> toMap() {
    return {
      
      'bodega': bodega,
      'estacion': estacion,
      'detalle': detalle,
    };
  }
}