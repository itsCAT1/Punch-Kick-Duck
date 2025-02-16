using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossController : MonoBehaviour
{
    public float attackCoolDown = 2;
    public float timeAttack;

    public bool canAttack => Time.time - timeAttack >= attackCoolDown;
    public bool playerInRange => Vector3.Distance(transform.position, Player.Instance.transform.position) <= 3f;

    void Start()
    {
        
    }

    public void UpdateAction()
    {
        float distance = Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position);

        if (distance >= 3.2f)
        {
            Boss.Instance.executer.SetCurrentState("Idle");
        }

        if (distance <= 2.8f)
        {
            Boss.Instance.executer.SetCurrentState("Attack");
        }
    }
}
