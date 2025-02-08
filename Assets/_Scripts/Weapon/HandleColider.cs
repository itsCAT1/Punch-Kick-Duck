using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HandleColider : MonoBehaviour
{
    Rigidbody rigid;
    PushingPlayer pushPlayer;

    public string attackType;
    public float forcePush;


    private void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        pushPlayer = GetComponentInParent<PushingPlayer>();
    }

    public void IsThrownOut()
    {
        Vector3 pushDirection = new Vector3(0, 6, -3).normalized;
        rigid.AddForce(pushDirection * forcePush, ForceMode.Impulse);
    }

    public void PlayerOnHit()
    {
        Player.Instance.health.TakeDamage();
        pushPlayer.PerformPush();
    }

    public void ObjectOnHit()
    {
        rigid.useGravity = true;
        IsThrownOut();
    }

    public IEnumerator DestroyObject()
    {
        yield return new WaitForSeconds(2);
        Destroy(gameObject);
    }
}
