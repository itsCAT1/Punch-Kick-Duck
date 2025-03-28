using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossPouncing : ObjectPushing
{
    public Vector3 foodCart;
    public Vector3 targetPos;
    int direction;
    public Transform hitPouching;

    public void PerformPounce()
    {
        var signX = Mathf.Sign(this.transform.rotation.y);
        var jumpTarget = this.transform.position + new Vector3(20 * signX, 0, 0);

        PerformJumping(jumpTarget);
    }

    public void SetTarget()
    {
        if (this.transform.position.x > foodCart.x)
        {
            targetPos = new Vector3(265.7f, 108, 0);
        }
        else
        {
            targetPos = new Vector3(269.7f, 108, 0);
        }
    }

    public void RotateTowardCart()
    {
        if (this.transform.position.x > targetPos.x)
        {
            direction = -1;
        }
        else
        {
            direction = 1;
        }
        this.transform.rotation = Quaternion.Euler(0, 90 * direction, 0);
    }

    public void RotateTowardPlayer()
    {
        if (this.transform.position.x > Player.Instance.transform.position.x)
        {
            direction = -1;
        }
        else
        {
            direction = 1;
        }
        this.transform.rotation = Quaternion.Euler(0, 90 * direction, 0);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") && Boss.Instance.controller.isPounching)
        {
            CanDealDamage();
        }
    }
    public void CanDealDamage()
    {
        if (Player.Instance.attackType.type == AttackType.Duck && CombatManager.Instance.playerIsAttacking) return;

        else
        {
            Player.Instance.health.TakeDamage();
            Instantiate(Boss.Instance.attack.hitVFXPrefab, hitPouching.transform.position, Quaternion.identity);
            Boss.Instance.attack.soundHit.Play();
        }
    }
}
