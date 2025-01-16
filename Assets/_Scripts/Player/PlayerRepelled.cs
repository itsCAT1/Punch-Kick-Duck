using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerRepelled : Repelled
{
    public override void IsRepelled()
    {
        Vector3 startPos = Player.Instance.transform.position;
        Vector3 endPos = startPos - Player.Instance.transform.forward * forcePush;

        StartCoroutine(AddForceCoroutineEnemy(startPos, endPos));
    }

    IEnumerator AddForceCoroutineEnemy(Vector3 startPos, Vector3 endPos)
    {
        float count = 0;
        float duration = 1;

        while (count < duration)
        {
            Player.Instance.transform.position = Vector3.Lerp(startPos, endPos, count / duration);

            count += Time.deltaTime;
            yield return null;
        }
    }
}
