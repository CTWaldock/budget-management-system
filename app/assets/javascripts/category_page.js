

function fillVariableCategoryInfo(data) {
  category = new Category(data.id, data.title, data.subtotal, data.budget, data.expenses)
  updateCategory(category);
  resetExpenseTable();
  resetExpenseInput();
  resetErrors();
  fillExpenseTable(category);
  bindDeleteLinks();
}

function updateCategory(category) {
  $('#cost').text("$" + category.subtotal.toFixed(2));
  $('#current').text(category.currentPercent() + "%");
  $('#total').text(category.totalPercent() + "%");
}

function fillStaticCategoryInfo(data) {
  $('#new_expense').attr("action", "/categories/" + data.id + "/expenses");
  $('#budgetlink').append('<a href="/budgets/' + data.budget.id + '">Return to Budget</a>');
  $('#deletecategorylink').append('<a href="/categories/' + data.id + '" data-method="delete">Delete this Category</a>');
  $('.category.name').text(data.title);
  $('.budget.name').text(data.budget.name);
}
