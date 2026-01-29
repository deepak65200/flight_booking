import 'package:flight_booking_app/screen/search_results_screen.dart';
import 'package:flight_booking_app/widgets/common_method.dart';
import 'package:flight_booking_app/widgets/dotted_border_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/common_helper.dart';
import '../helpers/navHelper.dart';
import '../providers/flight_results_provider.dart';
import '../providers/flight_search_provider.dart';
import '../utils/color_res.dart';
import '../widgets/common_class.dart';
import '../widgets/common_filter_tabs.dart';

class FlightSearchScreen extends StatelessWidget {
  const FlightSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FlightSearchProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.airports.isEmpty) {
        provider.getAirports();
      }
    });

    return Scaffold(
      appBar: const CommonHeaderBar(title: "Flight Search"),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              commonFilterTabs(
                tabs: const ['One way', 'Roundtrip', 'Multicity'],
                selectedTab: _tripTypeToLabel(provider.tripType),
                onTabSelected: (value) {
                  provider.setTripType(
                    value == 'Roundtrip'
                        ? TripType.roundTrip
                        : value == 'Multicity'
                        ? TripType.multiCity
                        : TripType.oneWay,
                  );
                },
              ),

              const SizedBox(height: 16),

              if (!provider.isMultiCity) ...[
                _buildFromToRow(context, provider),
                const SizedBox(height: 16),
                _buildDatesRow(context, provider),
              ],

              if (provider.isMultiCity) ...[
                _buildMultiCityLayout(context, provider),
              ],

              const SizedBox(height: 16),

              _buildTravellerClass(context, provider),

              const SizedBox(height: 20),
              const Text(
                'SPECIAL FARES',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _fareCard(
                      'Student',
                      'Extra discounts/baggage',
                      provider.isStudent,
                          () => provider.toggleSpecialFare('student'),
                    ),
                    _fareCard(
                      'Senior Citizen',
                      'Up to ₹ 600 off',
                      provider.isSeniorCitizen,
                          () => provider.toggleSpecialFare('senior'),
                    ),
                    _fareCard(
                      'Armed Forces',
                      'Up to ₹ 600 off',
                      provider.isArmedForces,
                          () => provider.toggleSpecialFare('armed'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: provider.zeroCancellation,
                      onChanged: (_) => provider.toggleZeroCancellation(),
                      activeColor: const Color(0xFF1E88E5),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Add Zero Cancellation',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.info_outline,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Get 100% refund on cancellation',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Z',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              commonButton(
                context,
                padding: EdgeInsets.zero,
                onPressed: () {
                  debugPrint('>>>>>${provider.isValid}');
                  if (!provider.validateAndShowError()) return;

                  context
                      .read<FlightResultsProvider>()
                      .searchFlights(
                    provider.buildSearchRequest(),
                  ).then((res) {
                    // if (res.isSuccess && context.mounted) {
                    //   navPush(
                    //     context: context,
                    //     widget: const FlightResultsScreen(),
                    //   );
                    // }
                    if(!context.mounted)return;
                    navPush(
                      context: context,
                      widget: const FlightResultsScreen(),
                    );
                  });
                },
                label: 'SEARCH FLIGHTS',
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildFromToRow(BuildContext context,
      FlightSearchProvider provider,) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // FROM - TO Row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: () {
                      // Open location picker for FROM
                      _openLocationPicker(context, provider, isOrigin: true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'FROM',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                provider.originController.text.isEmpty
                                    ? ''
                                    : _getCityName(
                                    provider.originController.text),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                provider.originController.text.isEmpty
                                    ? ''
                                    : _getCityCode(
                                    provider.originController.text),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            provider.originController.text.isEmpty
                                ? ''
                                : _getAirportName(provider.originController
                                .text),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: () {
                      // Open location picker for TO
                      _openLocationPicker(context, provider, isOrigin: false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TO',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                provider.destinationController.text.isEmpty
                                    ? ''
                                    : _getCityName(
                                    provider.destinationController.text),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                provider.destinationController.text.isEmpty
                                    ? ''
                                    : _getCityCode(
                                    provider.destinationController.text),
                                style: TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            provider.destinationController.text.isEmpty
                                ? ''
                                : _getAirportName(provider.destinationController
                                .text),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Center Swap Button
        Positioned(
          child: _swapButton(provider),
        ),
      ],
    );
  }
  static Widget _swapButton(FlightSearchProvider provider) {
    return InkWell(
      onTap: () {
        provider.swapLocations();
      },
      child: TweenAnimationBuilder<double>(
        key: ValueKey(provider.swapTurns),
        tween: Tween(begin: 0, end: provider.swapTurns),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) {
          return Transform.rotate(
            angle: value * 6.28318, // Convert turns to radians (2π)
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          ),
          child: const Icon(
            Icons.swap_horiz,
            size: 22,
            color: Color(0xFF1E88E5),
          ),
        ),
      ),
    );
  }

  static Widget _buildDatesRow(BuildContext context,
      FlightSearchProvider provider) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final picked = await _pickDate(context);
              if (picked != null) {
                provider.setDepartureDate(picked);

              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DEPARTURE DATE',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        provider.departureDate != null
                            ? '${provider.departureDate!.day} ${_month(
                            provider.departureDate!.month)}'
                            : '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        provider.departureDate != null
                            ? '${_dayName(
                            provider.departureDate!.weekday)}, ${provider
                            .departureDate!.year}'
                            : '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: provider.isRoundTrip
              ? InkWell(
            borderRadius: BorderRadius.circular(12),
            // onTap: () async {
            //   final picked = await _pickDate(context);
            //   if (picked != null) {
            //     provider.setReturnDate(picked);
            //   }
            // },

            onTap: () async {
              if (provider.departureDate == null) {
                ToastUtils.showToast('Please select departure date first');
                return;
              }

              final picked = await _pickDate(
                context,
                firstDate: provider.departureDate,
              );

              if (picked != null) {
                provider.setReturnDate(picked);
              }
            },

            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RETURN',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        provider.returnDate != null
                            ? '${provider.returnDate!.day} ${_month(
                            provider.returnDate!.month)}'
                            : '30 Jan',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        provider.returnDate != null
                            ? '${_dayName(
                            provider.returnDate!.weekday)}, ${provider
                            .returnDate!.year}'
                            : 'Thu, 2026',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
              : InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              provider.setTripType(TripType.roundTrip);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    '+ ADD RETURN DATE',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF1E88E5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Save more on round trips!',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildMultiCityLayout(BuildContext context,
      FlightSearchProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FROM',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      _openLocationPicker(context, provider, isOrigin: true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.originController.text.isEmpty
                                ? ''
                                : _getCityCode(provider.originController.text),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            provider.originController.text.isEmpty
                                ? ''
                                : _getCityName(provider.originController.text),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TO',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      _openLocationPicker(context, provider, isOrigin: false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.destinationController.text.isEmpty
                                ? 'TO'
                                : _getCityCode(provider.destinationController
                                .text),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: provider.destinationController.text.isEmpty
                                  ? const Color(0xFF1E88E5)
                                  : Colors.black,
                            ),
                          ),
                          if (provider.destinationController.text
                              .isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              _getCityName(provider.destinationController.text),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DATE',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                   // onTap: () async {
                      // final picked = await _pickDate(context);
                      // if (picked != null) {
                      //   provider.departureDate = picked;
                      // }

                   // },
                    onTap: () async {
                      final picked = await _pickDate(context);
                      if (picked != null) {
                        provider.departureDate = picked;
                        provider.setDepartureDate(picked);
                      }
                    },

                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.departureDate != null
                                ? '${provider.departureDate!.day} ${_month(
                                provider.departureDate!.month)}'
                                : '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            provider.departureDate != null
                                ? _dayName(provider.departureDate!.weekday)
                                : '',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildAddCityButton(),
      ],
    );
  }

  static Widget _buildTravellerClass(BuildContext context,
      FlightSearchProvider provider) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TRAVELLER & CLASS',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            Row(
              children: [
                Text(
                  '${provider.travellers}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  ', ${provider.travelClass}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _fareCard(String title,
      String subtitle,
      bool selected,
      VoidCallback onTap,) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xFF1E88E5) : Colors.grey.shade300,
            width: selected ? 1.2 : 1,
          ),
          color: selected ? const Color(0xFFE3F2FD) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildAddCityButton() {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: DottedBorderContainer(
        borderColor: Color(0xFF1E88E5),
          child: Center(
            child: Text(
                    '+ ADD CITY',
                style: TextStyle(
                  color: Color(0xFF1E88E5),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
          )),
    );
  }

  static Future<DateTime?> _pickDate(
      BuildContext context, {
        DateTime? firstDate,
      }) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: firstDate ?? now,
      firstDate: firstDate ?? now,
      lastDate: DateTime(now.year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E88E5),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static String _month(int m) =>
      [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ][m - 1];

  static String _dayName(int d) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d - 1];

  static String _tripTypeToLabel(TripType type) {
    switch (type) {
      case TripType.roundTrip:
        return 'Roundtrip';
      case TripType.multiCity:
        return 'Multicity';
      case TripType.oneWay:
        return 'One way';
    }
  }

  static String _getCityName(String location) {
    final parts = location.trim().split(' ');
    return parts.isNotEmpty ? parts[0] : location;
  }

  static String _getCityCode(String location) {
    final parts = location.trim().split(' ');
    return parts.length > 1 ? parts[1] : '';
  }

  static String _getAirportName(String location) {
    final code = _getCityCode(location);
    final airportMap = {
      'DEL': 'Delhi Airport',
      'BOM': 'Chhatrapati Shivaji Internatio...',
      'BLR': 'Kempegowda International Airport',
      'MAA': 'Chennai International Airport',
      'CCU': 'Netaji Subhas Chandra Bose Airport',
      'HYD': 'Rajiv Gandhi International Airport',
    };
    return airportMap[code] ?? 'Airport';
  }

  static void _openLocationPicker(
      BuildContext context,
      FlightSearchProvider provider, {
        required bool isOrigin,
      }) {
    final TextEditingController searchCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filteredAirports = provider.airports.where((a) {
              final q = searchCtrl.text.toLowerCase();
              return a.city!.toLowerCase().contains(q) ||
                  a.code!.toLowerCase().contains(q) ||
                  a.name!.toLowerCase().contains(q);
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isOrigin ? 'Select Origin' : 'Select Destination',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: searchCtrl,
                    autofocus: true,
                    onChanged: (_) => setModalState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search city or airport',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredAirports.length,
                      itemBuilder: (_, i) {
                        final airport = filteredAirports[i];
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (isOrigin) {
                              provider.setOrigin(airport);
                            } else {
                              provider.setDestination(airport);
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade100,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${airport.city} (${airport.code})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  airport.name ?? '',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

