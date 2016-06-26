function Category (id, title, subtotal, budget, expenses) {
  this.id = id;
  this.title = title;
  this.subtotal = subtotal;
  this.budget = new Budget(budget.name, budget.id, budget.limit, budget.total_expense, this);
  this.expenses = []
  for (var i = 0; i < expenses.length; i++) {
    var expense = new Expense(expenses[i].id, expenses[i].cost, expenses[i].description);
    expense.category = this;
    this.expenses.push(expense);
  };
}

Category.prototype.currentPercent = function() {
  if (this.budget.totalExpense > 0) {
    return Math.round(this.subtotal * 100 / this.budget.totalExpense);
  } else {
    return 0;
  }

}

Category.prototype.totalPercent = function() {
  return Math.round(this.subtotal * 100 / this.budget.limit);
}
