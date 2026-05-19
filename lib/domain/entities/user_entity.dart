class UserEntity {
 final int id;
 final String username;
 final String passwordHash;
 final String role;
 final String? activatonCode;
 final bool isActive;
 final String? refreshToken;
 final DateTime? refreshTokenExpiryTime;

 const UserEntity({
  required this.id,
  required this.username,
  required this.passwordHash,
  required this.role,
  required this.activatonCode,
  required this.isActive,
  required this.refreshToken,
  required this.refreshTokenExpiryTime

 });
}