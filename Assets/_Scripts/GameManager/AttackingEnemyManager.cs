using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackingEnemyManager : Singleton<AttackingEnemyManager>
{
    public EnemyAttack currentAttackingEnemy = null; 

    public bool CanAttack(EnemyAttack enemy) => currentAttackingEnemy == null;

    public void SetAttackingEnemy(EnemyAttack enemy)
    {
        currentAttackingEnemy = enemy;
    }

    public void ClearAttackingEnemy(EnemyAttack enemy)
    {
        if (currentAttackingEnemy == enemy)
        {
            currentAttackingEnemy = null;
        }
    }
}
