using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelfDestroy : MonoBehaviour
{
    private void Update()
    {
        Destroy();
    }

    void Destroy()
    {
        if (Vector3.Distance(this.transform.position, Player.Instance.transform.position) >= 20 && ConditionManger.Instance.currentState == GameState.InGame)
        {
            Destroy(this.gameObject);
        }
    }
}
