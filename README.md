# BUDGET MANAGEMENT SYSTEM - IN PROGRESS
Budget management system with a backend powered by Ruby on Rails.

### MODELS
1. User
2. Budget
3. Expense


### RELATIONS...
1. User has many budgets.
2. Budget belongs to a user and have many expenses.
3. Expense belongs to a budget.


### FEATURES
- Allows user to enter in expenses.
- Shows user daily expenses and expenses.
- Allows user to enter monthly budget. Creates daily limit, tracks how often user has exceeded daily limit for the given month, and whether their average daily expense is on track to meet their monthly goal.
- Informs user about their (projected) savings or debt from their (projected) monthly expenses.
- Breaks down information about (projected) monthly spending by category.

### NOTES


- Need to add timezone column to users and integrate into views, deal with GitHub logged in users. Maybe redirect users w/o TimeZone to a users edit page to set timezone.

- Categories? Represent as a model or as a type of expense? How should a budget know about its categorical expenses and update that without having to make multiple queries every time? Consider BudgetCategory/CategoricalExpense model, no real purpose in having a Category model isolated from a budget. Would belong to a budget and have many expenses. Maybe the budget model would be modified to have expenses through categories?

- Eventually switch over to a group budget system.
