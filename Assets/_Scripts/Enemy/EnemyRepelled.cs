using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyRepelled : Repelled
{
    public override void IsRepelled()
    {
        Vector3 startPos = this.transform.position;
        Vector3 endPos = startPos - this.transform.forward * forcePush;

        StartCoroutine(AddForceCoroutineEnemy(startPos, endPos));
    }


    IEnumerator AddForceCoroutineEnemy(Vector3 startPos, Vector3 endPos)
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
