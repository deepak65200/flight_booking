import 'package:flight_booking_app/widgets/common_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_details_provider.dart';


class FlightDetailsScreen extends StatelessWidget {
  final String flightId;
  const FlightDetailsScreen({super.key, required this.flightId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FlightDetailsProvider>();

    if (provider.flightDetails == null && !provider.isLoading) {
      provider.getFlightDetails(flightId);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Flight Details",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        surfaceTintColor: Colors.white,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.flightDetails == null
          ? const Center(child: Text("No details available"))
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _summaryCard(provider),
                  const SizedBox(height: 20),
                  _itinerarySection(provider),
                  const SizedBox(height: 16),
                  _baggageSection(provider),
                  const SizedBox(height: 16),
                  _fareSection(provider),
                  const SizedBox(height: 16),
                  _cancellationSection(provider),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: provider.isLoading || provider.flightDetails == null
          ? null
          : _bottomCTA(context),
    );
  }

  Widget _summaryCard(FlightDetailsProvider provider) {
    final details = provider.flightDetails!;
    final segment = details.itinerary!.segments!.first;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E88E5).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      details.airline?.code ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        details.airline?.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        segment.flightNumber ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha:0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _cityBlock(
                        segment.origin!.code!,
                        segment.departure!.scheduledTime!,
                        isWhite: true,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 2,
                                color: Colors.white.withValues(alpha:0.4),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha:0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.flight_takeoff,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      segment.duration ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            details.itinerary!.stops == 0
                                ? "Non-stop"
                                : "${details.itinerary!.stops} stop${details.itinerary!.stops! > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha:0.85),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _cityBlock(
                        segment.destination!.code!,
                        segment.arrival!.scheduledTime!,
                        isWhite: true,
                        align: CrossAxisAlignment.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cityBlock(String code, String time,
      {bool isWhite = false, CrossAxisAlignment align = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          code,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: isWhite ? Colors.white : const Color(0xFF1A1A1A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isWhite
                ? Colors.white.withValues(alpha:0.9)
                : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _itinerarySection(FlightDetailsProvider provider) {
    final segment = provider.flightDetails!.itinerary!.segments!.first;

    return _modernCard(
      icon: Icons.event_note_rounded,
      iconColor: const Color(0xFF1E88E5),
      title: 'Flight Information',
      child: Column(
        children: [
          _detailRow(
            icon: Icons.airplane_ticket_rounded,
            label: 'Flight Number',
            value: segment.flightNumber ?? 'N/A',
          ),
          const SizedBox(height: 16),
          _detailRow(
            icon: Icons.flight_rounded,
            label: 'Aircraft',
            value: provider.flightDetails!.aircraft?.model ?? 'N/A',
          ),
          const SizedBox(height: 16),
          _detailRow(
            icon: Icons.airline_seat_recline_extra_rounded,
            label: 'Cabin Class',
            value: segment.cabinClass ?? 'N/A',
          ),
          const SizedBox(height: 16),
          _detailRow(
            icon: Icons.straighten_rounded,
            label: 'Distance',
            value: segment.distance ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _baggageSection(FlightDetailsProvider provider) {
    final baggage = provider.flightDetails!.baggage!;

    return _modernCard(
      icon: Icons.luggage_rounded,
      iconColor: const Color(0xFFFF6B35),
      title: 'Baggage Allowance',
      child: Row(
        children: [
          Expanded(
            child: _baggageCard(
              icon: Icons.work_outline_rounded,
              label: 'Cabin Bag',
              value: baggage.cabin!.allowance!,
              color: const Color(0xFFFF6B35),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _baggageCard(
              icon: Icons.luggage_outlined,
              label: 'Check-in',
              value: baggage.checkin!.allowance!,
              color: const Color(0xFF9C27B0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _baggageCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha:0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fareSection(FlightDetailsProvider provider) {
    final fare = provider.flightDetails!.fare!.breakdown!;

    return _modernCard(
      icon: Icons.receipt_long_rounded,
      iconColor: const Color(0xFF4CAF50),
      title: 'Fare Breakdown',
      child: Column(
        children: [
          _fareRow('Base Fare', fare.baseFare ?? 0),
          const SizedBox(height: 12),
          _fareRow('Fuel Surcharge', fare.fuelSurcharge ?? 0),
          const SizedBox(height: 12),
          _fareRow('Airport Tax', fare.airportTax ?? 0),
          const SizedBox(height: 12),
          _fareRow('GST', fare.gst ?? 0),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withValues(alpha:0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  '₹${fare.total ?? 0}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cancellationSection(FlightDetailsProvider provider) {
    final policy = provider.flightDetails?.cancellation?.policy;
    if (policy == null) return const SizedBox.shrink();

    final isRefundable = policy.allowed ?? false;

    return _modernCard(
      icon: Icons.cancel_outlined,
      iconColor: isRefundable ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
      title: 'Cancellation Policy',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isRefundable
                  ? const Color(0xFF4CAF50).withValues(alpha:0.1)
                  : const Color(0xFFF44336).withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isRefundable
                    ? const Color(0xFF4CAF50).withValues(alpha:0.3)
                    : const Color(0xFFF44336).withValues(alpha:0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isRefundable ? Icons.check_circle : Icons.cancel,
                  size: 18,
                  color: isRefundable
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFF44336),
                ),
                const SizedBox(width: 8),
                Text(
                  isRefundable ? 'Refundable' : 'Non-refundable',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: isRefundable
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF44336),
                  ),
                ),
              ],
            ),
          ),
          if (policy.conditions != null && policy.conditions!.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...policy.conditions!.map(
                  (c) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666),
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: c.timeBeforeDeparture ?? '',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const TextSpan(text: ' - Fee: '),
                            TextSpan(
                              text: '₹${c.cancellationFee}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF44336),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: commonButton(
          padding: EdgeInsets.zero,
            context, onPressed: (){}, label: 'BOOK NOW')
      ),
    );
  }


  Widget _modernCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _fareRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '₹$value',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}