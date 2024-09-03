import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkos_kirim/app/data/models/ongkir_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();

  RxBool isLoading = false.obs;

  List<Ongkir> ongkosKirim = [];

  RxString berat = "0".obs;
  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        codeKurir != "" &&
        beratC.text != "") {
      try {
        isLoading.value = true;
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "key": "0d8868c91bcbbe9e20ff137ddc89e156",
            'content-type': 'application/x-www-form-urlencoded'
          },
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": beratC.text,
            "courier": codeKurir.value,
          },
        );
        isLoading.value = false;

        var ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        if (ongkir.isEmpty) {
          Get.defaultDialog(
            title: "ONGKOS KIRIM",
            middleText: "PENGIRIMAN TIDAK TERSEDIA",
          );
          return; // Menghentikan eksekusi jika tidak ada pengiriman
        }
        List<Ongkir> datanya = Ongkir.fromJsonList(ongkir);
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        Get.defaultDialog(
          title: "ONGKOS KIRIM",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title: Text("${e.service!.toUpperCase()}"),
                    subtitle: Text("RP ${e.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        print(e);
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Tidak dapat mengecek ongkos kirim");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Data Input Belum Lengkap");
    }
  }
}
