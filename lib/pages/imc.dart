
import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class IMC {
  @HiveField(0)
  double peso;

  @HiveField(1)
  double altura;

  @HiveField(2)
  DateTime data;

  IMC({required this.peso, 
  required this.altura,
  required this.data});
}

