function Expense (id, cost, description) {
  this.id = id;
  this.cost = cost;
  this.description = description;
}

Expense.prototype.percentage = function() {
  return Math.round(this.cost * 100 / this.category.subtotal);
}
