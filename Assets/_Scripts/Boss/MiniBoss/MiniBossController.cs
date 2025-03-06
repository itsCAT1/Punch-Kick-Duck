using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class MiniBossController : MonoBehaviour
{
    public float attackRange;
    public bool canAttack;

    void Update()
    {
        UpdateAction();
    }


    void UpdateAction()
    {
        if (!canAttack || MiniBoss.Instance.executer.GetCurrentState() == null) return;

        float distance = Vector3.Distance(transform.position, Player.Instance.transform.position);

        if (distance < attackRange - 0.5f)
        {
            MiniBoss.Instance.executer.SetCurrentState("Attack");
        }
        else if (distance > attackRange + 0.5f)
        {
            MiniBoss.Instance.executer.SetCurrentState("Walk");
        }
    }

}
