using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossController : MonoBehaviour
{
    public bool canAttack;

    public int attackCount;
    public int throwCount;
    public bool isThrowing = false;

    public float distanceAttack;

    void Start()
    {
        
    }

    private void Update()
    {
        UpdateAction();
    }

    public void UpdateAction()
    {
        if (!canAttack) return;
        if (Boss.Instance.executer.GetCurrentState() == null) return;


        if (!isThrowing)
        {
            float distance = Vector3.Distance(Player.Instance.transform.position, Boss.Instance.transform.position);
            if (distance >= distanceAttack + 0.2f)
            {
                Boss.Instance.executer.SetCurrentState("Idle");
            }

            else if (distance <= distanceAttack - 0.2f)
            {
                Boss.Instance.executer.SetCurrentState("Attack");
            }
        }
    }
}
