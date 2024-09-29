import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:beerenyi/app/models/user.dart';
import 'package:beerenyi/app/services/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class PocketbaseService {
  static PocketbaseService get to => Get.find();
  final _url = 'https://pb.intra.tvk.lol';
  late PocketBase _client;
  late AuthStore _authStore;
  late String _temporaryDirectory;
  final _httpClient = HttpClient();
  User? user;
  bool get isAuth => user != null;

  Future<PocketbaseService> init() async {
    _temporaryDirectory = (await getTemporaryDirectory()).path;
    _initializeAuthStore();
    _client = PocketBase(_url, authStore: _authStore);
    _client.authStore.onChange.listen((AuthStoreEvent event) {
      if (event.model is RecordModel) {
        user = User.fromJson(event.model.toJson());
        user?.token = event.token;
        StorageService.to.user = user;
      }
    });
    return this;
  }

  void _initializeAuthStore() {
    _authStore = AuthStore();
    user = StorageService.to.user;
    String? token = user?.token;
    if (user == null || token == null) return;
    RecordModel model = RecordModel.fromJson(user!.toJson());
    _authStore.save(token, model);
  }

  Future login() async {
    try {
      RecordAuth userData =
          await _client.collection('users').authWithOAuth2("microsoft", (url) {
            launchUrl(url);
          });
      return userData;
    } on ClientException catch (_) {
      rethrow;
    }
  }

  Future logout() async {
    _client.authStore.clear();
    StorageService.to.user = null;
  }

  Uri getFileUrl(RecordModel recordModel, String fileName) =>
      _client.getFileUrl(recordModel, fileName);

  Future<File?> downloadFile({
    required RecordModel recordModel,
    required String fileName,
    bool useCache = false,
  }) async {
    try {
      Uri fileUri = _client.getFileUrl(recordModel, fileName);
      File file = File('$_temporaryDirectory/$fileName');
      if (useCache && file.existsSync()) return file;
      var request = await _httpClient.getUrl(fileUri);
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      return await file.writeAsBytes(bytes);
    } catch (error) {
      return null;
    }
  }
}
