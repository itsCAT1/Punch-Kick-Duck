using System.Threading.Tasks;
using GooglePlayGames;
using GooglePlayGames.BasicApi;
using UnityEngine;

public class GoogleIntegration : MonoBehaviour
{
    public string GooglePlayToken;
    public string GooglePlayError;

    public async Task Authenticate()
    {
        PlayGamesPlatform.Activate();

        PlayGamesPlatform.Instance.Authenticate((success) =>
        {
            if (success == SignInStatus.Success)
            {
                Debug.Log("Login with Google was successful.");
                PlayGamesPlatform.Instance.RequestServerSideAccess(true, code =>
                {
                    Debug.Log($"Auth code is {code}");
                    GooglePlayToken = code;
                });
            }
            else
            {
                GooglePlayError = "Failed to retrieve GPG auth code";
                Debug.LogError("Login Unsuccessful");
            }
        });

        await Task.Yield();
    }
}