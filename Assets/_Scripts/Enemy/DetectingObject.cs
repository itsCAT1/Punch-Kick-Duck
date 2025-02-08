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
        bool aimingRay = Physics.Raycast(controller.rayDetect.transform.position, controller.rayDetect.transform.forward, out RaycastHit hitInfor, 1000, controller.charactorLayer);

        if (aimingRay)
        {
            if (hitInfor.collider.CompareTag("Enemy"))
            {
                controller.currentRange = controller.sizeIdle;
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
}
