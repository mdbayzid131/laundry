import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:laundry/modules/home/controllers/home_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  VendorModel? selectedVendor;

  static const LatLng _center = LatLng(45.5152, -122.6784);
  LatLng _currentCameraPosition = _center;

  // Sample vendor data
  final List<VendorModel> vendors = [
    VendorModel(
      id: '1',
      name: 'Fresh Clean Laundry',
      location: const LatLng(45.5230, -122.6765),
      rating: 4.8,
      reviews: 256,
      deliveryTime: '2-4 hours',
      distance: '0.5 miles',
      logoUrl: 'assets/icons/dry_clean.svg',
      photoUrl: 'assets/dummy_image/op1.png',
    ),
    VendorModel(
      id: '2',
      name: 'QuickWash Express',
      location: const LatLng(45.5100, -122.6900),
      rating: 4.5,
      reviews: 182,
      deliveryTime: '3-5 hours',
      distance: '0.7 miles',
      logoUrl: 'assets/icons/iron_and_press.svg',
      photoUrl: 'assets/dummy_image/op2.png',
    ),
    VendorModel(
      id: '3',
      name: 'Pearl District Cleaners',
      location: const LatLng(45.5260, -122.6820),
      rating: 4.9,
      reviews: 412,
      deliveryTime: '1-3 hours',
      distance: '0.3 miles',
      logoUrl: 'assets/icons/shirt_svg.svg',
      photoUrl: 'assets/dummy_image/op3.png',
    ),
    VendorModel(
      id: '4',
      name: 'Portland Laundry Co',
      location: const LatLng(45.5050, -122.6650),
      rating: 4.6,
      reviews: 298,
      deliveryTime: '2-4 hours',
      distance: '0.9 miles',
      logoUrl: 'assets/icons/dry_clean.svg',
      photoUrl: 'assets/dummy_image/op4.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    markers.clear();
    for (var vendor in vendors) {
      markers.add(
        Marker(
          markerId: MarkerId(vendor.id),
          position: vendor.location,
          onTap: () {
            setState(() {
              selectedVendor = vendor;
            });
            _showVendorBottomSheet(vendor);
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(199.2),
        ),
      );
    }
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showVendorBottomSheet(VendorModel vendor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: AssetImage(vendor.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor.name,
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            vendor.rating.toString(),
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '(${vendor.reviews} reviews)',
                            style: GoogleFonts.manrope(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.access_time,
                  label: vendor.deliveryTime,
                ),
                SizedBox(width: 12.w),
                _buildInfoChip(icon: Icons.location_on, label: vendor.distance),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'View Details',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Select',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: Colors.black54),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onCameraMove: (p) => _currentCameraPosition = p.target,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24.h,
            right: 16.w,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () =>
                  mapController.animateCamera(CameraUpdate.newLatLng(_center)),
              child: Icon(Icons.my_location, color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class VendorModel {
  final String id, name, deliveryTime, distance, logoUrl, photoUrl;
  final LatLng location;
  final double rating;
  final int reviews;
  VendorModel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.deliveryTime,
    required this.distance,
    required this.logoUrl,
    required this.photoUrl,
  });
}
