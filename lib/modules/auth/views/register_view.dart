import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                
                const Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // Name Field
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Full Name',
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) => Validators.name(value),
                ),
                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),

                // Password Field
                Obx(() => CustomTextField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      obscureText: !controller.isPasswordVisible.value,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      validator: Validators.password, 
                    )),
                const SizedBox(height: 16),

                // Confirm Password Field
                Obx(() => CustomTextField(
                      controller: controller.confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      validator: (value) => Validators.confirmPassword(
                        value,
                        controller.passwordController.text,
                      ),
                    )),
                const SizedBox(height: 30),

                // Register Button
                Obx(() => CustomButton(
                      text: 'Register',
                      onPressed: controller.register,
                      isLoading: controller.isLoading.value,
                    )),
                const SizedBox(height: 20),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: controller.goToLogin,
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
