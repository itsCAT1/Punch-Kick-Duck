using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    Rigidbody rigid;
    public Animator anim;
    StateManager stateManager;

    public float moveSpeed;
    public int facingDirection = 1;
    
    bool isBlocking = false;

    void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        anim = GetComponent<Animator>();
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
}
