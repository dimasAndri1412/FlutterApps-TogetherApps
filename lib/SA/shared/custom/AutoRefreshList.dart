import 'dart:async';
import 'package:flutter/material.dart';
import 'BlurredListTile.dart';

class AutoRefreshList<T> extends StatefulWidget {
  final Future<List<T>> Function() fetchData;
  final Widget Function(BuildContext, List<T>) builder;
  final Duration refreshInterval;

  const AutoRefreshList({
    Key? key,
    required this.fetchData,
    required this.builder,
    this.refreshInterval = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  _AutoRefreshListState<T> createState() => _AutoRefreshListState<T>();
}

class _AutoRefreshListState<T> extends State<AutoRefreshList<T>> {
  late Future<List<T>> _futureData;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _futureData = widget.fetchData();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(widget.refreshInterval, (timer) async {
      try {
        final data = await widget.fetchData();
        if (data.isNotEmpty) {
          setState(() {
            _futureData = Future.value(data);
          });
        }
      } catch (error) {
        // Biarkan error tanpa mengganggu pengguna
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Placeholder animasi berjalan di BlurredListTile
          return ListView.builder(
            itemCount: 5, // Placeholder jumlah item
            itemBuilder: (context, index) {
              return const BlurredListTile(isLoading: true);
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data found."));
        } else {
          return widget.builder(context, snapshot.data!);
        }
      },
    );
  }
}
