using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectingObject : MonoBehaviour
{
    EnemyController controller;

    private void Start()
    {
        controller = GetComponent<EnemyController>();
    }

    private void Update()
    {
        SetRangeAttack();
    }

    void SetRangeAttack()
    {
        Physics.Raycast(controller.rayDetect.transform.position, controller.rayDetect.transform.forward, out RaycastHit hitInfor, 1000, controller.charactorLayer);

        if (hitInfor.collider == null)
        {
            return;
        }

        if (hitInfor.collider.CompareTag("Enemy"))
        {
            if (!controller.haveCart)
            {
                controller.currentRange = controller.sizeStand;
            }
            else
            {
                controller.currentRange = controller.sizeHaveCart;
            }
        }

        else if (hitInfor.collider.CompareTag("Player"))
        {
            if (!controller.haveBottle)
            {
                controller.currentRange = controller.sizeAttack;
            }
            else
            {
                controller.currentRange = controller.sizeThrow;
            }
        }
    }
}
