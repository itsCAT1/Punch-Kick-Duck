using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushHandler : MonoBehaviour
{

    public void PerformPushPlayer()
    {
        float signX = Mathf.Sign(this.transform.forward.x);
        Player.Instance.receiver.PushBack(signX);
    }

    public void PerformPushBoss()
    {
        float signX = Mathf.Sign(Player.Instance.transform.forward.x);
        Boss.Instance.receiver.PushBack(signX);
    }

    public void DefeatBoss()
    {
        float signX = Mathf.Sign(Player.Instance.transform.forward.x);
        Boss.Instance.receiver.PushDown(signX);
    }
}
