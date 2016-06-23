REQUIREMENTS
1. Must render one show page and one index page via jQuery and an Active Model Serialization JSON Backend.

- Render budgets index page with JQuery -- hide a completed, active, and inactive tab and allow users to make API requests to acquire that information / render it.

- Render budget show page and category show pages with JQuery as well.

2. Must use your Rails api to create a resource and render the response without a page refresh.

- Expense creation for a category form should make an AJAX post request in order to create the expense, return said expense, and JQuery should render it onto the category page.

3. The rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page.

- AJAX get request to budgets/show needs to return JSON object of budget, along with its collection of categories and their individual information, and then render them onto the page via JSON.

4. Must have at least one link that loads, or updates a resource without reloading the page.

- Index -> Budget Show or Budget Show -> Category or even all three?

5. Must translate the JSON responses into Javascript Model Objects. The Model Objects must have at least one method on the prototype. Formatters work really well for this.

- Create models out of your JSON responses and have methods on them that you can utilize in the view.
