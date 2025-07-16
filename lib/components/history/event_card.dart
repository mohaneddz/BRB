import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:brb/components/ui/toast.dart'; // <-- Add this import

class EventCard extends StatefulWidget {
  final String coordinates;
  final String location;
  final DateTime? dateTime;

  const EventCard({
    super.key,
    this.coordinates = '38.45651 - 8.1548',
    this.location = 'Sidi Abdellah',
    this.dateTime,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  OverlayEntry? _toastEntry;

  void _showToast(String message, ToastType type) {
    _toastEntry?.remove();
    _toastEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 24,
        left: 0,
        right: 0,
        child: Toast(
          message: message,
          type: type,
          onDismissed: () {
            _toastEntry?.remove();
            _toastEntry = null;
          },
        ),
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_toastEntry!);
  }

  Future<void> _openMap() async {
    try {
      final coords = widget.coordinates.split(' - ');
      if (coords.length != 2) {
        if (!mounted) return;
        _showToast('Invalid coordinates', ToastType.error);
        return;
      }

      final lat = coords[0].trim();
      final lng = coords[1].trim();

      // Validate coordinates
      final double? latitude = double.tryParse(lat);
      final double? longitude = double.tryParse(lng);

      if (latitude == null || longitude == null) {
        if (!mounted) return;
        _showToast('Invalid coordinate format', ToastType.error);
        return;
      }

      bool launched = false;

      if (Platform.isAndroid) {
        final googleMapsUrl = 'google.navigation:q=$lat,$lng';
        if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
          await launchUrl(
            Uri.parse(googleMapsUrl),
            mode: LaunchMode.externalApplication,
          );
          launched = true;
        } else {
          final geoUrl =
              'geo:$lat,$lng?q=$lat,$lng(${Uri.encodeComponent(widget.location)})';
          if (await canLaunchUrl(Uri.parse(geoUrl))) {
            await launchUrl(
              Uri.parse(geoUrl),
              mode: LaunchMode.externalApplication,
            );
            launched = true;
          }
        }
      } else if (Platform.isIOS) {
        final googleMapsUrl = 'comgooglemaps://?q=$lat,$lng';
        if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
          await launchUrl(
            Uri.parse(googleMapsUrl),
            mode: LaunchMode.externalApplication,
          );
          launched = true;
        } else {
          final appleMapsUrl = 'http://maps.apple.com/?q=$lat,$lng';
          if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
            await launchUrl(
              Uri.parse(appleMapsUrl),
              mode: LaunchMode.externalApplication,
            );
            launched = true;
          }
        }
      }

      if (!launched) {
        final webUrl =
            'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
        final uri = Uri.parse(webUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          launched = true;
        }
      }

      if (!launched && mounted) {
        _showToast('Could not open any map application.', ToastType.warning);
      }
    } catch (e) {
      if (mounted) {
        _showToast('Error opening map: $e', ToastType.error);
      }
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      _showToast('$label copied!', ToastType.info);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        border: Border.all(color: Colors.redAccent, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _openMap,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.redAccent, width: 1.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Use Flexible to avoid overflow
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Coordinates : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () => _copyToClipboard(
                              widget.coordinates,
                              'Coordinates',
                            ),
                            child: Text(
                              widget.coordinates,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Location : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () =>
                                _copyToClipboard(widget.location, 'Location'),
                            child: Text(
                              widget.location,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Time : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${_formatDate(widget.dateTime ?? DateTime(2024, 12, 12, 16, 46))} | ${_formatTime(widget.dateTime ?? DateTime(2024, 12, 12, 16, 46))}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    // Example: 12 Dec 2024
    return '${dt.day.toString().padLeft(2, '0')} '
        '${_monthName(dt.month)} '
        '${dt.year}';
  }

  String _formatTime(DateTime dt) {
    // Example: 04:46 PM
    final hour = dt.hour > 12
        ? dt.hour - 12
        : dt.hour == 0
        ? 12
        : dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }
}
