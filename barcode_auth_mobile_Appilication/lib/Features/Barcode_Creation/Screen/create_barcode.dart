import 'package:barcode_auth/Features/Barcode_Creation/Controller/create_barcode_controller.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBarCode extends StatelessWidget {
  const CreateBarCode({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateBarcodeController controller =
    Get.isRegistered<CreateBarcodeController>()
        ? Get.find<CreateBarcodeController>()
        : Get.put(CreateBarcodeController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Text(
                  "USER REGISTRATION",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(fontWeightDelta: 600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DateTimeFormField(
                          initialValue: controller.creationDate.value,
                          decoration: const InputDecoration(
                            labelText: 'Creation Date',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.dark,
                            icon: Icon(Icons.date_range),
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (date) => controller.creationDate.value=date ?? DateTime.now()),
                      const SizedBox(height: 16),
                      DateTimeFormField(
                          initialValue: controller.creationTime.value,
                          decoration: const InputDecoration(
                            labelText: 'Creation Time',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.dark,
                            icon: Icon(Icons.access_time),
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          mode: DateTimeFieldPickerMode.time,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (date) => controller.creationTime.value=date ?? DateTime.now()),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: AppColors.dark,
                          icon: Icon(Icons.person),
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        onChanged: (data) => controller.name.value=data,
                        validator: (value) => controller.validateName(value!),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: AppColors.dark,
                          icon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (value) =>
                            controller.mobileNumber.value = value,
                        validator: (value) => controller.validateMobile(value!),
                      ),
                      const SizedBox(height: 16),
                      DateTimeFormField(
                          initialValue: controller.validatyDate.value,
                          validator: (date) => controller.validateDates(),
                          decoration: const InputDecoration(
                            labelText: 'Validity Date',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.dark,
                            icon: Icon(Icons.date_range),
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (date) => controller.validatyDate.value=date ?? DateTime.now()),
                      const SizedBox(height: 16),
                      DateTimeFormField(
                          initialValue: controller.creationTime.value,
                          validator: (date) => controller.validateDates(),
                          decoration: const InputDecoration(
                            labelText: 'Validity Time',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.dark,
                            icon: Icon(Icons.access_time),
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          mode: DateTimeFieldPickerMode.time,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (date) => controller.validatyTime.value=date ?? DateTime.now(),),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 8,
                          foregroundColor: AppColors.dark,
                          shadowColor: Colors.black.withOpacity(0.5),
                        ),
                        child: Text('Register Now'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
