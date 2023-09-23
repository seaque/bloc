import 'package:collections_repository/collections_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/edit_collection/edit_collection.dart';
import 'package:flutter_todos/l10n/l10n.dart';

class EditCollectionPage extends StatelessWidget {
  const EditCollectionPage({super.key});

  static Route<void> route({Collection? initialCollection}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditCollectionBloc(
          collectionsRepository: context.read<CollectionsRepository>(),
          initialCollection: initialCollection,
        ),
        child: const EditCollectionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCollectionBloc, EditCollectionState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status == EditCollectionStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditCollectionView(),
    );
  }
}

class EditCollectionView extends StatelessWidget {
  const EditCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(seaque): l10n localizations
    //final l10n = context.l10n;
    final status = context.select(
      (EditCollectionBloc bloc) => bloc.state.status,
    );
    final isNewCollection = context.select(
      (EditCollectionBloc bloc) => bloc.state.isNewCollection,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ?? theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewCollection ? 'Add Collection' : 'Edit Collection',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save Collection',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess 
            ? fabBackgroundColor.withOpacity(0.5) 
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<EditCollectionBloc>()
              .add(
                const EditCollectionSubmitted(),
              ),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(
                Icons.check_rounded,
              ),
      ),
      body: const CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [_TitleField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditCollectionBloc>().state;
    final hintText = state.initialCollection?.title ?? '';

    return TextFormField(
      key: const Key('editCollectionView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Edit Collection',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCollectionBloc>().add(EditCollectionTitleChanged(value));
      },
    );
  }
}
