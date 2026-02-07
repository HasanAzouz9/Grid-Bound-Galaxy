enum ProjectileType {
  energy,
  laser,
  missile,
  electric,
}

ProjectileType projectileTypeFromJson(String value) => ProjectileType.values.firstWhere((e) => e.name == value);

String projectileTypeToJson(ProjectileType type) => type.name;
