using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushingPlayer : ObjectJumping
{

    public void PlayerIsPushed(Vector3 offset)
    {
        var targetPos = this.transform.position + offset;
        PerformJumping(targetPos);
        StartCoroutine(StartTurnOff());
    }

    public IEnumerator StartTurnOff()
    {
        InGameUIManager.Instance.button.Deactive();

        yield return new WaitForSeconds(1f);

        InGameUIManager.Instance.button.Active();
    }
}
