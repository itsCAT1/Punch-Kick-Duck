using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerBossFollower : MonoBehaviour
{
    public bool hasReachedDoor;
    public float attackRange;

    bool hasReachedBoss;
    public bool canWait;
    public bool isWaiting;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(OnStart);
    }

    public void FollowBoss()
    {
        if (hasReachedDoor)
        {
            Player.Instance.executer.SetCurrentState("Idle");
            return;
        }

        float distance = Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position);

        UpdatePlayerState(distance);
    }

    void UpdatePlayerState(float distance)
    {
        if (distance < 10 && !isWaiting)
        {
            Player.Instance.executer.SetCurrentState("WaitToAttack");
        }

        if (canWait) return;

        if (distance > attackRange + 0.2f)
        {
            Player.Instance.executer.SetCurrentState("Walk");
        }
        else if (distance < attackRange + 0.2f)
        {
            Player.Instance.executer.SetCurrentState("Idle");
        }
    }

    public void OnStart(IUEventData uEventData)
    {
        if(DataManager.Instance.data.currentMap == 10)
        {
            this.transform.rotation = Quaternion.Euler(0, 90, 0);

            if (DataInGame.Instance.inRoom)
                Player.Instance.executer.SetCurrentState("WaitToAttack");

            else
            {
                canWait = false;
                isWaiting = false;
            }
        }

        
    }
}
