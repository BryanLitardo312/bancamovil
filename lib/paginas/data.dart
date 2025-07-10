//import 'package:intl/intl.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class Data extends StatefulWidget {
  const Data ({super.key});
  @override
  State<Data> createState() => _DataState();

}

class _DataState extends State<Data> {
  double maximoY=0;
  double minimoY=0;
  double intervalo=0;


  bool _ordenado = false;
  Map<String, double> _datosOriginales = {};
  Map<String, double> _datosMostrados = {};

  @override
  void initState() {
    super.initState();
    final valor = Provider.of<Datamodel>(context, listen: false);
    _datosOriginales = valor.acumuladosPorNombre; // Datos originales
    _datosMostrados = Map.from(_datosOriginales); // Copia para mostrar
    maximoY=(_datosMostrados.values.isNotEmpty? _datosMostrados.values.reduce((a, b) => a > b ? a : b):1)*1.2;
    minimoY=(_datosMostrados.values.isNotEmpty? _datosMostrados.values.reduce((a, b) => a < b ? a : b):1)*1.2;
    intervalo=(_datosMostrados.values.map((x) => x.abs()).reduce((a, b) => a > b ? a : b))*(0.60);
  
  }

  void orden_ascendente() {
    setState(() {
      _ordenado = !_ordenado;
      
      if (_ordenado) {
        // Ordenar ascendente
        var entries = _datosOriginales.entries.toList();
        entries.sort((a, b) => b.value.compareTo(a.value));
        _datosMostrados = Map.fromEntries(entries);
      } else {
        // Volver a original
        _datosMostrados = Map.from(_datosOriginales);
      }
    });
  }

  void orden_descendente() {
    setState(() {
      _ordenado = !_ordenado;
      
      if (_ordenado) {
        // Ordenar ascendente
        var entries = _datosOriginales.entries.toList();
        entries.sort((a, b) => a.value.compareTo(b.value));
        _datosMostrados = Map.fromEntries(entries);
      } else {
        // Volver a original
        _datosMostrados = Map.from(_datosOriginales);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    //final double screenWidth = MediaQuery.of(context).size.width;
    final valor = Provider.of<Datamodel>(context, listen: false);
    return Consumer<Datamodel>(
      builder:(context,value,child)=>Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.arrow_circle_left_outlined,color:Colors.white,size: 50,),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Analítica',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.bar_chart,size:30,color:Colors.white),
                ],
              ),
              SizedBox(height: screenHeight*0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Evolución',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$ -${valor.saldoneto.toString()}',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            
                          ),
                        ),
                        Text(
                          '  (saldo neto)',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 17,
                            
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
              //Text('Novedades BI',style: TextStyle(color: Colors.white,fontSize: 35),),
              SizedBox(height: screenHeight*0.03),
              SizedBox(
                height: screenHeight*0.24,
                child: StreamBuilder(
                  stream: value.novedadesStream,
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No hay datos disponibles.'));
                    }
                    //final valor = Provider.of<Datamodel>(context, listen: false);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                              //tooltipBgColor: Colors.blueAccent, // Cambia el color de fondo del tooltip
                              tooltipRoundedRadius: 8, // Cambia el radio de las esquinas del tooltip
                              tooltipPadding: const EdgeInsets.all(8), // Ajusta el padding del tooltip
                              tooltipMargin: 8, // Ajusta el margen del tooltip
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((touchedSpot) {
                                  return LineTooltipItem(
                                    '\$${touchedSpot.y.toStringAsFixed(2)}', // Texto del tooltip
                                    const TextStyle(
                                      color: Colors.white, // Cambia el color del texto del tooltip
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: value.flSpotData,
                                //showingIndicators:value.flSpotData.map((spot) => spot.x).toList(),  // Los puntos que definiste
                                isCurved: false,  // Si quieres que la línea sea curva
                                color: Color.fromARGB(255, 109, 174, 217),  // Color de la línea
                                barWidth: 2,  // Grosor de la línea
                                dotData: FlDotData(show:false),  // Mostrar puntos en los datos
                                belowBarData: BarAreaData(
                                  gradient:LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors:[
                                      Color.fromARGB(255, 35, 128, 190).withOpacity(0.95),
                                      Colors.transparent,
                                    ]
                                  ),
                                  show: true
                                  ),
                              ),
                            ],
                            //minY:value.flSpotData.last.y,
                            //minX: minX,//(value.flSpotData.map((spot) => spot.x).reduce((a, b) => a < b ? a : b)),
                            //maxX: maxX, //(value.flSpotData.map((spot) => spot.x).reduce((a, b) => a > b ? a : b)),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                //axisNameWidget: const Text('Evolución mensual',style:TextStyle(color: Colors.white,fontSize:20)),
                                sideTitles: SideTitles(
                                  interval: (value.flSpotData.isNotEmpty
                                    ? (value.flSpotData.last.x - value.flSpotData.first.x)
                                    : 1.0),
                                  showTitles: true,
                                  getTitlesWidget: (valor, meta) {
                                    //final dia = valor.toInt(); // Convierte el valor del eje X a un entero
                                    String formatXAxis(double value) {
                                      final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                                      return DateFormat('dd/MM').format(date); // Convierte el timestamp a dd/MM
                                    }
                                    //print(value.fechaObj.toString);
                                    //print(formatXAxis(valor));
                                    return Text(
                                      formatXAxis(valor),
                                      //'$dia/${datames2.toInt()}',
                                      style: TextStyle(
                                        color:Colors.white,fontSize:14,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ); // Muestra el día como etiqueta
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                )
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                )
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: value.tipo == 'usuario' ? 45:55,
                                  interval: (value.flSpotData.map((spot) => spot.y.abs()).reduce((a, b) => a > b ? a : b)),
                                  getTitlesWidget: (valor, meta) {
                                    //final dia = valor.toInt(); // Convierte el valor del eje X a un entero
                                    return Text(
                                      '\$${valor.toStringAsFixed(0)}',
                                      //'\$$dia',
                                      style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ); // Muestra el día como etiqueta
                                  },              
                                ),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                            ),  // Mostrar cuadrícula
                            borderData: FlBorderData(show: false),  // Mostrar bordes
                          ),
                        ),
                    );
                  }
                ),
              ),
              SizedBox(height: screenHeight*0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value.tipo== 'usuario' ? 'Colaboradores': 'Red Atimasa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            orden_descendente();
                          },
                          icon: Icon(Icons.keyboard_double_arrow_down,color: Colors.red,size:30),
                        ),
                        IconButton(
                          onPressed: () {
                            orden_ascendente();
                          },
                          icon: Icon(Icons.keyboard_double_arrow_up,color: Colors.green,size:30),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: value.acumuladosPorNombre.keys.length*50,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      rotationQuarterTurns: 1,
                      gridData: FlGridData(
                        show:true,
                        drawVerticalLine: true,
                        verticalInterval: intervalo,//_datosMostrados.values.isNotEmpty? _datosMostrados.values.reduce((a, b) => a > b ? a : b): 1.0, // double - intervalo entre líneas verticales
                        getDrawingVerticalLine: (value) { // Función para personalizar líneas verticales
                          return FlLine(
                            color: Colors.grey.withOpacity(0.5),
                            strokeWidth: 0.5,
                          );
                        },
                      ),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          //tooltipBackgroundColor: Colors.blueAccent, // Cambia el color del fondo del tooltip
                          tooltipPadding: const EdgeInsets.all(8), // Ajusta el padding del tooltip
                          tooltipMargin: 8, // Ajusta el margen del tooltip
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '\$${rod.toY.toStringAsFixed(2)}', // Texto del tooltip
                              const TextStyle(
                                color: Colors.white, // Cambia el color del texto del tooltip
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            reservedSize: 130,
                            showTitles: true,
                            getTitlesWidget: (double valor, TitleMeta meta) {
                              //print('Llamada número: ${++counter}');
                              final index = valor.toInt();
                              //print(index);
                              if (index >= 0 && index <= value.acumuladosPorNombre.keys.length) {
                                return RotatedBox(
                                  quarterTurns: -1,
                                  child: Text(
                                    //value.acumuladosPorNombre.keys.elementAt(index).split(' ')[0],
                                    value.tipo == 'usuario' 
                                      ? value.acumuladosPorNombre.keys.elementAt(index).split(' ')[0] 
                                      : value.acumuladosPorNombre.keys.elementAt(index).split(' ').skip(1).join(' '),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                                    
                                
                              } else {
                                // Si el índice está fuera de rango, devuelve un widget vacío o un mensaje de error
                                return SizedBox.shrink(); // O un Text('Error: Índice fuera de rango')
                              }
                            }
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: intervalo,
                            //(value.acumuladosPorNombre.values.reduce((a, b) => a > b ? a : b)/5), // Intervalo entre valores
                            getTitlesWidget: (double valor, TitleMeta meta) {
                              //print(_datosMostrados.values.isNotEmpty? _datosMostrados.values.reduce((a, b) => a > b ? a : b): 1.0);
                              return RotatedBox(
                                quarterTurns:-1,
                                child: Text(
                                  '\$${valor.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: intervalo,
                            //(value.acumuladosPorNombre.values.reduce((a, b) => a > b ? a : b)/5), // Intervalo entre valores
                            getTitlesWidget: (double valor, TitleMeta meta) {
                              //print(_datosMostrados.values.isNotEmpty? _datosMostrados.values.reduce((a, b) => a > b ? a : b): 1.0);
                              return RotatedBox(
                                quarterTurns:-1,
                                child: Text(
                                  '\$${valor.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      barGroups: _datosMostrados.entries.map((entry) {
                        final nombre = entry.key;
                        final valor = entry.value;
                        //print(value.acumuladosPorNombre.values.isNotEmpty? value.acumuladosPorNombre.values.map((e) => e.abs()).reduce((a, b) => a < b ? a : b): 1.0);
          
                        return BarChartGroupData(
                          x: value.acumuladosPorNombre.keys.toList().indexOf(nombre),
                          barRods: [
                            BarChartRodData(
                              toY: double.parse(valor.toStringAsFixed(2)),
                              color: valor >= 0 ? Colors.green : Colors.redAccent,
                              gradient: valor >= 0
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.green,
                                      Colors.green.withOpacity(0.3),
                                      //Color.fromARGB(255, 200, 255, 200),
                                      //Color.fromARGB(255, 0, 255, 0),
                                    ],
                                  )
                                : LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.red,
                                      Colors.redAccent.withOpacity(0.5),
                                      //Color.fromARGB(255, 255, 200, 200),
                                      //Color.fromARGB(255, 200, 0, 0),
                                    ],
                                  ),
                              //color: Colors.blue,
                              width: 40,
                              borderRadius: BorderRadius.circular(5),
                              /*backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: double.parse(valor.abs().toStringAsFixed(2)) + 5, // Espacio extra para el texto
                                color: Colors.transparent,
                              ),*/
                            ),
                          ],
                        );
                      }).toList(),
                      maxY: maximoY,//value.acumuladosPorNombre.values.isNotEmpty? value.acumuladosPorNombre.values.map((e) => e.abs()).reduce((a, b) => a < b ? a : b): 1.0,
                      minY: minimoY,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.06),
            ],
          ),
        ),
      ),
    );
  }
}