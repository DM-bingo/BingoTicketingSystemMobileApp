class UserEntity {
 final int Id;
 final String Username;
 final String PasswordHash;
 final String Role;
 final String? ActivatonCode;
 final bool IsActive;
 final String? RefreshToken;
 final DateTime? RefreshTokenExpiryTime;

 const UserEntity({
  required this.Id,
  required this.Username,
  required this.PasswordHash,
  required this.Role,
  required this.ActivatonCode,
  required this.IsActive,
  required this.RefreshToken,
  required this.RefreshTokenExpiryTime

 });
}