using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class BeeMovement : WaypointController
{

    bool onLeft;

    public void UpdatePosition()
    {
        onLeft = GetComponent<BeeController>().onLeft;
        if (onLeft)
        {
            targetPosition[0] = BeeManager.Instance.beePosition[1];
            targetPosition[1] = BeeManager.Instance.beePosition[0];
        }

        else
        {
            targetPosition[0] = BeeManager.Instance.beePosition[0];
            targetPosition[1] = BeeManager.Instance.beePosition[1];
        }
    }
}
