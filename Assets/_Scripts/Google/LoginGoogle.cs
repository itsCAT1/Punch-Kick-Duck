using GooglePlayGames;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoginGoogle : MonoBehaviour
{
    private void Start()
    {
        PlayGamesPlatform.DebugLogEnabled = true;
        PlayGamesPlatform.Activate();

        Social.localUser.Authenticate((bool success) =>
        {
            if (success)
            {
                Debug.Log("Login success");
            }
            else
            {
                Debug.Log("Login fail");
            }
        });
    }
}
