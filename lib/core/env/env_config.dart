import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  final String baseUrl;
  final String appName;
  final bool isMock;

  const EnvConfig({
    required this.baseUrl,
    required this.appName,
    required this.isMock,
  });
}

class Env {
  static late EnvConfig config;

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');

    config = EnvConfig(
      baseUrl: dotenv.env['BASE_URL'] ?? "https://api.ipot.com",
      appName: dotenv.env['APP_NAME'] ?? "IPOT QR Order",
      isMock: dotenv.env['USE_MOCK'] == 'true'
    );
  }
}