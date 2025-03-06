using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColliderHandler : ObjectPushing
{
    PushHandler pushPlayer;

    public AttackType attackType;

    public GameObject hitVFXPrefab;
    public Transform hitPosition;

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
        var targetPos = new Vector3(currentPosition.x, currentPosition.y - 4, currentPosition.z - 5);
        PerformJumping(targetPos);
        CreateHitEffect();
        SelfDestroy();
    }

    public void SelfDestroy()
    {
        Destroy(gameObject, 2);
    }

    public void CreateHitEffect()
    {
        Instantiate(hitVFXPrefab, hitPosition.position, Quaternion.identity);
    }
}
