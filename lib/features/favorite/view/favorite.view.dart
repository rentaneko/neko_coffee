import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/favorite/bloc/index.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, required this.favouriteBloc});
  final FavouriteBloc favouriteBloc;
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    widget.favouriteBloc.add(FavouriteInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        bloc: widget.favouriteBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is FavouriteActionState,
        buildWhen: (previous, current) => current is! FavouriteActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case FavouriteErrorState:
              state as FavouriteErrorState;
              return FailureWidget(error: state.errorMsg);

            case FavouriteLoadedState:
              state as FavouriteLoadedState;
              return ListView.separated(
                itemCount: state.favourites.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) => widget.favouriteBloc.add(
                            RemoveItemClickedEvent(
                              idProduct: state.favourites[index].idProduct!,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: CupertinoIcons.trash,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading:
                          Image.network('${state.favourites[index].imgUrl}'),
                      title: Text('${state.favourites[index].name}'),
                      subtitle: Text(
                        '${state.favourites[index].desc}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  );
                },
              );

            case FavouriteAddToListSuccessState:
              state as FavouriteAddToListSuccessState;
              return ListView.separated(
                itemCount: state.favourites.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) => widget.favouriteBloc.add(
                            RemoveItemClickedEvent(
                              idProduct: state.favourites[index].idProduct!,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: CupertinoIcons.trash,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading:
                          Image.network('${state.favourites[index].imgUrl}'),
                      title: Text('${state.favourites[index].name}'),
                      subtitle: Text(
                        '${state.favourites[index].desc}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  );
                },
              );

            default:
              return const LoadingWidget();
          }
        },
      ),
    );
  }
}
