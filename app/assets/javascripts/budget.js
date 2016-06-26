function Budget (name, id, limit, totalExpense, category) {
  this.name = name;
  this.id = id;
  this.limit = limit;
  this.totalExpense = totalExpense;
  this.category = category;
}

Budget.prototype.exceeded = function() {
  return (this.totalExpense > this.limit);
}
