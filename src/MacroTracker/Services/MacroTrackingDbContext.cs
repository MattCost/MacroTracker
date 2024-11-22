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

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder
            .Entity<MacroEntryModel>()
            .Property(e=>e.DateTime)
            .HasConversion(
                v => v,
                v => new DateTime(v.Ticks, DateTimeKind.Utc));
    }
}