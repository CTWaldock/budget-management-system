function bindExpenseForm() {
  $('form').on('submit', function(event) {
    event.preventDefault();
    var expenseParams = $(this).serialize();
    var expensePost = $.post(this.action, expenseParams);

    expensePost.done(function(data) {
      fillVariableInfo(data);
    }).fail(function(error) {
      handleExpenseError(error);
    });
  });
}

function bindDeleteLinks() {
  $('td a').on('click', function(event) {
    event.preventDefault();
    link = this.href
    $.ajax({
      url: link,
      type: 'DELETE',
      success: function(data) {
        fillVariableInfo(data)
      }
    });
  });
}

function fillVariableInfo(data) {
  category = new Category(data.id, data.title, data.subtotal, data.budget, data.expenses)
  updateCategory(category);
  resetExpense();
  resetErrors();
  fillExpenseTable(category);
  bindDeleteLinks();
}

function updateCategory(category) {
  $('#cost').text("$" + category.subtotal.toFixed(2));
  $('#current').text(category.currentPercent() + "%");
  $('#total').text(category.totalPercent() + "%");
}

function resetErrors() {
  $('#error_message').text("");
  $('#error_list').empty();
}

function resetExpense() {
  $('tbody').empty();
  $('form')[0].reset();
}

function fillExpenseTable(category) {
  var expenses = category.expenses
  for (var i = 0; i < expenses.length; i++) {
    var expense = expenses[i];
    addExpenseRow(expense);
  }
}

function addExpenseRow(expense) {
  var description = '<th scope="row">' + expense.description + '</th>';
  var percentage = '<td>' + expense.percentage() + '%</td>';
  var cost = '<td>$' + expense.cost.toFixed(2) + '</td>';
  var deleteLink = '<td><a href="/expenses/' + expense.id + '">Delete Expense</a></td>';
  var tableRow = ['<tr>', description, percentage, cost, deleteLink, '</tr>'].join("")
  $('tbody').prepend(tableRow);
}

function handleExpenseError(error) {
  resetErrors();
  addErrors(JSON.parse(error.responseText).error);
}

function addErrors(errors) {
  $('#error_message').text("Please enter valid information.");
  for (var j = 0; j < errors.length; j++) {
    var error = errors[j];
    $('#error_list').append('<li>' + error + '</li>');
  }
}

function replaceContent() {
  $('#content').empty();
  $('#content').html(showHTML);
}

function fillStaticInfo(data) {
  $('#new_expense').attr("action", "/categories/" + data.id + "/expenses");
  $('#budgetlink').append('<a href="/budgets/' + data.budget.id + '">Return to Budget</a>');
  $('#deletecategorylink').append('<a href="/categories/' + data.id + '" data-method="delete">Delete this Category</a>');
  $('.category.name').text(data.title);
  $('.budget.name').text(data.budget.name);
}
