using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushingPlayer : MonoBehaviour
{

    public void PerformPush()
    {
        float signX = Mathf.Sign(this.transform.forward.x);
        Player.Instance.onTakeDamage.PlayerIsPushed(signX);
    }
}
