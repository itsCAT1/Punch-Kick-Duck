using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyApear : ObjectJumping
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            Debug.Log("jump");
            animator.Play("Jump");

            var targetPos = this.transform.position + new Vector3(0f, 0f, -6.5f);
            PerformJumping(targetPos);
        }
    }
}
