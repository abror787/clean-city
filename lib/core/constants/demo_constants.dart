import '../network/waste_event/waste_event_models.dart';
import '../network/driver/driver_models.dart';

const bool kDemoMode = true;

class DemoAccounts {
  static const residentEmail = 'resident@demo.com';
  static const residentPassword = 'demo123';
  static const driverEmail = 'driver@demo.com';
  static const driverPassword = 'demo123';
}

class DemoData {
  static const double tashkentLat = 41.29;
  static const double tashkentLng = 69.24;

  static List<PublicWasteEventResponse> get wasteEvents => [
        PublicWasteEventResponse(
          publicId: 'demo-event-1',
          category: 'garbage',
          description: 'Overflowing public trash bin near metro station',
          latitude: 41.295,
          longitude: 69.235,
          status: 'pending',
          reportedAt: DateTime.now()
              .subtract(const Duration(hours: 2))
              .toIso8601String(),
          imageUrl: null,
        ),
        PublicWasteEventResponse(
          publicId: 'demo-event-2',
          category: 'construction',
          description: 'Construction debris dumped on sidewalk',
          latitude: 41.285,
          longitude: 69.245,
          status: 'pending',
          reportedAt: DateTime.now()
              .subtract(const Duration(hours: 5))
              .toIso8601String(),
          imageUrl: null,
        ),
        PublicWasteEventResponse(
          publicId: 'demo-event-3',
          category: 'illegal_dumping',
          description: 'Household waste illegally dumped in empty lot',
          latitude: 41.310,
          longitude: 69.260,
          status: 'in_progress',
          reportedAt: DateTime.now()
              .subtract(const Duration(days: 1))
              .toIso8601String(),
          imageUrl: null,
        ),
        PublicWasteEventResponse(
          publicId: 'demo-event-4',
          category: 'street_cleaning',
          description: 'Street needs cleaning after market day',
          latitude: 41.280,
          longitude: 69.230,
          status: 'in_progress',
          reportedAt: DateTime.now()
              .subtract(const Duration(days: 2))
              .toIso8601String(),
          imageUrl: null,
        ),
        PublicWasteEventResponse(
          publicId: 'demo-event-5',
          category: 'graffiti',
          description: 'Graffiti on public wall needs removal',
          latitude: 41.305,
          longitude: 69.250,
          status: 'completed',
          reportedAt: DateTime.now()
              .subtract(const Duration(days: 3))
              .toIso8601String(),
          imageUrl: null,
        ),
        PublicWasteEventResponse(
          publicId: 'demo-event-6',
          category: 'garbage',
          description: 'Missed collection from residential area',
          latitude: 41.290,
          longitude: 69.220,
          status: 'completed',
          reportedAt: DateTime.now()
              .subtract(const Duration(days: 4))
              .toIso8601String(),
          imageUrl: null,
        ),
      ];

  static List<DriverTaskSummary> get driverTasks => [
        DriverTaskSummary(
          taskId: 'task-1',
          addressSummary: 'Garbage collection - Chorsu Market area',
          priority: 'HIGH',
          status: 'ASSIGNED',
        ),
        DriverTaskSummary(
          taskId: 'task-2',
          addressSummary: 'Construction debris removal - Mirzo Ulugbek',
          priority: 'NORMAL',
          status: 'ASSIGNED',
        ),
        DriverTaskSummary(
          taskId: 'task-3',
          addressSummary: 'Illegal dumping cleanup - Yunusabad district',
          priority: 'HIGH',
          status: 'IN_PROGRESS',
        ),
        DriverTaskSummary(
          taskId: 'task-4',
          addressSummary: 'Regular collection - City center',
          priority: 'NORMAL',
          status: 'ASSIGNED',
        ),
      ];

  static DriverTaskDetail getTaskDetail(String taskId) {
    final taskDetails = {
      'task-1': DriverTaskDetail(
        taskId: 'task-1',
        description:
            'Overflowing trash bins at Chorsu Bazaar. Multiple bins need emptying urgently.',
        latitude: 41.295,
        longitude: 69.235,
        status: 'ASSIGNED',
        reportedAt:
            DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
        mediaUrls: [],
        mediaTokens: [],
        reporterNote: 'Bins overflowed after weekend market',
      ),
      'task-2': DriverTaskDetail(
        taskId: 'task-2',
        description:
            'Construction materials and debris blocking sidewalk on Mirzo Ulugbek street.',
        latitude: 41.285,
        longitude: 69.245,
        status: 'ASSIGNED',
        reportedAt:
            DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
        mediaUrls: [],
        mediaTokens: [],
        reporterNote: 'Requires truck for large debris',
      ),
      'task-3': DriverTaskDetail(
        taskId: 'task-3',
        description:
            'Illegal dumping of household waste in empty lot near school.',
        latitude: 41.310,
        longitude: 69.260,
        status: 'IN_PROGRESS',
        reportedAt:
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        mediaUrls: [],
        mediaTokens: [],
        reporterNote: 'Urgent - near school playground',
      ),
      'task-4': DriverTaskDetail(
        taskId: 'task-4',
        description:
            'Weekly scheduled collection for city center commercial district.',
        latitude: 41.290,
        longitude: 69.220,
        status: 'ASSIGNED',
        reportedAt: DateTime.now()
            .subtract(const Duration(hours: 12))
            .toIso8601String(),
        mediaUrls: [],
        mediaTokens: [],
        reporterNote: 'Regular scheduled route',
      ),
    };
    return taskDetails[taskId] ?? taskDetails['task-1']!;
  }

  static int _reportCounter = 100;

  static PublicWasteEventResponse createReportedEvent({
    required String category,
    required String description,
    required double latitude,
    required double longitude,
  }) {
    _reportCounter++;
    return PublicWasteEventResponse(
      publicId: 'demo-event-$_reportCounter',
      category: category,
      description: description,
      latitude: latitude,
      longitude: longitude,
      status: 'pending',
      reportedAt: DateTime.now().toIso8601String(),
      imageUrl: null,
    );
  }
}
