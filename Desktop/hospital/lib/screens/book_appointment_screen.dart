import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../services/api_service.dart';
import 'booking_success_screen.dart';

class BookAppointmentScreen
    extends StatefulWidget {

  final Doctor doctor;

  const BookAppointmentScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<BookAppointmentScreen>
  createState() =>
      _BookAppointmentScreenState();
}

class _BookAppointmentScreenState
    extends State<BookAppointmentScreen> {

  DateTime selectedDate =
  DateTime.now();

  String selectedTime =
      '11:00 AM';

  final nameController =
  TextEditingController(
    text: 'Vaishnavi Nikam',
  );

  final phoneController =
  TextEditingController();

  final reasonController =
  TextEditingController();

  bool isBooking = false;

  Future<void> selectDate() async {
    final date =
    await showDatePicker(
      context: context,

      firstDate: DateTime.now(),

      lastDate: DateTime.now().add(
        const Duration(days: 90),
      ),

      initialDate: selectedDate,
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> confirmBooking() async {
    final patientName =
    nameController.text.trim();

    final mobileNumber =
    phoneController.text.trim();

    final reason =
    reasonController.text.trim();

    if (patientName.isEmpty) {
      showError(
        'Please enter patient name',
      );
      return;
    }

    if (mobileNumber.isEmpty) {
      showError(
        'Please enter mobile number',
      );
      return;
    }

    if (mobileNumber.length != 10) {
      showError(
        'Please enter valid 10 digit mobile number',
      );
      return;
    }

    setState(() {
      isBooking = true;
    });

    final formattedDate =
        '${selectedDate.year}-'
        '${selectedDate.month.toString().padLeft(2, '0')}-'
        '${selectedDate.day.toString().padLeft(2, '0')}';

    try {
      await ApiService.bookAppointment(
        doctorId: widget.doctor.id,
        patientName: patientName,
        mobileNumber: mobileNumber,
        appointmentDate: formattedDate,
        appointmentTime: selectedTime,
        reason: reason,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
              BookingSuccessScreen(
                doctor: widget.doctor,
                date: selectedDate,
                time: selectedTime,
              ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      showError(
        'Booking failed.\nPlease make sure the backend is running.',
      );
    } finally {
      if (mounted) {
        setState(() {
          isBooking = false;
        });
      }
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    reasonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Book Appointment'),
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Card(
              child: ListTile(
                leading:
                const CircleAvatar(
                  child:
                  Icon(Icons.person),
                ),

                title:
                Text(widget.doctor.name),

                subtitle:
                Text(
                  widget.doctor
                      .specialization,
                ),

                trailing:
                Text(
                  '₹${widget.doctor.fee.toInt()}',

                  style:
                  const TextStyle(
                    color: Colors.indigo,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Date',

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: selectDate,

              icon: const Icon(
                Icons.calendar_month,
              ),

              label: Text(
                '${selectedDate.day}/'
                    '${selectedDate.month}/'
                    '${selectedDate.year}',
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Select Time',

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,

              children: [
                '10:00 AM',
                '11:00 AM',
                '12:00 PM',
                '04:00 PM',
                '05:00 PM',
              ].map(
                    (time) {

                  final selected =
                      selectedTime == time;

                  return ChoiceChip(
                    label:
                    Text(time),

                    selected:
                    selected,

                    onSelected: (_) {
                      setState(() {
                        selectedTime =
                            time;
                      });
                    },
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 25),

            const Text(
              'Patient Name',

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller:
              nameController,

              decoration:
              const InputDecoration(
                border:
                OutlineInputBorder(),

                hintText:
                'Enter patient name',
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Mobile Number',

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller:
              phoneController,

              keyboardType:
              TextInputType.phone,

              maxLength: 10,

              decoration:
              const InputDecoration(
                border:
                OutlineInputBorder(),

                hintText:
                'Enter mobile number',

                counterText: '',
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Reason for Visit',

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller:
              reasonController,

              maxLines: 3,

              decoration:
              const InputDecoration(
                border:
                OutlineInputBorder(),

                hintText:
                'Enter reason',
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed:
                isBooking
                    ? null
                    : confirmBooking,

                child: isBooking
                    ? const SizedBox(
                  height: 24,
                  width: 24,

                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )

                    : const Text(
                  'Confirm Booking',

                  style:
                  TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}