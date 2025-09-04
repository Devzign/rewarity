class Env {
  final String flavor;
  final String baseUrl;
  final bool enableDebugTools;

  Env({required this.flavor, required this.baseUrl, required this.enableDebugTools});

  factory Env.fromPlatform() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (flavor) {
      case 'prod':
        return Env(flavor: 'prod', baseUrl: 'https://api.rewarity.com', enableDebugTools: false);
      case 'stg':
        return Env(flavor: 'stg', baseUrl: 'https://stg.api.rewarity.com', enableDebugTools: true);
      default:
        return Env(flavor: 'dev', baseUrl: 'http://10.0.2.2:8080', enableDebugTools: true);
    }
  }
}
