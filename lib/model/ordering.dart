enum Order {
  ascending,
  descending,
}

String orderingInStringFormat(Order order) {
  switch (order) {
    case Order.ascending:
      return 'Ascending';
    case Order.descending:
      return 'Descending';
  }
}
