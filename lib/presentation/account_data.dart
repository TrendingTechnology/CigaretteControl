import 'package:cached_network_image/cached_network_image.dart';
import 'package:cigarette_control/containers/app_loading.dart';
import 'package:cigarette_control/presentation/loading_indicator.dart';
import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountData extends StatelessWidget {
  final String name;
  final String email;
  final String photoUrl;
  final Function() onLogout;

  AccountData({@required this.name, @required this.email, @required this.photoUrl, @required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading ? LoadingIndicator(key: Key('__accountLoading__')) : _buildStats(context);
    });
  }

  Widget _buildStats(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CachedNetworkImage(
                imageUrl: photoUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).name,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              '$name',
              key: ArchSampleKeys.statsNumDaily,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).email,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              '$email',
              key: ArchSampleKeys.statsNumMonthly,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: OutlineButton(
              onPressed: onLogout,
              child: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}
