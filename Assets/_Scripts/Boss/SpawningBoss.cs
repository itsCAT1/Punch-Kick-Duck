using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawningBoss : MonoBehaviour
{
    public int timeCounter;

    void Start()
    {
        StartCoroutine(StartCountingTime());
    }

    IEnumerator StartCountingTime()
    {
        while(timeCounter < 0)
        {
            yield return new WaitForSeconds(1);
            timeCounter--;
        }
    }
}
