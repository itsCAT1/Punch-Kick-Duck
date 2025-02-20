using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using static UnityEngine.EventSystems.EventTrigger;


public class PlayerDetecter : MonoBehaviour
{
    public LayerMask hitLayer;
    public Transform ray;
    RaycastHit hitInfo;

    public float attackRange;
    public float bossRange;

    public Transform doorAreaBoss;

    private void Update()   
    {
        SetRangeAttack();
        DetectDoor();
    }

    void SetRangeAttack()
    {
        float playerDirection = Mathf.Sign(Player.Instance.transform.rotation.eulerAngles.y);
        Physics.Raycast(ray.position, ray.forward * playerDirection, out hitInfo, 1000f, hitLayer);

        if (hitInfo.collider == null)
        {
            return;
        }


        if (hitInfo.collider.CompareTag("Enemy") || hitInfo.collider.CompareTag("OpenableDoor"))
        {
            Player.Instance.dealDamage.currentRange = attackRange;
        }

        else if (hitInfo.collider.CompareTag("Boss"))
        {
            Player.Instance.dealDamage.currentRange = bossRange;
        }
    }

    void DetectDoor()
    {
        if (Player.Instance.dealDamage.aimingRay && hitInfo.collider.CompareTag("OpenableDoor"))
        {
            Player.Instance.followBoss.hasReachedDoor = true;
            return;
        }
        Player.Instance.followBoss.hasReachedDoor = false;
    }
}
