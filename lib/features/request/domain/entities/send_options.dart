class SendOptions {
  const SendOptions({
    this.timeout = const Duration(seconds: 30),
    this.followRedirects = true,
    this.verifySsl = true,
  });

  final Duration timeout;
  final bool followRedirects;
  final bool verifySsl;
}
