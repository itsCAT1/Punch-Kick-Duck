using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackingEnemyManager : MonoBehaviour
{
    public EnemyAttack currentAttackingEnemy = null; // Enemy hi?n t?i ???c ph�p t?n c�ng

    public bool CanAttack(EnemyAttack enemy)
    {
        // Ch? cho ph�p t?n c�ng n?u ch?a c� Enemy n�o kh�c ?ang t?n c�ng
        return currentAttackingEnemy == null || currentAttackingEnemy == enemy;
    }

    public void SetAttackingEnemy(EnemyAttack enemy)
    {
        currentAttackingEnemy = enemy;
    }

    public void ClearAttackingEnemy(EnemyAttack enemy)
    {
        // Ch? x�a n?u Enemy truy?n v�o l� Enemy hi?n t?i
        if (currentAttackingEnemy == enemy)
        {
            currentAttackingEnemy = null;
        }
    }
}
