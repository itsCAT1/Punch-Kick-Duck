using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColliderHandler : ObjectPushing
{
    PushHandler pushPlayer;

    public string attackType;


    private void Awake()
    {
        pushPlayer = GetComponentInParent<PushHandler>();
    }
        
    public void PlayerOnHit()
    {
        Player.Instance.health.TakeDamage();
        pushPlayer.PerformPushPlayer();
    }

    public void ObjectOnHit()
    {
        var currentPosition = this.transform.position;
        var targetPos = new Vector3(currentPosition.x, currentPosition.y - 3, currentPosition.z - 5);
        PerformJumping(targetPos);
        SelfDestroy();
    }

    public void SelfDestroy()
    {
        Destroy(gameObject, 2);
    }
}
