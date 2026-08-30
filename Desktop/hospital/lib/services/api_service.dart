import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/doctor.dart';

class ApiService {
  // Android Emulator साठी
  static const String baseUrl =
      'http://10.0.2.2:8081/api';

  // ------------------------------------------------
  // GET ALL DOCTORS
  // ------------------------------------------------

  static Future<List<Doctor>> getDoctors() async {
    final response = await http.get(
      Uri.parse('$baseUrl/doctors'),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded
            .map(
              (json) => Doctor.fromJson(
            Map<String, dynamic>.from(json),
          ),
        )
            .toList();
      }

      throw Exception('Invalid doctors response');
    }

    throw Exception(
      'Failed to load doctors. '
          'Status code: ${response.statusCode}',
    );
  }

  // ------------------------------------------------
  // BOOK APPOINTMENT
  // ------------------------------------------------

  static Future<bool> bookAppointment({
    required int doctorId,
    required String patientName,
    required String mobileNumber,
    required String appointmentDate,
    required String appointmentTime,
    required String reason,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/appointments?doctorId=$doctorId',
    );

    final body = {
      'patientName': patientName,
      'mobileNumber': mobileNumber,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'reason': reason,
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return true;
    }

    throw Exception(
      'Booking failed. '
          'Status code: ${response.statusCode}\n'
          '${response.body}',
    );
  }

  // ------------------------------------------------
  // GET PATIENT APPOINTMENTS
  // ------------------------------------------------

  static Future<List<dynamic>>
  getPatientAppointments(
      String mobileNumber,
      ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/appointments/patient/$mobileNumber',
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded;
      }

      throw Exception(
        'Invalid appointments response',
      );
    }

    throw Exception(
      'Failed to load appointments. '
          'Status code: ${response.statusCode}',
    );
  }

  // ------------------------------------------------
  // CANCEL APPOINTMENT
  // ------------------------------------------------

  static Future<bool> cancelAppointment(
      int appointmentId,
      ) async {
    final response = await http.put(
      Uri.parse(
        '$baseUrl/appointments/$appointmentId/cancel',
      ),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(
      'Cancel failed. '
          'Status code: ${response.statusCode}',
    );
  }

  // ------------------------------------------------
  // DELETE APPOINTMENT
  // ------------------------------------------------

  static Future<bool> deleteAppointment(
      int appointmentId,
      ) async {
    final response = await http.delete(
      Uri.parse(
        '$baseUrl/appointments/$appointmentId',
      ),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 204) {
      return true;
    }

    throw Exception(
      'Delete failed. '
          'Status code: ${response.statusCode}',
    );
  }
}