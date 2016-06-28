function Expense (id, cost, description) {
  this.id = id;
  this.cost = cost;
  this.description = description;
}

Expense.prototype.percentage = function() {
  return Math.round(this.cost * 100 / this.category.subtotal);
}

Expense.prototype.expenseRow = function() {
  var description = '<th scope="row">' + this.description + '</th>';
  var percentage = '<td>' + this.percentage() + '%</td>';
  var cost = '<td>$' + this.cost.toFixed(2) + '</td>';
  var deleteLink = '<td><a href="/expenses/' + this.id + '">Delete Expense</a></td>';
  return ['<tr>', description, percentage, cost, deleteLink, '</tr>'].join("")
}

function resetErrors() {
  $('#error_message').text("");
  $('#error_list').empty();
}

function resetExpenseTable() {
  $('tbody').empty();
}

function resetExpenseInput() {
  $('form')[0].reset();
}

function handleExpenseError(error) {
  resetErrors();
  addErrors(JSON.parse(error.responseText).error);
}

function fillExpenseTable(category) {
  var expenses = category.expenses
  for (var i = 0; i < expenses.length; i++) {
    var expense = expenses[i];
    $('tbody').prepend(expense.expenseRow());
  }
}

function addErrors(errors) {
  $('#error_message').text("Please enter valid information.");
  for (var j = 0; j < errors.length; j++) {
    var error = errors[j];
    $('#error_list').append('<li>' + error + '</li>');
  }
}

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
