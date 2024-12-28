using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    Rigidbody rigid;
    public Animator animator;
    StateManager stateManager;

    public float moveSpeed;
    public int facingDirection = 1;
    
    public float inputHorizontal;

    public Transform handPos;
    public float sizeHand;

    void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        stateManager = gameObject.GetComponent<StateManager>();
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
        this.transform.localScale = new Vector3(1, 1, facingDirection);
    }

    void PerformMove()
    {
        inputHorizontal = Input.GetAxisRaw("Horizontal");
        this.rigid.velocity = new Vector3(moveSpeed, rigid.velocity.y, rigid.velocity.z);
    }

    public void ChangeSpeed(int speed)
    {
        moveSpeed = speed;
        Debug.Log(speed);
    }

    public void ChangeDirection(int direction)
    {
        facingDirection = direction;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawSphere(handPos.position, sizeHand);
    }
}
