using MacroTracker.Services;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;

namespace MacroTracker.Components;

public sealed class LocalTimeZoneDetector : ComponentBase
{
    [Inject] public TimeProvider TimeProvider { get; set; } = default!;
    [Inject] public IJSRuntime JSRuntime { get; set; } = default!;

    [Parameter]
    public string TimeZoneJsFilename { get; set; } = "./lib/js/timezone.js";

    public string TimeZone { get; set; } = string.Empty;

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender && TimeProvider is BrowserTimeProvider browserTimeProvider && !browserTimeProvider.IsLocalTimeZoneSet)
        {
            try
            {
                await using var module = await JSRuntime.InvokeAsync<IJSObjectReference>("import", TimeZoneJsFilename);
                var timeZone = await module.InvokeAsync<string>("getBrowserTimeZone");
                browserTimeProvider.SetBrowserTimeZone(timeZone);
                TimeZone = timeZone;
            }
            catch (JSDisconnectedException)
            {
            }
        }
    }
}