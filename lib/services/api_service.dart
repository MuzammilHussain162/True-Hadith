import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  // Update this with your Flask backend URL
  static const String baseUrl = 'http:// 192.168.100.12:5000/api'; // Change to your backend URL
  
  // For Android emulator, use: http://10.0.2.2:5000/api
  // For iOS simulator, use: http://localhost:5000/api
  // For physical device, use your computer's IP: http://192.168.x.x:5000/api

  static Future<UserModel> registerUser({
    required String firebaseUid,
    required String username,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firebase_uid': firebaseUid,
          'username': username,
          'email': email,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Registration failed');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }

  static Future<UserModel> loginUser({
    required String firebaseUid,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firebase_uid': firebaseUid,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }
}

