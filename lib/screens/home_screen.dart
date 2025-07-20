import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/call_cubit.dart';
import '../injection_container.dart';
import '../video_call_advanced.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONTACTS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff67628e),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF0EFF4),
        actions: [
          Icon(Icons.person_add_alt_1_outlined, color: Color(0xff67628e)),
          SizedBox(width: 32),
        ],
      ),
      body: Container(
        color: Color(0xffF0EFF4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[400]),
                          SizedBox(width: 5),
                          Text(
                            'Search your contacts',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      Icon(Icons.mic, color: Color(0xff67628e), size: 24),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FAVORITES',
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff67628e),
                        ),
                      ),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&h=150&fit=crop&crop=face',
                            ),
                            SizedBox(width: 16),
                            _buildFavoriteContact(
                              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RECENT CALLS',
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff67628e),
                        ),
                      ),

                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
                        name: 'Emma Rodriguez',
                        number: '+44 20 7946 0958',
                        context: context,
                      ),

                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                        name: 'David Chen',
                        number: '+86 138 0013 8000',
                        context: context,
                      ),

                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
                        name: 'Lisa Thompson',
                        number: '+61 2 9876 5432',
                        context: context,
                      ),

                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
                        name: 'Michael Johnson',
                        number: '+1 (555) 987-6543',
                        context: context,
                      ),

                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
                        name: 'Anna Martinez',
                        number: '+34 91 123 4567',
                        context: context,
                      ),
                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&h=150&fit=crop&crop=face',
                        name: 'Maria Garcia',
                        number: '+49 30 12345678',
                        context: context,
                      ),
                      SizedBox(height: 16),
                      _buildRecentCall(
                        imageUrl:
                            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
                        name: 'Thomas Andre',
                        number: '+33 1 42 86 12 34',
                        context: context,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteContact(String imageUrl) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.grey[600], size: 30),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xff67628e),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCall({
    required String imageUrl,
    required String name,
    required String number,
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(imageUrl, fit: BoxFit.fill),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    number,
                    style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ClipRect(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: getIt.get<CallCubit>(),
                          child: const AdvancedVideoCallScreen(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.call, color: Color(0xff67628e), size: 20),
                  ),
                ),
              ),

              SizedBox(width: 12),
              ClipRect(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: getIt.get<CallCubit>(),
                          child: const AdvancedVideoCallScreen(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff67628e),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.photo_camera_front,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
