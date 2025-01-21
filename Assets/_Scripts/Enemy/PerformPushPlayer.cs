using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PerformPushPlayer : MonoBehaviour
{

    public void PerformPush()
    {
        float signX = Mathf.Sign(this.transform.forward.x);
        Vector3 offset = new Vector3(3 * signX, 0, 0);
        Player.Instance.push.PlayerIsPushed(offset);
    }
}
