using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyApear : ObjectPushing
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();

        PerformJump();
    }

    public void PerformJump()
    {
        animator.Play("Jump");

        var targetPos = this.transform.position + new Vector3(0f, 0f, -6.5f);

        PerformJumping(targetPos);
    }

    private void OnDestroy()
    {
        DOTween.Kill(this.transform);
    }
}
