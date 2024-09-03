import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ongkos Kirim',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            // A S A L
            DropdownSearch<Province>(
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "0d8868c91bcbbe9e20ff137ddc89e156"},
                );
                return Province.fromJsonList(
                  response.data["rajaongkir"]["results"],
                );
              },
              itemAsString: (Province item) => item.province.toString(),
              onChanged: (value) =>
                  controller.provAsalId.value = value?.provinceId ?? "0",
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Provinsi Asal",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(item.province!),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            DropdownSearch<City>(
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId}",
                  queryParameters: {"key": "0d8868c91bcbbe9e20ff137ddc89e156"},
                );
                return City.fromJsonList(
                  response.data["rajaongkir"]["results"],
                );
              },
              itemAsString: (City item) => item.cityName.toString(),
              onChanged: (value) =>
                  controller.cityAsalId.value = value?.cityId ?? "0",
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Kota/Kabupaten Asal",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text("${item.type} ${item.cityName!}"),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // T U J U A N
            DropdownSearch<Province>(
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "0d8868c91bcbbe9e20ff137ddc89e156"},
                );
                return Province.fromJsonList(
                  response.data["rajaongkir"]["results"],
                );
              },
              itemAsString: (Province item) => item.province.toString(),
              onChanged: (value) =>
                  controller.provTujuanId.value = value?.provinceId ?? "0",
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Provinsi Tujuan",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(item.province!),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            DropdownSearch<City>(
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId}",
                  queryParameters: {"key": "0d8868c91bcbbe9e20ff137ddc89e156"},
                );
                return City.fromJsonList(
                  response.data["rajaongkir"]["results"],
                );
              },
              itemAsString: (City item) => item.cityName.toString(),
              onChanged: (value) =>
                  controller.cityTujuanId.value = value?.cityId ?? "0",
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Kota/Kabupaten Tujuan",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text("${item.type} ${item.cityName!}"),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: controller.beratC,
              autocorrect: false,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Berat (gram)",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
            ),
            SizedBox(height: 20),

            // K U R I R
            DropdownSearch<Map<String, dynamic>>(
              items: [
                {"code": "jne", "name": "JNE"},
                {"code": "pos", "name": "POS Indonesia"},
                {"code": "tiki", "name": "TIKI"}
              ],
              onChanged: (value) =>
                  controller.codeKurir.value = value?["code"] ?? "",
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pilih Kurir",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text("${item["name"]}"),
                  );
                },
              ),
              dropdownBuilder: (context, selectedItem) => Text(
                "${selectedItem?['name'] ?? "Pilih Kurir"}",
              ),
            ),
            SizedBox(height: 30),
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.cekOngkir();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? "CEK ONGKOS KIRIM"
                    : "LOADING"),
              ),
            ),
          ],
        ));
  }
}
