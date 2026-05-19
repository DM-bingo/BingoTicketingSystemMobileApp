import 'package:bingo_ticketing_system_mobile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.Id,
    required super.Username,
    required super.PasswordHash,
    required super.Role,
    required super.ActivatonCode,
    required super.IsActive,
    required super.RefreshToken,
    required super.RefreshTokenExpiryTime
  });


  factory UserModel.fromJson(Map<String, dynamic> json){
        return UserModel(
            Id: json['id'] as int,
            Username: json['Username'], 
            PasswordHash: json['PasswordHash'], 
            Role: json['Role'],
            ActivatonCode: json['ActivationCode'],         
            IsActive: json['IsActive'],
            RefreshToken: json['RefreshToken'],     
            RefreshTokenExpiryTime: json['RefreshTokenExpiryTime']
            );
            
  }
}