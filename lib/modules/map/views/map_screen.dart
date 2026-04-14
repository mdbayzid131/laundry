import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:laundry/modules/home/controllers/home_controller.dart';
import 'package:laundry/data/models/storage_services_model.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/routes/app_pages.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final HomeController homeController = Get.find<HomeController>();
  late GoogleMapController mapController;
  Set<Marker> markers = <Marker>{};

  static const LatLng _center = LatLng(45.5152, -122.6784);
  LatLng _currentCameraPosition = _center;
  final TextEditingController _searchController = TextEditingController();
  bool _isMapCreated = false;

  static const String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    _createMarkers();
    ever(homeController.services, (_) => _createMarkers());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _createMarkers() {
    markers.clear();

    // Group by storeId to avoid duplicate markers for the same store
    final Map<String, StoreServiceData> uniqueStores = {};
    for (var serviceItem in homeController.services) {
      if (serviceItem.store != null && serviceItem.store?.id != null) {
        if (!uniqueStores.containsKey(serviceItem.store!.id)) {
          uniqueStores[serviceItem.store!.id!] = serviceItem;
        }
      }
    }

    if (uniqueStores.isNotEmpty && homeController.lat.value != 0.0) {
      _currentCameraPosition = LatLng(
        homeController.lat.value,
        homeController.lng.value,
      );
    }

    for (var serviceItem in uniqueStores.values) {
      final store = serviceItem.store;
      if (store == null || store.lat == null || store.lng == null) continue;

      markers.add(
        Marker(
          markerId: MarkerId(store.id!),
          position: LatLng(store.lat!, store.lng!),
          onTap: () {
            _showVendorBottomSheet(serviceItem);
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(199.2),
        ),
      );
    }
    setState(() {});

    // If map is already created, center on markers
    if (uniqueStores.isNotEmpty && markers.isNotEmpty && _isMapCreated) {
      _fitAllMarkers();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _isMapCreated = true;

    if (markers.isNotEmpty) {
      _fitAllMarkers();
    } else if (homeController.lat.value != 0.0) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(homeController.lat.value, homeController.lng.value),
          14.0,
        ),
      );
    }
  }

  void _fitAllMarkers() {
    if (markers.isEmpty) return;

    double? minLat, maxLat, minLng, maxLng;

    for (var marker in markers) {
      if (minLat == null || marker.position.latitude < minLat)
        minLat = marker.position.latitude;
      if (maxLat == null || marker.position.latitude > maxLat)
        maxLat = marker.position.latitude;
      if (minLng == null || marker.position.longitude < minLng)
        minLng = marker.position.longitude;
      if (maxLng == null || marker.position.longitude > maxLng)
        maxLng = marker.position.longitude;
    }

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat!, minLng!),
          northeast: LatLng(maxLat!, maxLng!),
        ),
        80.w,
      ),
    );
  }

  void _onSearch(String value) {
    if (value.isEmpty) return;

    final query = value.toLowerCase();
    StoreServiceData? found;

    for (var serviceItem in homeController.services) {
      if (serviceItem.store?.name?.toLowerCase().contains(query) ?? false) {
        found = serviceItem;
        break;
      }
    }

    if (found != null && found.store?.lat != null && found.store?.lng != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(found.store!.lat!, found.store!.lng!),
          16.0,
        ),
      );
      _showVendorBottomSheet(found);
    }
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 50.h,
      left: 20.w,
      right: 20.w,
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onSubmitted: _onSearch,
          decoration: InputDecoration(
            hintText: 'Search LaundryLink....',
            hintStyle: GoogleFonts.manrope(
              fontSize: 16.sp,
              color: Colors.black38,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.black38, size: 22.sp),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 15.h,
            ),
          ),
        ),
      ),
    );
  }

  void _showVendorBottomSheet(StoreServiceData vendor) {
    final store = vendor.store;
    final String photoUrl = store?.logo ?? store?.banner ?? '';
    final String name = store?.name ?? 'Unknown Store';
    final String rating = vendor.avgRating?.toStringAsFixed(1) ?? '4.8';
    final String reviews = vendor.totalReviews?.toString() ?? '5k+';
    final String distance = vendor.distanceMile != null
        ? '${vendor.distanceMile!.toStringAsFixed(1)} mi'
        : 'N/A';

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
                    color: Colors.black12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: photoUrl.isNotEmpty
                        ? Image.network(
                            photoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Image.asset(ImagePaths.op1, fit: BoxFit.cover),
                          )
                        : Image.asset(ImagePaths.op1, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
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
                            rating,
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '($reviews reviews)',
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
                _buildInfoChip(icon: Icons.access_time, label: '30 mins'),
                SizedBox(width: 12.w),
                _buildInfoChip(icon: Icons.location_on, label: distance),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.toNamed(
                        AppRoutes.LAUNDRY_DETAILS,
                        arguments: {
                          'storeId': store?.id,
                          'operatorId': store?.operatorId,
                        },
                      );
                    },
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
                    onPressed: () {
                      Navigator.pop(context);
                      Get.toNamed(
                        AppRoutes.LAUNDRY_DETAILS,
                        arguments: {
                          'storeId': store?.id,
                          'operatorId': store?.operatorId,
                        },
                      );
                    },
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
            padding: EdgeInsets.only(top: 120.h, bottom: 200.h),
            initialCameraPosition: CameraPosition(target: _center, zoom: 12.0),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
            onCameraMove: (p) => _currentCameraPosition = p.target,
            minMaxZoomPreference: const MinMaxZoomPreference(2, 21),
            compassEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),
          _buildSearchBar(),
          Positioned(
            bottom: 120.h,
            right: 16.w,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                if (homeController.lat.value != 0.0) {
                  mapController.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(
                        homeController.lat.value,
                        homeController.lng.value,
                      ),
                    ),
                  );
                } else if (markers.isNotEmpty) {
                  _fitAllMarkers();
                } else {
                  mapController.animateCamera(CameraUpdate.newLatLng(_center));
                }
              },
              child: Icon(Icons.my_location, color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
