import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/*Future<File> downloadFileFromSupabase({
  required String bucketName,
  required String filePath,
  
}) async {
  // 1. Obtener el directorio de descargas del dispositivo
  final Directory dir = await getApplicationDocumentsDirectory();
  final String localPath = '${dir.path}/$fileName';
  print(localPath);

  // 2. Descargar el archivo desde Supabase Storage
  final SupabaseClient supabase = Supabase.instance.client;
  final List<int> fileBytes = await supabase
      .storage
      .from(bucketName)
      .download(filePath);

  // 3. Guardar localmente
  final File localFile = File(localPath);
  await localFile.writeAsBytes(fileBytes);

  return localFile;
}*/

Future<File?> downloadFileFromSupabase({
  required String bucketName,
  required String filePath,
}) async {
  try {
    final SupabaseClient supabase = Supabase.instance.client;
    // Descarga el archivo desde Supabase
    final bytes = await supabase.storage
        .from(bucketName)
        .download(filePath);

    // Guarda en la carpeta pública de descargas
    final publicDir = await getDownloadsDirectory();
    print(publicDir); // Requiere <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    final publicFile = File('${publicDir?.path}/${filePath.split('/').last}');
    print(publicFile);
    await publicFile.writeAsBytes(bytes);

    return publicFile;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}