using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PerformPushPlayer : MonoBehaviour
{

    public void PerformPush()
    {
        float signX = Mathf.Sign(this.transform.forward.x);
        Player.Instance.push.PlayerIsPushed(signX);
    }
}
