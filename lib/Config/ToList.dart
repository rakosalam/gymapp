import 'dart:convert';

import 'package:gymapp/models/Customermodel.dart';

List<Customermodel> itemsCategoriesFromJson(String str) =>
    List<Customermodel>.from(
        json.decode(str).map((x) => Customermodel.fromJson(x)));
