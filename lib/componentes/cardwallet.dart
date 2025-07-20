import 'package:flutter/material.dart';
import '../models/wallet.dart';

class card_wallet extends StatelessWidget {
  final Wallet wallet;
  const card_wallet ({super.key,required this.wallet});

  /*@override
  State<card_wallet> createState() => _card_walletState();
}*/

  @override
  Widget build (BuildContext context){
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      padding: const EdgeInsets.all(10),
      height: screenHeight * 0.28,
      //width: 350,
      decoration: BoxDecoration(
        //color: Colors.grey[900],
        gradient: LinearGradient(
          colors: [
            Colors.grey[800]!, // Gris claro
            Colors.black, // Gris medio
          ],
          stops: [0.0, 0.5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0,3),
          ),
        ],
      ),
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical:5,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('lib/imagenes/VISA-logo.png',height: 50,color:Colors.white),
                //SizedBox(height: screenHeight * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('**** **** **** 4556 ',style: TextStyle(color: Colors.white,fontSize: 21,overflow: TextOverflow.ellipsis),),
                    SizedBox(height: 10),
                Text('\$${double.parse(wallet.monto.toStringAsFixed(2))}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 26,overflow: TextOverflow.ellipsis),),
                  ],
                ),
              ],
            ),
            const Column(
              children: [
                Icon(Icons.keyboard_double_arrow_right_rounded, color: Colors.white,size: 45,),
              ],
            ),
          ],
        ),
      )
    );
  }
}