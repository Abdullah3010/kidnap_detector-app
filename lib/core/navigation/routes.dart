import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/navigation/routes_names.dart';
import 'package:kidnap_detection_app/modules/camera_view/view/grid_camera_view.dart';
import 'package:kidnap_detection_app/modules/camera_view/view/kidnap_camera_view.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/view/report_details_screen.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/view/report_list_screen.dart';
import 'package:modular_interfaces/src/route/modular_arguments.dart' show ModularArguments;

import '../../modules/camera_view/widgets/video_widget.dart';


List<ModularRoute> modularRoutes = <ChildRoute<dynamic>>[
  ChildRoute<dynamic>(
    AppRoutes.routes.initScreen,
    child: (_, ModularArguments args) => GridCameraView(),
    transition: TransitionType.fadeIn,
  ),
  ChildRoute<dynamic>(
    AppRoutes.routes.gridCamerView,
    child: (_, ModularArguments args) => GridCameraView(),
    transition: TransitionType.fadeIn,
  ),
  ChildRoute<dynamic>(
    AppRoutes.routes.kidnapCamerView,
    child: (_, ModularArguments args) => KidnapCameraView(),
    transition: TransitionType.fadeIn,
  ),
  ChildRoute<dynamic>(
    AppRoutes.routes.reportList,
    child: (_, ModularArguments args) => ReportListScrren(),
    transition: TransitionType.fadeIn,
  ),
  ChildRoute<dynamic>(
    AppRoutes.routes.reportDetails,
    child: (_, ModularArguments args) => ReportDetailsScreen(),
    transition: TransitionType.fadeIn,
  ),
];
