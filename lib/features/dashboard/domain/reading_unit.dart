enum ReadingProperties {
  celsius('°C', -10, 50, 10),
  percent('%', 0, 100, 20),
  analog(null, 0, 4096, 512);

  final String? unit;
  final double min;
  final double max;
  final double chartInterval;
  const ReadingProperties(this.unit, this.min, this.max, this.chartInterval);
}
