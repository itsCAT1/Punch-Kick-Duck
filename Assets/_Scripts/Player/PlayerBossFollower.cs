using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerBossFollower : MonoBehaviour
{
    
    public bool hasReachedDoor;
    public float attackRange;


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
        if (distance > attackRange + 0.2f)
        {
            Player.Instance.executer.SetCurrentState("Walk");
        }
        else if (distance < attackRange + 0.2f)
        {
            Player.Instance.executer.SetCurrentState("Idle");
        }
    }
}
