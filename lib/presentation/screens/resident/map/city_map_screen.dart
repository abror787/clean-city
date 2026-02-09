import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class CityMapScreen extends StatelessWidget {
  const CityMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Flutter Map
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(41.2995, 69.2401), // Tashkent
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.clean_city',
              ),
              MarkerLayer(
                markers: [
                  _buildMapMarker(
                    context, 
                    const LatLng(41.3111, 69.2401), 
                    AppColors.reported,
                  ),
                  _buildMapMarker(
                    context, 
                    const LatLng(41.2995, 69.2801), 
                    AppColors.inProgress,
                  ),
                  _buildMapMarker(
                    context, 
                    const LatLng(41.2850, 69.2100), 
                    AppColors.cleaned,
                  ),
                ],
              ),
            ],
          ),
          
          // Filter Chips
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Все', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Новые', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('В работе', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Выполнено', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Marker _buildMapMarker(BuildContext context, LatLng point, Color color) {
    return Marker(
      point: point,
      width: 40,
      height: 40,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.reportDetails);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 4),
            ],
          ),
          child: Icon(Icons.location_on, color: color, size: 28),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: isSelected ? AppColors.primary : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
