import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smartchef/core/classes/statusrequest.dart';
import 'package:smartchef/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      print("alan");
      print("im the sending data here $data");
      var response = await http.post(
        Uri.parse(linkurl),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      print("nnnnnnnn");
      print(response.statusCode);
      print("xxxxxxxxxxxxxx");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print(response.statusCode);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkurl));
        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } on SocketException catch (_) {
      return const Left(StatusRequest.offlinefailure);
    } on HttpException catch (_) {
      return const Left(StatusRequest.serverfailure);
    } catch (e) {
      return const Left(StatusRequest.failure);
    }
  }
}
