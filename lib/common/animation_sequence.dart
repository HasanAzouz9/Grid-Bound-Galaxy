class AnimationSequence {
  final int start;
  final int stop;
  final int amount;
  final int firingFrame;
  final int amountPerRow;
  final double stepTime;
  final List<double> stepTimes;
  final double textureSizeWidth;
  final double textureSizeHeight;

  AnimationSequence({
    required this.start,
    required this.stop,
    required this.amount,
    required this.firingFrame,
    required this.amountPerRow,
    required this.stepTime,
    required this.stepTimes,
    required this.textureSizeWidth,
    required this.textureSizeHeight,
  });

  factory AnimationSequence.fromJson(Map<String, dynamic> json) {
    return AnimationSequence(
      start: json['start'],
      stop: json['stop'],
      amount: json['amount'],
      firingFrame: json['firingFrame'],
      amountPerRow: json['amountPerRow'],
      stepTime: (json['stepTime'] as num).toDouble(),
      stepTimes: (json['stepTimes'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      textureSizeWidth: (json['textureSizeWidth'] as num).toDouble(),
      textureSizeHeight: (json['textureSizeHeight'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'stop': stop,
      'amount': amount,
      'amountPerRow': amountPerRow,
      'firingFrame': firingFrame,
      'stepTime': stepTime,
      'stepTimes': stepTimes,
      'textureSizeWidth': textureSizeWidth,
      'textureSizeHeight': textureSizeHeight,
    };
  }
}
