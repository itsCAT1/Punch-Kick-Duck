using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    Rigidbody rigid;
    public Animator animator;

    public Transform body;
    public float moveSpeed;
    public int facingDirection = 1;
    
    public float inputHorizontal;
    public FSMC_Executer executer;
    
    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }

    void Update()
    {
        FlipCharacter();
    }

    private void FixedUpdate()
    {
        PerformMove();
    }

    void FlipCharacter()
    {
        body.transform.localScale = new Vector3(1, 1, facingDirection);
    }

    void PerformMove()
    {
        inputHorizontal = Input.GetAxisRaw("Horizontal");
        this.rigid.velocity = new Vector3(moveSpeed, rigid.velocity.y, rigid.velocity.z);
    }

    public void ChangeDirection(int direction)
    {
        facingDirection = direction;
    }
}
