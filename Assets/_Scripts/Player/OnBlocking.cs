using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OnBlocking : MonoBehaviour
{

    public float forcePush = 2;

    public void IsRepelled()
    {
        Vector3 startPos = this.transform.position;
        Vector3 endPos = startPos - this.transform.forward * forcePush;

        StartCoroutine(AddForceCoroutine(startPos, endPos));
    }


    IEnumerator AddForceCoroutine(Vector3 startPos, Vector3 endPos)
    {
        float count = 0;
        float duration = 1;

        while (count < duration)
        {
            this.transform.position = Vector3.Lerp(startPos, endPos, count / duration);

            count += Time.deltaTime;
            yield return null;
        }
    }
}
