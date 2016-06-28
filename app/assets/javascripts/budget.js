function Budget (params) {
  this.name = params.name;
  this.id = params.id;
  this.limit = params.limit;
  this.totalExpense = params.total_expense;
}

Budget.prototype.exceeded = function() {
  return (this.totalExpense > this.limit);
}

Budget.prototype.showLink = function() {
  return '<a href="/budgets/' + this.id + '"><p>' + this.name + '</p></a>';
}

function populateIndex() {
  $.get('/user/budgets', function(data) {
    $("#active").append('<h3>Active Budgets</h3>');
    insertBudgets(data.active, "#active");
    $("#inactive").append('<h3>Inactive Budgets</h3>');
    insertBudgets(data.inactive, "#inactive");
    $("#completed").append('<h3>Completed Budgets</h3>');
    insertBudgets(data.completed, "#completed");
    bindBudgetShowLinks();
  }, "JSON")
}

function insertBudgets(budgetList, selector) {
  $.each(budgetList, function(index, params) {
    var budget = new Budget(params);
    $(selector).append(budget.showLink());
    // turn link red if budget is exceeded
    if (budget.exceeded()) {
      $(selector).children().last().addClass("warning");
    }
  });
}

function bindBudgetShowLinks() {
  $('.budget_link a').on('click', function(event) {
    event.preventDefault();
    $.get(this.href).success(function(data) {
      insertBudgetContent(data);
    });
  });
}

function insertBudgetContent(data) {
  $('#content').empty();
  $('#content').html(data);
  bindCategoryShowLinks();
}
