import 'package:cigarette_control/containers/app_loading.dart';
import 'package:cigarette_control/containers/smoke_details.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/presentation/loading_indicator.dart';
import 'package:cigarette_control/presentation/smoke_item.dart';
import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SmokeList extends StatelessWidget {
  final List<Smoke> smokes;
  final Function(Smoke) onRemove;
  final Function(Smoke) onUndoRemove;

  SmokeList({
    Key key,
    @required this.smokes,
    @required this.onRemove,
    @required this.onUndoRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading ? LoadingIndicator(key: ArchSampleKeys.smokesLoading) : _buildListView();
    });
  }

  ListView _buildListView() {
    return ListView.builder(
      key: ArchSampleKeys.smokeList,
      itemCount: smokes.length,
      itemBuilder: (BuildContext context, int index) {
        final smoke = smokes[index];

        return SmokeItem(
          smoke: smoke,
          onDismissed: (direction) {
            _removeSmoke(context, smoke);
          },
          onTap: () => _onSmokeTap(context, smoke),
        );
      },
    );
  }

  void _removeSmoke(BuildContext context, Smoke smoke) {
    onRemove(smoke);

    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          ArchSampleLocalizations.of(context).smokeDeleted(smoke.date.toString()),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: ArchSampleLocalizations.of(context).undo,
          onPressed: () => onUndoRemove(smoke),
        )));
  }

  void _onSmokeTap(BuildContext context, Smoke smoke) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (_) => SmokeDetails(id: smoke.id),
    ))
        .then((removedSmoke) {
      if (removedSmoke != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            key: ArchSampleKeys.snackbar,
            duration: Duration(seconds: 2),
            content: Text(
              ArchSampleLocalizations.of(context).smokeDeleted(smoke.date.toString()),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: ArchSampleLocalizations.of(context).undo,
              onPressed: () {
                onUndoRemove(smoke);
              },
            )));
      }
    });
  }
}
