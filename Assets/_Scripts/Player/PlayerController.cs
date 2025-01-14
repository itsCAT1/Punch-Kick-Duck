using FSMC.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public Rigidbody rigid;
    public Animator animator;

    public Transform body;
    public float moveSpeed;
    public int facingDirection = 1;
    
    public float inputHorizontal;
    public FSMC_Executer executer;

    
    void Start()
    {
        rigid = GetComponent<Rigidbody>();
    }

    private void FixedUpdate()
    {
        
    }

    void PerformMove()
    {
        inputHorizontal = Input.GetAxisRaw("Horizontal");
        this.rigid.velocity = new Vector3(moveSpeed * rigid.velocity.x, rigid.velocity.y, rigid.velocity.z);
    }

    public void ChangeDirection(int direction)
    {
        facingDirection = direction;
    }

    private void Update()
    {
        FlipCharacter();
    }

    void FlipCharacter()
    {
        Player.Instance.transform.localScale = new Vector3(1, 1, facingDirection);
    }
}
