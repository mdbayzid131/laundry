import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF0F4F8,
      ), // Light map-like background color
      body: Stack(
        children: [
          // 1. Map Content (Draggable and Zoomable)
          Positioned.fill(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 3.0,
              boundaryMargin: EdgeInsets.all(
                800.w,
              ), // Allow panning outside the bounds
              constrained: false, // Allow map to be larger than the screen
              child: SizedBox(
                width: 1200.w, // Simulated map canvas width
                height: 1400.h, // Simulated map canvas height
                child: Stack(
                  children: [
                    // Map Background Texture
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.network(
                          'https://www.transparenttextures.com/patterns/cubes.png', // Subtle texture feeling like city blocks
                          repeat: ImageRepeat.repeat,
                          color: Colors.blueGrey.shade100,
                          colorBlendMode: BlendMode.srcIn,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: const Color(0xFFE8ECEF)),
                        ),
                      ),
                    ),

                    // Additional visual styling representing a map
                    Positioned.fill(
                      child: CustomPaint(painter: _MockMapPainter()),
                    ),

                    // "Portland" Text matching the image (moving with map)
                    Positioned(
                      top: 700.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Portland',
                          style: GoogleFonts.manrope(
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 4.r,
                                offset: Offset(2.w, 2.h),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 2. Map Pins (Shop Locations)
                    // Placed relative to the new 1200x1400 canvas
                    _buildMapPin(
                      top: 350.h,
                      left: 280.w,
                      shopName: 'Pearl District Cleaners',
                    ),
                    _buildMapPin(
                      top: 280.h,
                      left: 560.w,
                      shopName: 'Moda Center Wash',
                    ),
                    _buildMapPin(
                      top: 600.h,
                      left: 880.w,
                      shopName: 'Eastside Laundry',
                    ),
                    _buildMapPin(
                      top: 750.h,
                      left: 720.w,
                      shopName: 'Old Town Dry Clean',
                    ),
                    _buildMapPin(
                      top: 850.h,
                      left: 420.w,
                      shopName: 'SW Barbur Wash',
                    ),
                    _buildMapPin(
                      top: 980.h,
                      left: 900.w,
                      shopName: 'OMS Cleaners',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Top Navigation & Search Bar (Floating above the map)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    // Back Button
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Search Bar
                    Expanded(
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 16.w),
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade400,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.manrope(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search LaundryLink....',
                                  hintStyle: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    bottom: 2.h,
                                  ), // align text with icon
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Layers/Filters Button
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.layers_outlined,
                          size: 24.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to draw the red map pin
  Widget _buildMapPin({
    required double top,
    required double left,
    required String shopName,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          Get.snackbar(
            shopName,
            'View details and book a service from this store.',
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
            backgroundColor: Colors.white,
            colorText: Colors.black87,
            borderRadius: 12.r,
            boxShadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.r,
                offset: Offset(0, -2.h),
              ),
            ],
            icon: Icon(
              Icons.local_laundry_service,
              color: const Color(0xFFE53935),
            ),
          );
        },
        child: Container(
          // The shadow for the pin
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.r,
                offset: Offset(0, 4.h),
              ),
            ],
            shape: BoxShape.circle,
          ),
          // Adding a slightly larger invisible tap target
          padding: EdgeInsets.all(8.w),
          child: Icon(
            Icons.location_on,
            size: 48.sp,
            color: const Color(0xFFE53935), // The solid red from the picture
          ),
        ),
      ),
    );
  }
}

// A simple painter to mock roads or rivers for the map background
class _MockMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // We scale the path drawing to fit our new larger canvas (1200x1400)
    final paint = Paint()
      ..color = Colors.blue
          .withOpacity(0.15) // Mock river color
      ..strokeWidth = 60.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.2, 0);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.4,
      size.width * 0.7,
      size.height,
    );

    final paintRoad = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final roadPath = Path();
    roadPath.moveTo(0, size.height * 0.3);
    roadPath.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.5,
      size.width,
      size.height * 0.6,
    );

    // Additional cross road
    final roadPath2 = Path();
    roadPath2.moveTo(size.width * 0.8, 0);
    roadPath2.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.4,
      size.width * 0.2,
      size.height,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(roadPath, paintRoad);
    canvas.drawPath(roadPath2, paintRoad);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
