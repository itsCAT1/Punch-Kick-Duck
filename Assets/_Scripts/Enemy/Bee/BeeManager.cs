using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeManager : Singleton<BeeManager>
{
    public Transform[] beePosition;

    private void Update()
    {
        UpdatePosition();
    }

    public void UpdatePosition()
    {
         this.transform.localScale = new Vector3(1, 1, Player.Instance.controller.playerDirection);
    }

}
