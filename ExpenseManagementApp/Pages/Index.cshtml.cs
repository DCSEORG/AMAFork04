using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ExpenseManagementApp.Models;

namespace ExpenseManagementApp.Pages;

public class IndexModel : PageModel
{
    [BindProperty]
    public decimal Amount { get; set; }

    [BindProperty]
    public DateTime ExpenseDate { get; set; } = DateTime.Today;

    [BindProperty]
    public string Category { get; set; } = "Travel";

    [BindProperty]
    public string Description { get; set; } = string.Empty;

    [BindProperty]
    public string ExpensesFilter { get; set; } = string.Empty;

    [BindProperty]
    public string ApproveFilter { get; set; } = string.Empty;

    public List<Expense> AllExpenses { get; set; } = new();
    public List<Expense> PendingExpenses { get; set; } = new();

    public void OnGet()
    {
        LoadDummyData();
    }

    public IActionResult OnPostSubmitExpense()
    {
        // In a real app, this would save to database
        LoadDummyData();
        return Page();
    }

    public IActionResult OnPostSaveExpenses()
    {
        // In a real app, this would update expenses in database
        LoadDummyData();
        return Page();
    }

    public IActionResult OnPostApproveExpenses()
    {
        // In a real app, this would approve expenses in database
        LoadDummyData();
        return Page();
    }

    private void LoadDummyData()
    {
        // Dummy data matching the screenshot
        AllExpenses = new List<Expense>
        {
            new Expense
            {
                Id = 1,
                Date = new DateTime(2024, 1, 15),
                Category = "Travel",
                Amount = 120.00m,
                Status = "Submitted",
                Description = "Train tickets to London"
            },
            new Expense
            {
                Id = 2,
                Date = new DateTime(2023, 1, 10),
                Category = "Food",
                Amount = 69.00m,
                Status = "Submitted",
                Description = "Team lunch"
            },
            new Expense
            {
                Id = 3,
                Date = new DateTime(2023, 12, 4),
                Category = "Office Supplies",
                Amount = 99.50m,
                Status = "Approved",
                Description = "Stationery and printer paper"
            },
            new Expense
            {
                Id = 4,
                Date = new DateTime(2023, 11, 18),
                Category = "Transport",
                Amount = 19.20m,
                Status = "Approved",
                Description = "Taxi to meeting"
            }
        };

        PendingExpenses = new List<Expense>
        {
            new Expense
            {
                Id = 5,
                Date = new DateTime(2024, 1, 20),
                Category = "Travel",
                Amount = 120.00m,
                Status = "Pending",
                Description = "Flight to Manchester"
            },
            new Expense
            {
                Id = 6,
                Date = new DateTime(2023, 12, 14),
                Category = "Office Supplies",
                Amount = 99.50m,
                Status = "Pending",
                Description = "Computer accessories"
            }
        };
    }
}
