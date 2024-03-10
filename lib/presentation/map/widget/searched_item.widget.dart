import 'package:flutter/material.dart';

import '../../../domain/entity/map/categorized_place/categorized_place.entity.dart';

class SearchedItem extends StatelessWidget {
  const SearchedItem(this._places, {super.key});

  final List<CategorizedPlaceEntity> _places;

  @override
  Widget build(BuildContext context) => Expanded(
        child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final item = _places[index];
              return ListTile(
                onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => _DetailView(item)),
                title: Text(item.place_name ?? ""),
                subtitle: Text(
                  item.road_address_name ?? "",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                trailing: item.distance != null
                    ? Text("${item.distance!.toInt().toString()}m" ?? "")
                    : null,
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: _places.length),
      );
}

class _DetailView extends StatelessWidget {
  const _DetailView(this._place, {super.key});

  final CategorizedPlaceEntity _place;

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  const Icon(Icons.location_city),
                  const SizedBox(width: 5),
                  Text("장소",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(_place.place_name ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 5),
                  Text("전화번호",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(_place.phone ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 5),
                  Text("주소",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(_place.address_name ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 5),
                  Text("도로명 주소",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(_place.road_address_name ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  const Icon(Icons.link),
                  const SizedBox(width: 5),
                  Text("URL",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(_place.place_url ?? "",
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
          ],
        ),
      );
}
