import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/vision/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

final visionApiProvider = FutureProvider((ref) async {
  await dotenv.load(fileName: 'lib/.env');
  final email = dotenv.env['CLIENT_EMAIL']!;
  final clientIdIdentifier = dotenv.env['CLIENT_ID']!;
  final privateKey = dotenv.env['PRIVATE_KEY']!;
  final clientId = ClientId(clientIdIdentifier);
  final credentials = ServiceAccountCredentials(
    email,
    clientId,
    privateKey,
  );
  final scopes = [VisionApi.cloudVisionScope];
  final client = await clientViaServiceAccount(credentials, scopes);
  return VisionApi(client);
});