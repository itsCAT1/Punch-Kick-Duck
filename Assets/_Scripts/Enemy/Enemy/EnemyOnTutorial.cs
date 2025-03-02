using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyOnTutorial : MonoBehaviour
{
    Enemy enemy;

    public float distanceReach;
    public bool canWait;
    public bool isWaiting;

    private void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    public bool PlayerInRange() => Vector3.Distance(this.transform.position, Player.Instance.transform.position) <= distanceReach;

    public void UpdateEnemyState()
    {
        if (PlayerInRange())
        {
            if (!isWaiting)
            {
                enemy.executer.SetCurrentState("Tutorial");
                return;
            }
        }

        if (canWait) return;

        if (!PlayerInRange())
        {
            enemy.executer.SetCurrentState("Walk");
        }
    }
}
