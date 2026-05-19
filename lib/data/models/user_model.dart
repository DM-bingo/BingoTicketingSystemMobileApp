import 'package:bingo_ticketing_system_mobile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.passwordHash,
    required super.role,
    required super.activatonCode,
    required super.isActive,
    required super.refreshToken,
    required super.refreshTokenExpiryTime
  });


  factory UserModel.fromJson(Map<String, dynamic> json){
        return UserModel(
            id: json['id'] as int,
            username: json['Username'], 
            passwordHash: json['PasswordHash'], 
            role: json['Role'],
            activatonCode: json['ActivationCode'],         
            isActive: json['IsActive'],
            refreshToken: json['RefreshToken'],     
            refreshTokenExpiryTime: json['RefreshTokenExpiryTime']
            );
            
  }
}