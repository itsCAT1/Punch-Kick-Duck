using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossAttacking : MonoBehaviour
{

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            Attack();
        }
    }

    public void Attack()
    {
        Boss.Instance.attackType.type = (AttackType)Random.Range(0, 3);

        Boss.Instance.executer.SetTrigger("Attack");
    }
}
