namespace MacroTracker.Models;

public class MacroEntryFavorite
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Name {get;set;} = string.Empty;
    public int ProteinGrams { get; set; }
    public int FatGrams { get; set; }
    public int CarbsGrams { get; set; }
    public int FiberGrams { get; set; }
    public int Calories => ((ProteinGrams + CarbsGrams - FiberGrams) * 4) + (FatGrams * 9);
    public string OwnerId { get; set; } = string.Empty;
    
    public override string ToString()
    {
        return System.Text.Json.JsonSerializer.Serialize(this);
    }
}
