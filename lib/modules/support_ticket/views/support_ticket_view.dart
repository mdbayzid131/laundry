import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/themes/app_theme.dart';
import '../controllers/support_ticket_controller.dart';
import 'create_ticket_view.dart';

class SupportTicketView extends GetView<SupportTicketController> {
  const SupportTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Support Tickets',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.tickets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tickets.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () => controller.getTickets(),
          child: ListView.separated(
            padding: EdgeInsets.all(20.w),
            itemCount: controller.tickets.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final ticket = controller.tickets[index];
              return _buildTicketCard(ticket);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateTicketView()),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.confirmation_number_outlined, size: 80.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text(
            'No support tickets yet',
            style: GoogleFonts.manrope(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create a ticket if you need help',
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(ticket) {
    Color statusColor;
    switch (ticket.status?.toUpperCase()) {
      case 'OPEN':
        statusColor = Colors.blue;
        break;
      case 'IN_PROGRESS':
        statusColor = Colors.orange;
        break;
      case 'RESOLVED':
        statusColor = Colors.green;
        break;
      case 'CLOSED':
        statusColor = Colors.grey;
        break;
      default:
        statusColor = Colors.blue;
    }

    String formattedDate = '';
    if (ticket.createdAt != null) {
      final date = DateTime.parse(ticket.createdAt!);
      formattedDate = DateFormat('MMM dd, yyyy').format(date);
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ticket #${ticket.ticketNumber}',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  ticket.status ?? 'OPEN',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            ticket.subject ?? 'No Subject',
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff1A2530),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            ticket.description ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: Colors.black45,
                ),
              ),
              if (ticket.chatRooms?.isNotEmpty == true)
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.blue),
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.SUPPORT_TICKET_CHAT,
                      arguments: {
                        'roomId': ticket.chatRooms![0].id,
                        'ticketId': ticket.id,
                        'ticketNumber': ticket.ticketNumber,
                      },
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
