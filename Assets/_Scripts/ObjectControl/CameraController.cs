using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : Singleton<CameraController>
{
    public Vector3 offset;
    public float speedMove;

    public bool controllable = false;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(SpeedStartGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(SpeedEndGame);
    }

    void Update()
    {
        if (controllable)
        {
            FollowBoss();
            return;
        }

        FollowPlayer();
    }

    void SpeedStartGame(IUEventData uEventData)
    {
        controllable = false;
        speedMove = 1;
    }

    void SpeedEndGame(IUEventData uEventData)
    {
        speedMove = 0.01f;
    }

    void FollowPlayer()
    {
        var targetPos = new Vector3(Player.Instance.transform.position.x, Player.Instance.transform.position.y + offset.y, offset.z);
        transform.position = Vector3.Lerp(transform.position, targetPos, speedMove);
    }

    public void SetSpeedFollowBoss()
    {
        controllable = true;
        speedMove = 0.03f;
    }

    void FollowBoss()
    {
        var targetPos = new Vector3(Boss.Instance.transform.position.x, Boss.Instance.transform.position.y + offset.y, offset.z);
        transform.position = Vector3.Lerp(transform.position, targetPos, speedMove);
    }
}
