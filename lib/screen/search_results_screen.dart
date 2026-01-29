import 'package:flight_booking_app/providers/flight_search_provider.dart';
import 'package:flight_booking_app/screen/flight_details_screen.dart';
import 'package:flight_booking_app/widgets/common_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/response/flight.dart';
import '../providers/flight_results_provider.dart';
import '../utils/color_res.dart';

class FlightResultsScreen extends StatelessWidget {
  const FlightResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<FlightSearchProvider,FlightResultsProvider>(
      builder: (BuildContext context, flightSP,provider, Widget? child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            title: const Text(
              'Available Flights',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1A1A1A),
            surfaceTintColor: Colors.white,
            actions: [
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.filter_list_rounded),
                    if (provider.hasActiveFilters)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF44336),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => _showFilterSheet(context, provider),
              ),
              IconButton(
                icon: const Icon(Icons.sort_rounded),
                onPressed: () => _showSortSheet(context, provider),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                if (provider.searchParams != null)
                  _searchSummaryBar(provider),

                if (!provider.isLoading && provider.flightList.isNotEmpty)
                  _resultsHeader(provider),

                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.flightList.isEmpty
                      ? _emptyState()
                      : RefreshIndicator(
                    color: ColorRes.primaryDark,
                    onRefresh: () async {
                      if (provider.searchParams != null) {
                        await provider.searchFlights(
                          flightSP.buildSearchRequest()
                          ,
                        );
                      }
                    },
                    child: ListView.builder(
                      itemCount: provider.flightList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) {
                        final flight = provider.flightList[index];
                        return FlightCard(
                          flight: flight,
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchSummaryBar(FlightResultsProvider provider) {
    final params = provider.searchParams!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flight_takeoff,
                  color: Color(0xFF1E88E5), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${params.origin} → ${params.destination}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E88E5).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatDate(params.departureDate??''),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E88E5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _infoTag(
                icon: Icons.person_outline,
                text:
                '${params.passengers} Passenger${params.passengers! > 1 ? 's' : ''}',
              ),
              const SizedBox(width: 8),
              _infoTag(
                icon: Icons.airline_seat_recline_extra,
                text: params.travelClass ?? '',
              ),
              if (params.returnDate != null) ...[
                const SizedBox(width: 8),
                _infoTag(
                  icon: Icons.sync_alt,
                  text: 'Round Trip',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTag({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _resultsHeader(FlightResultsProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${provider.flightList.length} flight${provider.flightList.length > 1 ? 's' : ''} found',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
          if (provider.hasActiveFilters)
            TextButton.icon(
              onPressed: provider.clearFilters,
              icon: const Icon(Icons.clear, size: 16),
              label: const Text('Clear filters'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFF44336),
              ),
            ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flight_takeoff_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No flights found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  void _showSortSheet(
      BuildContext context, FlightResultsProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort by',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _sortOption(
                context,
                icon: Icons.currency_rupee,
                title: 'Price: Low to High',
                onTap: () {
                  provider.sortByPrice(ascending: true);
                  Navigator.pop(context);
                },
              ),
              _sortOption(
                context,
                icon: Icons.currency_rupee,
                title: 'Price: High to Low',
                onTap: () {
                  provider.sortByPrice(ascending: false);
                  Navigator.pop(context);
                },
              ),
              _sortOption(
                context,
                icon: Icons.schedule,
                title: 'Duration: Shortest',
                onTap: () {
                  provider.sortByDuration();
                  Navigator.pop(context);
                },
              ),
              _sortOption(
                context,
                icon: Icons.flight_takeoff,
                title: 'Departure: Earliest',
                onTap: () {
                  provider.sortByDeparture();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sortOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, size:22,color: const Color(0xFF1E88E5)),
      title: Text(title,style: TextStyle(fontSize: 12),),
      onTap: onTap,
    );
  }

  void _showFilterSheet(
      BuildContext context, FlightResultsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (provider.hasActiveFilters)
                          TextButton(
                            onPressed: () {
                              provider.clearFilters();
                              setModalState(() {}); // rebuild sheet
                            },
                            child: const Text(
                              'Clear',
                              style: TextStyle(color: Color(0xFFF44336)),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: CheckboxListTile(
                        value: provider.nonStopOnly,
                        onChanged: (value) {
                          provider.setNonStop(value ?? false);
                          setModalState(() {});
                        },
                        title: const Text(
                          'Non-stop flights only',
                          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
                        ),
                        subtitle: const Text(
                          'Show flights with no layovers',
                          style: TextStyle(fontSize: 12),
                        ),
                        activeColor: const Color(0xFF1E88E5),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),

                    const SizedBox(height: 20),
                    commonButton(context,
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context), label: 'Apply Filters')
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    const months = [
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
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}

class FlightCard extends StatelessWidget {
  final FlightModel flight;
  final int index;

  const FlightCard({
    super.key,
    required this.flight,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    FlightDetailsScreen(flightId: flight.id ?? ''),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E88E5).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          flight.airlineCode,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E88E5),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        flight.airlineName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    if (index == 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'BEST DEAL',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4CAF50),
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    // Departure
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flight.departureTime,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            flight.departureCode,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            flight.duration ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            flight.stops == 0
                                ? 'Non-stop'
                                : '${flight.stops} stop${flight.stops! > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: flight.stops == 0
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF9800),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrival
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            flight.arrivalTime,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            flight.arrivalCode,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Divider(color: Colors.grey.shade200, height: 1),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Info Chips
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          if (flight.cabinClass.isNotEmpty)
                            _infoChip(
                              icon: Icons.airline_seat_recline_extra,
                              label: flight.cabinClass,
                            ),
                          if (flight.isRefundable)
                            _infoChip(
                              icon: Icons.check_circle,
                              label: 'Refundable',
                              color: const Color(0xFF4CAF50),
                            ),
                        ],
                      ),
                    ),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${flight.totalPrice}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E88E5),
                          ),
                        ),
                        Text(
                          'per person',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
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

  Widget _infoChip({
    required IconData icon,
    required String label,
    Color? color,
  }) {
    final chipColor = color ?? Colors.grey.shade600;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: chipColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: chipColor,
            ),
          ),
        ],
      ),
    );
  }
}

