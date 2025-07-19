import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Text Form Field Section
  Widget buildTextField(String label, Function(String) onChanged, {TextEditingController? controller, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true, 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            ),
            onChanged: onChanged,
            enabled: enabled,
            validator: (value) => value!.isEmpty 
              ? 'Please enter $label' 
              : null,
          ),
        ],
      ),
    );
  }

//Review Section
  Widget buildReviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text('$label: ', 
            style: TextStyle(
              fontWeight: FontWeight.bold)
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

//Calculate Section
  String calculateAge(String birthdate) {
    if (birthdate.isEmpty) return '0';
    try {
      DateTime birthDate = DateFormat('MM/dd/yyyy').parseStrict(birthdate);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
         (today.month == birthDate.month && 
        today.day < birthDate.day)) {
        age--;
      }
      return age.toString();
    } catch (e) {
        return 'Invalid date format';
    }
  }
