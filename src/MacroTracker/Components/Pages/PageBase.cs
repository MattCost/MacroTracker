using Microsoft.AspNetCore.Components;

namespace MacroTracker;

public class PageBase : ComponentBase
{
    readonly string _userIdHeader = "X-MS-CLIENT-PRINCIPAL-ID";
    
    [Inject]
    protected IHttpContextAccessor HttpContextAccessor { get; set; } = default!;

    protected string UserId
    {
        get
        {
            if (Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development") return "local";
            if (HttpContextAccessor == null) return "unknown";
            if (HttpContextAccessor.HttpContext == null) return "unknown";
            if (HttpContextAccessor.HttpContext.Request.Headers.ContainsKey(_userIdHeader)) return HttpContextAccessor.HttpContext.Request.Headers[_userIdHeader].ToString();
            return "unknown";
        }

    }

}