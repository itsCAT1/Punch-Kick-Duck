using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniBossAttack : MonoBehaviour
{
    PushHandler pushPlayer;
    public GameObject hitVFXPrefab;
    public Transform hitPosition;

    void Start()
    {
        pushPlayer = GetComponent<PushHandler>();
    }

    public void PerformAttack()
    {
        MiniBoss.Instance.animator.Play("Attack");
    }

    public void DealDamage()
    {
        Player.Instance.health.TakeDamage();

        pushPlayer.PerformPushPlayer();
        CreateHitEffect();
    }

    public void CreateHitEffect()
    {
        Instantiate(hitVFXPrefab, hitPosition.position, Quaternion.identity);
    }
}
