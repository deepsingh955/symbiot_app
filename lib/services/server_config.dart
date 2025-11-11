/// Enum to define different server environments
enum ServerEnvironment { production, test }

/// Model to hold server configuration details
class _ServerDetails {
  final String baseUrl;

  const _ServerDetails({required this.baseUrl});
}

/// Main configuration class for server settings
class ServerConfig {
  /// Current environment (change this to switch environments)
  static const ServerEnvironment _environment = ServerEnvironment.test;

  /// Server configurations for different environments
  static const _prodConfig = _ServerDetails(
    baseUrl: "https://iot.faberwork.com/",
  );

  static const _testConfig = _ServerDetails(
    baseUrl: "https://symbiottest.netlify.app/",
  );

  /// Selected configuration based on environment
  static _ServerDetails get _activeConfig {
    switch (_environment) {
      case ServerEnvironment.production:
        return _prodConfig;
      case ServerEnvironment.test:
        return _testConfig;
    }
  }

  /// Exposed configuration values
  static String get baseUrl => _activeConfig.baseUrl;
}
