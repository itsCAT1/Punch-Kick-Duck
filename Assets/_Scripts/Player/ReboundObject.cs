using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReboundObject : MonoBehaviour
{
    public GameObject[] zonies;

    public void StartRebound(int indexZone)
    {
        StartCoroutine(ReboundCountTime(indexZone));
    }

    IEnumerator ReboundCountTime(int indexZone)
    {
        zonies[indexZone].SetActive(true);

        yield return new WaitForSeconds(0.4f);

        zonies[indexZone].SetActive(false);
    }
}
