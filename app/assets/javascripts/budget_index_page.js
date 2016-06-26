function insertBudgets(budgetList, selector) {
  $.each(budgetList, function(index, params) {
    var budget = new Budget(params.name, params.id, params.limit, params.total_expense);
    $(selector).append('<a href="/budgets/' + budget.id + '"><p>' + budget.name + '</p></a>');
    if (budget.exceeded()) {
      $(selector).children().last().addClass("warning");
    }
  });
}

function populateIndex() {
  $.get('/user/budgets', function(data) {
    $("#active").append('<h3>Active Budgets</h3>');
    insertBudgets(data.active, "#active");
    $("#inactive").append('<h3>Inactive Budgets</h3>');
    insertBudgets(data.inactive, "#inactive");
    $("#completed").append('<h3>Completed Budgets</h3>');
    insertBudgets(data.completed, "#completed");
  }, "JSON")
}
