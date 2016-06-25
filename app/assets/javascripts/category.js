function Category (id, title, subtotal) {
  this.id = id;
  this.title = title;
  this.subtotal = subtotal;
}

Category.prototype.budget = function(budget) {
  this.budget = budget;
}

Category.prototype.current_percent = function() {
  return Math.round(this.subtotal * 100 / this.budget.total_expense);
}

Category.prototype.total_percent = function() {
  return Math.round(this.subtotal * 100 / this.budget.limit);
}
