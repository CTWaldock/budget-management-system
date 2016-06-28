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



function updateCategory(category) {
  $('#cost').text("$" + category.subtotal.toFixed(2));
  $('#current').text(category.currentPercent() + "%");
  $('#total').text(category.totalPercent() + "%");
}

function fillStaticCategoryInfo(category) {
  $('.category.name').text(category.title);
  $('.budget.name').text(category.budget.name);
}

function fillCategoryLinks(category) {
  $('#new_expense').attr("action", "/categories/" + category.id + "/expenses");
  $('#budgetlink').append('<a href="/budgets/' + category.budget.id + '">Return to Budget</a>');
  $('#deletecategorylink').append('<a href="/categories/' + category.id + '" data-method="delete">Delete this Category</a>');
}

function replaceContent(data) {
  $('#content').empty();
  $('#content').html(categoryShow);
}

function bindCategoryLinks() {
  $('.category a').on('click', function(event) {
    event.preventDefault();
    $.get(this.href, function(data) {
      category = new Category(data.id, data.title, data.subtotal, data.budget, data.expenses)
      replaceContent(data);
      fillStaticCategoryInfo(category);
      fillCategoryLinks(category);
      updateCategory(category);
      fillExpenseTable(category);
      bindExpenseForm();
      bindDeleteLinks();
    });
  });
}

var categoryShow = '<h1 class="category name"></h1>\
<h4 id="budgetlink"></h4>\
<h4 id="deletecategorylink" class="warning"></h4>\
<br>\
<h4>Add Expense</h4>\
<div class="row">\
  <div class="col-md-6 col-md-offset-3">\
    <form class="form-inline" id="new_expense" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓">\
      <div id="error_explanation">\
        <h2 id="error_message"></h2>\
        <ul id="error_list"></ul>\
      </div>\
    <div class="inline">\
      <input placeholder="Description" type="text" name="expense[description]" id="expense_description">\
    </div>\
    <div class="inline">\
      <input placeholder="Cost" type="text" name="expense[cost]" id="expense_cost">\
    </div>\
    <input type="submit" name="commit" value="Create Expense" class="btn btn-primary btn-sm">\
    </form>\
    <br></br>\
    <p>Total costs amount to <span id="cost"></span>.</p>\
    <p>Represents <span id="current"></span> of current budget expenditure for <span class="budget name"></span>.</p>\
    <p>Represents <span id="total"></span> of maximum budget expenditure for <span class="budget name"></span>.</p>\
    <table class="table">\
      <thead>\
        <tr>\
          <th class="col-md-3">Description</th>\
          <th class="col-md-3">% of Category Subtotal</th>\
          <th class="col-md-3">Cost</th>\
          <th class="col-md-1">Actions</th>\
        </tr>\
      </thead>\
      <tbody>\
      </tbody>\
    </table>\
  </div>\
</div>'
