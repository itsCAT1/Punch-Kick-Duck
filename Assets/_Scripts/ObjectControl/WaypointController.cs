using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaypointController : MonoBehaviour
{
    public float speed;
    public int currentIndex = 0;

    public Transform[] targetPosition;

    public void PerformMoving()
    {
        this.transform.position = Vector3.MoveTowards(transform.position, targetPosition[currentIndex].position, speed * Time.deltaTime);

        if (Vector3.Distance(transform.position, targetPosition[currentIndex].position) < 0.1f)
        {
            currentIndex++;
            if (currentIndex >= targetPosition.Length)
            {
                currentIndex = 0;
            }
        }
    }

    public void PlayerPerformMoving()
    {
        Player.Instance.transform.position = Vector3.MoveTowards(Player.Instance.transform.position, targetPosition[currentIndex].position, 
            speed * Time.deltaTime);

        if (Vector3.Distance(Player.Instance.transform.position, targetPosition[currentIndex].position) < 0.1f)
        {
            currentIndex++;
            if (currentIndex >= targetPosition.Length)
            {
                currentIndex = 0;
            }
        }
    }
}
