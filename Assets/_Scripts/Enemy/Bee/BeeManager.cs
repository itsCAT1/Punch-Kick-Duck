using RMC.Core.UEvents;
using RMC.Core.UEvents.UEventDispatcher;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeManager : Singleton<BeeManager>
{
    public Transform[] beePosition;


    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(UpdatePosition);
    }

    public void UpdatePosition(IUEventData uEventData)
    {
        var angle = Player.Instance.controller.playerDirection > 0 ? 0 : 90;
        this.transform.eulerAngles = new Vector3(0, angle, 0);
    }
}
