using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackingEnemyManager : MonoBehaviour
{
    public EnemyAttack currentAttackingEnemy = null; // Enemy hi?n t?i ???c phép t?n công

    public bool CanAttack(EnemyAttack enemy)
    {
        // Ch? cho phép t?n công n?u ch?a có Enemy nào khác ?ang t?n công
        return currentAttackingEnemy == null || currentAttackingEnemy == enemy;
    }

    public void SetAttackingEnemy(EnemyAttack enemy)
    {
        currentAttackingEnemy = enemy;
    }

    public void ClearAttackingEnemy(EnemyAttack enemy)
    {
        // Ch? xóa n?u Enemy truy?n vào là Enemy hi?n t?i
        if (currentAttackingEnemy == enemy)
        {
            currentAttackingEnemy = null;
        }
    }
}
