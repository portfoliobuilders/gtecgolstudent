import 'package:flutter/material.dart';
import 'package:gtec/models/student_model.dart';
import 'package:gtec/provider/student_provider.dart';
import 'package:gtec/screens/student/studentlogin.dart';
import 'package:gtec/screens/student/widgets/assignmentscreen.dart';
import 'package:gtec/screens/student/widgets/user_quiz.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// I'll first provide the StudentLMSHomePage and SplitView classes
// Rest of the classes will follow - this will be a very long response

class StudentLMSHomePage extends StatelessWidget {
  const StudentLMSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              height: 35,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/golblack.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/gtecwhite.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Consumer<StudentAuthProvider>(
            builder: (context, studentProvider, child) {
              final hasNewNotifications =
                  studentProvider.notification.isNotEmpty;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: hasNewNotifications
                      ? Colors.blue.shade50
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF0098DA),
                        size: 24,
                      ),
                      onPressed: () => _showNotificationPopup(
                          context, studentProvider.notification),
                      tooltip: 'Notifications',
                    ),
                    if (hasNewNotifications)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: PopupMenuButton<String>(
              offset: const Offset(0, 45),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.person_outline,
                    color: Colors.white, size: 22),
              ),
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (String value) async {
                if (value == 'Logout') {
                  await Provider.of<StudentAuthProvider>(context, listen: false)
                      .Studentlogout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserLoginScreen()),
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.logout_rounded,
                            color: Colors.red.shade400, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: const SplitView(),
      ),
    );
  }

  void _showNotificationPopup(
      BuildContext context, List<dynamic> notifications) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.blue.shade600,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: notifications.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No new notifications",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.circle_notifications,
                                      color: Colors.blue.shade700,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notifications[index]['title'] ??
                                              "No Title",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notifications[index]['message'] ??
                                              "No Message",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
}

class SplitView extends StatefulWidget {
  const SplitView({super.key});

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView>
    with SingleTickerProviderStateMixin {
  StudentModel? selectedCourse;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    Widget buildCoursesList() {
      return FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.2, 0),
            end: Offset.zero,
          ).animate(_animation),
          child: Container(
            width: 300,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CoursesList(
              onCourseSelected: (course) {
                setState(() {
                  selectedCourse = course;
                });
                if (isMobile) {
                  Navigator.of(context).pop();
                }
              },
              selectedCourse: selectedCourse,
            ),
          ),
        ),
      );
    }

    Widget buildMainContent() {
      return Expanded(
        child: FadeTransition(
          opacity: _animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.2, 0),
              end: Offset.zero,
            ).animate(_animation),
            child: Column(
              children: [
                if (selectedCourse != null)
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade100.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: LiveSessionsList(course: selectedCourse!),
                  ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade100.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: selectedCourse == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.school_outlined,
                                    size: 48,
                                    color: Colors.blue.shade400,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Select a course to view modules',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (isMobile) ...[
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _scaffoldKey.currentState?.openDrawer();
                                    },
                                    icon: const Icon(Icons.menu),
                                    label: const Text('View Courses'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          )
                        : ModulesList(course: selectedCourse!),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            selectedCourse?.courseName ?? 'Select a Course',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          actions: [
            if (selectedCourse != null)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // Refresh functionality
                },
              ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.school,
                        size: 48,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Your Courses',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: buildCoursesList(),
              ),
            ],
          ),
        ),
        body: buildMainContent(),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          buildCoursesList(),
          buildMainContent(),
        ],
      ),
    );
  }
}

class LiveSessionsList extends StatelessWidget {
  final StudentModel course;
  const LiveSessionsList({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<StudentAuthProvider>(context, listen: false)
          .StudentfetchliveForSelectedCourse(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Consumer<StudentAuthProvider>(
          builder: (context, provider, child) {
            final liveSessions = provider.live;
            if (liveSessions.isEmpty) {
              return _noLiveSessionsWidget();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerWidget(),
                  const SizedBox(height: 16),
                  _liveSessionsList(context, liveSessions),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _noLiveSessionsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 50, color: Colors.orange.shade400),
          const SizedBox(height: 12),
          Text(
            'No live sessions scheduled',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.orange.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade100.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.live_tv, color: Colors.red, size: 24),
          SizedBox(width: 12),
          Text(
            'Live Sessions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _liveSessionsList(BuildContext context, List liveSessions) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: liveSessions.length,
        itemBuilder: (context, index) {
          final live = liveSessions[index];
          return _liveSessionCard(context, live);
        },
      ),
    );
  }

  Widget _liveSessionCard(BuildContext context, live) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.white]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _liveIndicator(),
          Expanded(child: _sessionDetails(live)),
          _joinButton(context, live),
        ],
      ),
    );
  }

  Widget _liveIndicator() {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _sessionDetails(live) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          live.message,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.access_time, size: 18, color: Colors.blue.shade600),
            const SizedBox(width: 6),
            Text(
              live.liveStartTime.toString(),
              style: TextStyle(color: Colors.blue.shade600, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _joinButton(BuildContext context, live) {
    return ElevatedButton.icon(
      onPressed: () {
        if (live.liveLink.isNotEmpty) {
          launchUrl(Uri.parse(live.liveLink));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('No live link available'),
              backgroundColor: Colors.blue.shade600,
            ),
          );
        }
      },
      icon: const Icon(Icons.play_circle_outline),
      label: const Text('Join'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class CoursesList extends StatelessWidget {
  final Function(StudentModel) onCourseSelected;
  final StudentModel? selectedCourse;

  const CoursesList({
    super.key,
    required this.onCourseSelected,
    required this.selectedCourse,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<StudentAuthProvider>(context, listen: false)
          .StudentLoadCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Consumer<StudentAuthProvider>(
          builder: (context, provider, child) {
            if (provider.studentCourses.isEmpty) {
              return const Center(child: Text('No courses available.'));
            }
            return ListView.builder(
              itemCount: provider.studentCourses.length,
              itemBuilder: (context, index) {
                final course = provider.studentCourses[index];
                final isSelected = selectedCourse?.courseId == course.courseId;

                return GestureDetector(
                  onTap: () async {
                    try {
                      // Clear all previous data
                      provider.clearModuleData();
                      provider.clearLessonAndAssignmentData();

                      // Set the new course and batch IDs
                      provider.setSelectedCourseId(
                          course.courseId, course.batchId);

                      // Notify parent about course selection
                      onCourseSelected(course);

                      // Pre-fetch modules for the new course
                      await provider.StudentfetchModulesForSelectedCourse();
                      await provider.StudentfetchLessonsAndAssignmentsquiz();
                    } catch (e) {
                      print('Error switching course: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Error loading course content. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.courseName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course.courseDescription,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class ModulesList extends StatefulWidget {
  final StudentModel course;

  const ModulesList({super.key, required this.course});

  @override
  State<ModulesList> createState() => _ModulesListState();
}

class _ModulesListState extends State<ModulesList> {
  @override
  void initState() {
    super.initState();
    // Clear previous module data when a new ModulesList is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<StudentAuthProvider>(context, listen: false);
      provider.clearModuleData();
      provider.clearLessonAndAssignmentData();
      provider.setSelectedCourseId(
          widget.course.courseId, widget.course.batchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<StudentAuthProvider>(context, listen: false)
          .StudentfetchModulesForSelectedCourse(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Consumer<StudentAuthProvider>(
          builder: (context, provider, child) {
            if (provider.modules.isEmpty) {
              return const Center(child: Text('No modules available'));
            }
            return ListView.builder(
              itemCount: provider.modules.length,
              itemBuilder: (context, index) {
                final module = provider.modules[index];
                return ModuleExpansionTile(
                  key: ValueKey('${widget.course.courseId}-${module.moduleId}'),
                  module: module,
                  courseId: widget.course.courseId,
                  batchId: widget.course.batchId,
                );
              },
            );
          },
        );
      },
    );
  }
}

class ModuleExpansionTile extends StatefulWidget {
  final StudentModuleModel module;
  final int courseId;
  final int batchId;

  const ModuleExpansionTile({
    super.key,
    required this.module,
    required this.courseId,
    required this.batchId,
  });

  @override
  State<ModuleExpansionTile> createState() => _ModuleExpansionTileState();
}

class _ModuleExpansionTileState extends State<ModuleExpansionTile> {
  bool isExpanded = false;
  bool isLoading = false;
  List<StudentLessonModel> lessons = [];
  List<StudentAssignmentModel> assignments = [];
  List<StudentQuizmodel> quizzes = [];
  String? errorMessage;

  Future<void> loadModuleContent() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
      // Don't clear the lists here to avoid UI flicker if the fetch fails
    });

    try {
      final provider = Provider.of<StudentAuthProvider>(context, listen: false);

      // Set the module ID
      provider.setSelectedModuleId(widget.module.moduleId);

      // Fetch content
      await Future.wait([
        _fetchLessonsAndAssignments(provider),
        _fetchQuizzes(provider),
      ]);

      if (mounted) {
        setState(() {
          lessons = provider.lessons;
          assignments = provider.assignments;
          quizzes = provider.quiz;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error in loadModuleContent: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Unable to load content. Please try again.';
        });
      }
    }
  }

  Future<void> _fetchLessonsAndAssignments(StudentAuthProvider provider) async {
    try {
      await provider.StudentfetchLessonsAndAssignmentsquiz();
    } catch (e) {
      print('Error fetching lessons and assignments: $e');
      // Don't throw here - we want to continue even if one fetch fails
    }
  }

  Future<void> _fetchQuizzes(StudentAuthProvider provider) async {
    try {
      await provider.StudentfetchliveForSelectedCourse();
    } catch (e) {
      print('Error fetching live content: $e');
      // Don't throw here - we want to continue even if one fetch fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.3),
                      Colors.white.withOpacity(0.6)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    (lessons.length + assignments.length + quizzes.length)
                        .toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.module.title ?? 'No title available',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF666666),
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                    if (isExpanded &&
                        lessons.isEmpty &&
                        assignments.isEmpty &&
                        quizzes.isEmpty) {
                      loadModuleContent();
                    }
                  });
                },
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFEEEEEE)),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: loadModuleContent,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            else if (lessons.isEmpty && assignments.isEmpty && quizzes.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No content available for this module yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Column(
                children: [
                  ...lessons.map((lesson) => _buildExpandedContent(
                        title: lesson.title,
                        content: lesson.content,
                        icon: Icons.book_outlined,
                        buttonText: "View Lesson",
                        onPressed: () async {
                          final Uri url = Uri.parse(lesson.videoLink);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                      )),
                  ...assignments.map((assignment) => _buildExpandedContent(
                        title: assignment.title,
                        content: assignment.description,
                        icon: Icons.assignment_outlined,
                        buttonText: "View Assignment",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignmentSubmissionPage(
                                  assignment: assignment),
                            ),
                          );
                        },
                      )),
                  ...quizzes.map((quiz) => _buildExpandedContent(
                        title: quiz.name,
                        content: quiz.description,
                        icon: Icons.quiz_outlined,
                        buttonText: "Start Quiz",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuizDetailScreen(quiz: quiz),
                            ),
                          );
                        },
                      )),
                ],
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpandedContent({
    required String title,
    required String content,
    required IconData icon,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.blueAccent, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
