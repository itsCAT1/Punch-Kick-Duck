using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyDetecter : MonoBehaviour
{
    Enemy enemy;
    public float sizeAttack;
    public float sizeStand;
    public float sizeThrow;
    public float sizeHaveCart;

    private void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    private void Update()
    {
        SetRangeAttack();
    }

    void SetRangeAttack()
    {
        Physics.Raycast(enemy.controller.rayDetect.transform.position, enemy.controller.rayDetect.transform.forward, out RaycastHit hitInfo, 1000, enemy.controller.charactorLayer);

        if (hitInfo.collider == null)
        {
            return;
        }

        if (hitInfo.collider.CompareTag("Enemy"))
        {
            if (!enemy.controller.haveCart)
            {
                enemy.controller.currentRange = sizeStand;
            }
            else
            {
                enemy.controller.currentRange = sizeHaveCart;
            }
        }

        else if (hitInfo.collider.CompareTag("Player"))
        {
            if (!enemy.controller.haveBottle)
            {
                enemy.controller.currentRange = sizeAttack;
            }
            else
            {
                enemy.controller.currentRange = sizeThrow;
            }
        }
    }
}
