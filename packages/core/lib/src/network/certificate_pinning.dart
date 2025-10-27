import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Certificate pinning adapter for Dio
/// Implements SSL pinning to prevent man-in-the-middle attacks
class CertificatePinningAdapter extends IOHttpClientAdapter {
  final Map<String, String> pinnedCertificates;

  CertificatePinningAdapter({
    required this.pinnedCertificates,
  });

  @override
  void configure(HttpClient httpClient) {
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
      // Check if we have a pinned certificate for this host
      final pinnedCert = pinnedCertificates[host];
      if (pinnedCert == null) {
        // No pinned certificate for this host, reject
        return false;
      }

      // Get the SHA-1 fingerprint of the certificate (sha256 not available in dart:io)
      final certSha1 = cert.sha1.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');

      // Compare with pinned certificate
      return certSha1.toUpperCase() == pinnedCert.toUpperCase();
    };
  }
}

/// Example pinned certificates
/// In production, these would be actual certificate fingerprints
class PinnedCertificates {
  static const Map<String, String> production = {
    'api.example.com':
        'AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99',
  };

  static const Map<String, String> staging = {
    'api-staging.example.com':
        '11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF:00',
  };
}
