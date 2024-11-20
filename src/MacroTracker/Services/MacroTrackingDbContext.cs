using MacroTracker.Models;
using Microsoft.EntityFrameworkCore;

namespace MacroTracker.Services;

public class MacroTrackingDbContext : DbContext
{
    public MacroTrackingDbContext(DbContextOptions options) : base(options)
    {

    } 

    public DbSet<MacroEntryModel> Entries { get; set; } = null!;
    public DbSet<MacroEntryFavorite> Favorites {get;set;} = null!;
}