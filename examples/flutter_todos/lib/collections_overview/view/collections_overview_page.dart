import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collections_repository/collections_repository.dart';
import 'package:flutter_todos/edit_collection/view/edit_collection_page.dart';
import 'package:flutter_todos/collections_overview/collections_overview.dart';

class CollectionsOverviewPage extends StatelessWidget {
  const CollectionsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionsOverviewBloc(
        collectionsRepository: context.read<CollectionsRepository>(),
      )..add(const CollectionsOverviewSubscriptionRequested()),
      child: const CollectionsOverviewView(),
    );
  }
}

class CollectionsOverviewView extends StatelessWidget {
  const CollectionsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collections'),

      ),
      body: BlocListener<CollectionsOverviewBloc, CollectionsOverviewState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == CollectionsOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error'),
                ),
              );
          }
        },
        child: BlocBuilder<CollectionsOverviewBloc, CollectionsOverviewState>(
          builder: (context, state) {
            if (state.collections.isEmpty) {
              if (state.status == CollectionsOverviewStatus.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state.status != CollectionsOverviewStatus.success) {
                return const SizedBox(); 
              } else {
                return Center(
                  child: Text(
                    'No collections',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final collection in state.collections)
                    CollectionListTile(
                      collection: collection,
                      onTap: () {
                        Navigator.of(context).push(
                          EditCollectionPage.route(initialCollection: collection),
                        );
                      },
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
