using MacroTracker.Components;
using MacroTracker.Services;
using Microsoft.EntityFrameworkCore;

// Hacky work around for local runs. Dotnet makes too many inotify watches on a linux box, is the app is started and stopped over and over.
// Issue has been going on since 2016 and still not fixed
if(string.Equals(Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT"), "Development"))
{
    Environment.SetEnvironmentVariable("DOTNET_USE_POLLING_FILE_WATCHER","1");
}

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddHttpContextAccessor();

builder.Services.AddScoped<TimeProvider, BrowserTimeProvider>();

var sqlConnString = builder.Configuration.GetConnectionString("AZURE_SQL");
builder.Services.AddDbContextFactory<MacroTrackingDbContext>(options => options.UseSqlServer(sqlConnString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();


app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
