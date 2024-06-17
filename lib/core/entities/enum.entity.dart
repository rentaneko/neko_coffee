enum CategoryEnum {
  coffee('a18dfa1b-4c54-4b9d-afd8-cdcb3692c777', 'Coffee'),
  noncoffee('d1c37b91-5b83-43b4-b131-05de9f3c2909', 'Non Coffee'),
  pastry('4b86f3b7-57cf-4d08-96a2-f13f10bcbb9d', 'Pastry');

  final String id;
  final String name;
  const CategoryEnum(this.id, this.name);

  static CategoryEnum? getEnumById(String id) =>
      CategoryEnum.values.firstWhereOrNull((element) => element.id == id);
}

enum SortType { ascending, descending, none }

enum SizeCup { regular, medium, large }

enum VariantType { hot, ice }

enum IceType { less, normal, more, none }

enum SugarType { less, normal, more }

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) condition) {
    for (final element in this) {
      if (condition(element)) return element;
    }
    return null;
  }
}
