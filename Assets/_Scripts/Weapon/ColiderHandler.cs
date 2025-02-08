using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColiderHandler : ObjectPushing
{
    Rigidbody rigid;
    PushingPlayer pushPlayer;

    public string attackType;


    private void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        pushPlayer = GetComponentInParent<PushingPlayer>();
    }
        
    public void PlayerOnHit()
    {
        Player.Instance.health.TakeDamage();
        pushPlayer.PerformPush();
    }

    public void ObjectOnHit()
    {
        var currentPosition = this.transform.position;
        var targetPos = new Vector3(currentPosition.x, currentPosition.y - 3, currentPosition.z - 5);
        PerformJumping(targetPos);
    }

    public IEnumerator DestroyObject()
    {
        yield return new WaitForSeconds(2);
        Destroy(gameObject);
    }
}
