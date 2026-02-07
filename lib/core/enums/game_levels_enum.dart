enum GameLevelsEnum {
  level_01(playerHealth: 20, playerGold: 100),
  level_02(playerHealth: 20, playerGold: 120)
  ;

  final int playerHealth;
  final int playerGold;
  const GameLevelsEnum({required this.playerHealth, required this.playerGold});
}
