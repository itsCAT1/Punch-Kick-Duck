using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    Rigidbody rigid;
    Animator animator;
    StateManager stateManager;

    public float moveSpeed;
    float inputHorizontal;

    public float punchCoolDown = 0.5f;
    public float resetPunchTime = 1f;
    public float lastPunchTime = 0;
    public bool isPunching = false;
    public bool punchLeft = true;

    public bool isBlocking = false;

    void Start()
    {
        rigid = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        stateManager = gameObject.GetComponent<StateManager>();
    }


    void Update()
    {
        CheckInput();
        FlipCharacter();


    }

    private void FixedUpdate()
    {
        PerformMove();
    }

    void FlipCharacter()
    {
        if (inputHorizontal > 0)
        {
            transform.localScale = new Vector3(1, 1, 1);
        }
        else if (inputHorizontal < 0)
        {
            transform.localScale = new Vector3(1, 1, -1);
        }
    }

    void PerformMove()
    {
        this.rigid.velocity = new Vector3(inputHorizontal * moveSpeed, rigid.velocity.y, rigid.velocity.z);
    }

    void CheckInput()
    {
        inputHorizontal = Input.GetAxisRaw("Horizontal");

        

        if (Input.GetKey(KeyCode.Z))
        {
            PerformPunch();
        }
        
    }

    void PerformPunch()
    {
        if (Time.time - lastPunchTime > resetPunchTime)
        {
            punchLeft = true;
        }

        if (!isPunching)
        {
            isPunching = true;
            if (punchLeft)
            {
                animator.Play("PunchLeft");
            }
            else
            {
                animator.Play("PunchRight");
            }

            punchLeft = !punchLeft;

            lastPunchTime = Time.time;

            Invoke("ResetPunching", punchCoolDown);
        }


    }

    void ResetPunching()
    {
        isPunching = false;
    }
}
