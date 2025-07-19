import 'package:bancamovil/models/Forms.dart';
import 'package:bancamovil/models/novedadesbanco.dart';
import 'package:bancamovil/models/devoluciones.dart';
import 'package:bancamovil/models/sugerencias.dart';
import 'package:bancamovil/models/suministros.dart';
import 'package:bancamovil/models/quejas.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*class FormsDB {
  final database = Supabase.instance.client.from('Forms');

  Future<void> createForm(Forms form) async {
    await database.insert([form.toMap()]).select();
    /*if (response.error != null /*&& response.error!.message != null*/) {
      throw Exception(response.error!.message);
    }*/
  }

  final stream = Supabase.instance.client.from('Forms').stream(
    primaryKey: ['id']
    ).map((data) => data.map((e) => Forms.fromMap(e)).toList());

  Future updateForm(Forms form, String NewContent) async {
    final response = await database.update({'detail': NewContent}).eq('estacion', form.estacion);
    if (response.error != null && response.error!.message != null) {
      throw Exception(response.error!.message);
    }
  }
  Future deleteForm(Forms form) async {
    final response = await database.delete().eq('estacion', form.estacion);
    if (response.error != null && response.error!.message != null) {
      throw Exception(response.error!.message);
    }
  }

}*/

class NovedadesBanco {
  final database = Supabase.instance.client.from('Novedades');

  Future<void> createForm(BancoNovedades form) async {
    await database.insert([form.toMap()]).select();
  }

  final stream = Supabase.instance.client.from('Novedades').stream(
    primaryKey: ['id']
    ).map((data) => data.map((e) => Forms.fromMap(e)).toList());

}

class DevolucionesBanco {
  final database = Supabase.instance.client.from('Devoluciones');

  Future<void> createForm(BancoDevoluciones form) async {
    await database.insert([form.toMap()]).select();
  }

  final stream = Supabase.instance.client.from('Devoluciones').stream(
    primaryKey: ['id']
    ).map((data) => data.map((e) => Forms.fromMap(e)).toList());

}

class SuministrosBanco {
  final database = Supabase.instance.client.from('Suministros');

  Future<void> createForm(Suministros form) async {
    await database.insert([form.toMap()]).select();
  }

  Future<void> updateForm(Suministros form) async {
    if (form.requests == null) {
      throw ArgumentError('ID no puede ser nulo para actualizar');
    }
    await database.update(form.toMap()).eq('id', form.requests!);
  }


  final stream = Supabase.instance.client.from('Suministros').stream(
    primaryKey: ['requests']
    ).map((data) => data.map((e) => Forms.fromMap(e)).toList());

}

class QuejasBanco {
  final database = Supabase.instance.client.from('Quejas');

  Future<void> createForm(BancoQuejas form) async {
    await database.insert([form.toMap()]).select();
  }

  final stream = Supabase.instance.client.from('Quejas').stream(
    primaryKey: ['id_quejas']
    ).map((data) => data.map((e) => Forms.fromMap(e)).toList());

}

class SugerenciasUser {
  final database = Supabase.instance.client.from('Sugerencias');

  Future<void> createForm(Sugerencias form) async {
    await database.insert([form.toMap()]).select();
  }

  final stream = Supabase.instance.client.from('Sugerencias').stream(
    primaryKey: ['id_sugerencias']
    ).map((data) => data.map((e) => Forms.fromMap(e)).toList());

}
  /*Future<void> addForm(Forms form) async {
    final response = await supabaseClient.from('forms').upsert([form.toMap()]);
    if (response.error != null && response.error!.message != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> updateForm(Forms form) async {
    final response = await supabaseClient.from('forms').update([form.toMap()]);
    if (response.error != null && response.error!.message != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteForm(Forms form) async {
    final response = await supabaseClient.from('forms').delete().eq('id', form.id).execute();
    if (response.error != null && response.error!.message != null) {
      throw Exception(response.error!.message);
    }
  }*/
