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
    public Transform ray;
    void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        stateManager = gameObject.GetComponent<StateManager>();
        Player.Instance.stateManager.ChangeState(new PlayerIdleState());
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
        this.rigid.velocity = new Vector3(moveSpeed * inputHorizontal, rigid.velocity.y, rigid.velocity.z);
    }

    public void ChangeDirection(int direction)
    {
        facingDirection = direction;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawRay(ray.transform.position, ray.transform.forward * 2);
    }
}
