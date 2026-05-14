import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://task.itprojects.web.id';

  // ── AUTH ──────────────────────────────────────────────
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      return {'success': true, 'user': User.fromJson(data)};
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Login gagal',
      };
    }
  }

  // ── PRODUCTS ──────────────────────────────────────────
  static Future<List<Product>> getProducts(String token) async {
    final url = Uri.parse('$baseUrl/api/products');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['data']['products'] ?? [];
      return list.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Map<String, dynamic>> createProduct(
    String token,
    String name,
    int price,
    String description,
  ) async {
    final url = Uri.parse('$baseUrl/api/products');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);
    return {
      'success': response.statusCode == 200 || response.statusCode == 201,
      'message': data['message'] ?? '',
    };
  }

  static Future<Map<String, dynamic>> deleteProduct(
    String token,
    int id,
  ) async {
    final url = Uri.parse('$baseUrl/api/products/$id');
    final response = await http.delete(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);
    return {
      'success': response.statusCode == 200,
      'message': data['message'] ?? '',
    };
  }

  // ── SUBMIT ────────────────────────────────────────────
  static Future<Map<String, dynamic>> submitTugas(
    String token,
    String name,
    int price,
    String description,
    String githubUrl,
  ) async {
    final url = Uri.parse('$baseUrl/api/products/submit');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
        'github_url': githubUrl,
      }),
    );

    final data = jsonDecode(response.body);
    return {
      'success': response.statusCode == 200 || response.statusCode == 201,
      'message': data['message'] ?? '',
    };
  }
}