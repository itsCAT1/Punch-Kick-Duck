using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class AttackingEnemyManager : Singleton<AttackingEnemyManager>
{
    public GameObject currentAttackingEnemy = null; 

    public bool CanAttack(GameObject enemy) => currentAttackingEnemy == null || currentAttackingEnemy == enemy;

    public void SetAttackingEnemy(GameObject enemy)
    {
        currentAttackingEnemy = enemy;
    }

    public void ClearAttackingEnemy(GameObject enemy)
    {
        if (currentAttackingEnemy == enemy || currentAttackingEnemy == null)
        {
            currentAttackingEnemy = null;
        }
    }
}
