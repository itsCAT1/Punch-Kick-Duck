using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushingPKD : PushingText
{

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.CompareTag("Punch") || other.gameObject.CompareTag("Kick") || other.gameObject.CompareTag("Duck") 
            && !DataInGame.Instance.isStartGame)
        {
            DataInGame.Instance.isStartGame = true;
            PerformPushing();
        }
    }
}
