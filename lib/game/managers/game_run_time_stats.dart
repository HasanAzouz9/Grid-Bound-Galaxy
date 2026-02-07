import 'package:flutter_riverpod/legacy.dart';

class GameSession {
  final int playerHealth;
  final int playerGold;
  final int totalWaves;
  final int currentWave;

  GameSession({
    required this.playerHealth,
    required this.playerGold,
    required this.totalWaves,
    required this.currentWave,
  });

  GameSession copyWith({int? playerHealth, int? playerGold, int? totalWaves, int? currentWave}) {
    return GameSession(
      playerHealth: playerHealth ?? this.playerHealth,
      playerGold: playerGold ?? this.playerGold,
      totalWaves: this.totalWaves,
      currentWave: this.currentWave,
    );
  }
}

class GameSessionController extends StateNotifier<GameSession> {
  static final provider = StateNotifierProvider<GameSessionController, GameSession>(
    (ref) => GameSessionController(),
  );
  GameSessionController() : super(GameSession(playerHealth: 20, playerGold: 100, totalWaves: 0, currentWave: 0));

  void setGameSession({required GameSession gameSession}) {
    state = gameSession;
  }

  void decreaseHealth({required int amount}) {
    state = state.copyWith(playerHealth: state.playerHealth - amount);
  }

  void nextWave() {
    state = state.copyWith(currentWave: state.currentWave + 1);
  }

  void decreaseGold({required int amount}) {
    state = state.copyWith(playerGold: state.playerGold - amount);
  }

  void increaseGold({required int amount}) {
    state = state.copyWith(playerGold: state.playerGold + amount);
  }
}
