using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using Lean.Pool;
using static UnityEngine.GraphicsBuffer;
using UnityEditorInternal.Profiling.Memory.Experimental.FileFormat;

public enum AttackType
{
    Punch,
    Kick,
    Duck,
}

[Serializable]
public class AttackMapper
{
    public AttackType attackType;
}

public class OnAttack : MonoBehaviour
{
    public float sizeAttack;
    public LayerMask hitLayer;
    public List<AttackMapper> attackList;

    public bool canDealDamage;
    public List<GameObject> hasDealDamage;
    public bool isBlocking = false;
    public float maxDistance;

    public Transform ray;

    private void Start()
    {
        canDealDamage = false;
        hasDealDamage = new List<GameObject>();
    }

    public void DealDamage(AttackType type)
    {
        //if (!canDealDamage) return;

        AttackMapper attack = attackList.Find(at => at.attackType == type);
        
        if (attack == null) return;

        bool hasCollided = Physics.Raycast(ray.transform.position, ray.transform.forward, out RaycastHit hitInfo, maxDistance, hitLayer);

        hasDealDamage.Clear();
        if (hasCollided && !hasDealDamage.Contains(hitInfo.collider.gameObject))
        {
            hasDealDamage.Add(hitInfo.collider.gameObject);
            //Debug.Log(attack.attackType);

            ResolveCombat(attack, hitInfo);
            //canDealDamage = false;
        }
    }

    private void ResolveCombat(AttackMapper playerAttackType, RaycastHit enemyInfo)
    {
        EnemyType enemy = enemyInfo.collider.GetComponent<EnemyType>(); 
        AttackType enemyAttackType = enemy.attackType;

        Animator animatorEnemy = enemyInfo.collider.GetComponent<Animator>();


        if (playerAttackType.attackType == enemyAttackType)
        {
            StartCoroutine("OnBlocked");
            Debug.Log("Block");
        }
        else if ((playerAttackType.attackType == AttackType.Punch && enemyAttackType == AttackType.Kick) ||
                 (playerAttackType.attackType == AttackType.Kick && enemyAttackType == AttackType.Duck) ||
                 (playerAttackType.attackType == AttackType.Duck && enemyAttackType == AttackType.Punch))
        {
            Player.Instance.controller.animator?.Play("Hurt");
            Debug.Log("Player attacked");
        }
        else
        {
            animatorEnemy?.Play("Hurt");
            Debug.Log("Enemy attacked");
        }
    }

    IEnumerator OnBlocked()
    {
        Time.timeScale = 0;
        yield return new WaitForSecondsRealtime(1);
        Time.timeScale = 1;
    }


    public void EnableDamage()
    {
        canDealDamage = true;
    }

    public void DisableDamage()
    {
        canDealDamage = false;
    }
}
