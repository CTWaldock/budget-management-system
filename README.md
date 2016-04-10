# BUDGET MANAGEMENT SYSTEM - ON HOLD

Shelving project idea for later. Currently just notes.

### MODELS

1. User
2. Monthly Budget
3. Expense
4. Category

### RELATIONS

1. User has monthly budgets and has many expenses through monthly budgets.
2. Monthly Budget belongs to a user, has many expenses, and has many categories through expenses.
3. Expense belongs to a monthly budget, category, and user.
4. Category has many expenses.

### FEATURES

- Allows user to enter in expenses belonging to a category.
- Shows user daily expenses and expenses for given month.
- Allows user to enter monthly budget. Creates daily limit, tracks how often user has exceeded daily limit for the given month, and whether their average daily expense is on track to meet their monthly goal.
- Informs user about their (projected) savings or debt from their (projected) monthly expenses.
- Breaks down information about (projected) monthly spending by category.
