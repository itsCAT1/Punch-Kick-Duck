using DG.Tweening;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ForceReceiver : MonoBehaviour
{
    Rigidbody rigid;
    public Vector3 offset;
    public float speed;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
    }

    public void PushBack(float direction)
    {
        this.rigid.velocity = Vector3.zero;
        rigid.AddForce(new Vector3(offset.x * direction, offset.y, offset.z), ForceMode.VelocityChange);
    }

    public void PushDown(float direction)
    {
        Time.timeScale = 0.5f;

        var targetPos = this.transform.position + new Vector3(4 * direction, 0, 0);
        this.transform.DOJump(targetPos, 1, 1, 0.5f).OnComplete(() =>
        {
            UEventData uEventData = new UEventData();
            UEventDispatcherSingleton.Instance.Invoke<EndGameBoss>(uEventData);
            Time.timeScale = 1f;
        });
    }
}
