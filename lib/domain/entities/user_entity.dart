class UserEntity {
 final int id;
 final String username;
 final String passwordHash;
 final String role;
 final String? activationCode;
 final bool isActive;
 final String? refreshToken;
 final DateTime? refreshTokenExpiryTime;
 final int? locationId;
 final int? locationGroupId;

 const UserEntity({
  required this.id,
  required this.username,
  required this.passwordHash,
  required this.role,
  required this.activationCode,
  required this.isActive,
  required this.refreshToken,
  required this.refreshTokenExpiryTime,
  this.locationId,
  this.locationGroupId,
 });
}
