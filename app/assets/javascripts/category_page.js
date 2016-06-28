

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

function fillStaticCategoryInfo(category) {
  $('.category.name').text(category.title);
  $('.budget.name').text(category.budget.name);
}

function fillCategoryLinks(category) {
  $('#new_expense').attr("action", "/categories/" + category.id + "/expenses");
  $('#budgetlink').append('<a href="/budgets/' + category.budget.id + '">Return to Budget</a>');
  $('#deletecategorylink').append('<a href="/categories/' + category.id + '" data-method="delete">Delete this Category</a>');
}
