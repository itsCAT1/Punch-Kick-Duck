using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using Lean.Pool;
using static UnityEngine.GraphicsBuffer;

public enum AttackType
{
    Punch,
    Kick,
    Duck,
}

[Serializable]
public class AttackMapper
{
    public Transform point;
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
        if (!canDealDamage) return;

        AttackMapper attack = attackList.Find(at => at.attackType == type);
        
        if (attack == null) return;

        bool hasCollided = Physics.Raycast(ray.transform.position, ray.transform.forward, out RaycastHit hitInfo, maxDistance, hitLayer);

        if (hasCollided && !hasDealDamage.Contains(hitInfo.collider.gameObject))
        {
            hasDealDamage.Add(hitInfo.collider.gameObject);
            Debug.Log(attack.attackType);
            //Destroy(hitInfo.collider.gameObject);
            Blocking(attack, hitInfo);

            canDealDamage = false;
        }
    }


    void OnDetect(AttackMapper attack)
    {
        /*Collider[] hits = Physics.OverlapSphere(attack.point.transform.position, sizeAttack, hitLayer);
        
        foreach (var target in hits)
        {
            if (!hasDealDamage.Contains(target.gameObject))
            {
                hasDealDamage.Add(target.gameObject);
                Destroy(target.gameObject);

                canDealDamage = false;
                break;
            }
        }*/

        
    }


    void Blocking(AttackMapper attack, RaycastHit target)
    {
        Animator animator = target.collider.GetComponent<Animator>();
        EnemyBlocking currentType = target.collider.GetComponent<EnemyBlocking>();

        if (attack.attackType == currentType.attackType)
        {
            StartCoroutine(OnBlocked());
            animator?.Play("Idle");
            isBlocking = false;
        }
        else
        {
            animator?.Play("Hurt");
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
        hasDealDamage.Clear();
    }
}
