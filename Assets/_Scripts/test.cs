using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour
{
    public enum PlayerState { Idle, Walking, Punching, Kicking, Ducking, Knocking, Wining }
    public PlayerState state;
    public bool stateComplete = true;

    Rigidbody rb;
    Animator animator;

    public float speed;
    float xInput;



    void Start()
    {
        rb = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }


    void Update()
    {
        CheckState();
        UpdateState();
    }

    private void FixedUpdate()
    {
        Moving();
    }

    void Moving()
    {
        xInput = Input.GetAxisRaw("Horizontal");
        this.transform.position += transform.forward * xInput * speed * Time.deltaTime;

        FlipCharacter();
    }

    void FlipCharacter()
    {
        if (xInput > 0)
        {
            transform.localScale = new Vector3(1, 1, 1);
        }
        else if (xInput < 0)
        {
            transform.localScale = new Vector3(1, 1, -1);
        }
    }

    //Kiem tra trang thai player
    void CheckState()
    {
        if (stateComplete)
        {
            CheckInput();
        }
    }

    //Kiem tra nguoi choi bam phim
    void CheckInput()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            state = PlayerState.Punching;
            StartPunching();
        }

        else if (Input.GetKeyDown(KeyCode.X))
        {
            state = PlayerState.Kicking;
            StartKicking();
        }

        else if (Input.GetKeyDown(KeyCode.C))
        {
            state = PlayerState.Ducking;
            StartDucking();
        }

        else if (xInput != 0)
        {
            state = PlayerState.Walking;
            StartWalking();
        }

        else
        {
            state = PlayerState.Idle;
            StartIdle();
        }
    }

    //Bat animation
    void StartIdle()
    {
        animator.Play("Idle");
    }

    void StartWalking()
    {
        animator.Play("Walk");
    }

    void StartPunching()
    {
        animator.Play("PunchLeft");
    }

    void StartKicking()
    {
        animator.Play("Kick");
    }

    void StartDucking()
    {
        animator.Play("Duck");
    }

    //Cap nhat trang thai cua player
    void UpdateState()
    {
        switch (state)
        {
            case PlayerState.Idle:
                UpdateIdle();
                break;
            case PlayerState.Walking:
                UpdateWalking();
                break;
            case PlayerState.Punching:
                StartCoroutine(UpdatePunching());
                break;
            case PlayerState.Kicking:
                StartCoroutine(UpdateKicking());
                break;
            case PlayerState.Ducking:
                StartCoroutine(UpdateDucking());
                break;
        }
    }

    //Kiem tra dieu kien ket thuc animation
    void UpdateIdle()
    {
        if (xInput != 0)
        {
            stateComplete = true;
        }
    }

    void UpdateWalking()
    {
        if (xInput == 0)
        {
            stateComplete = false;
        }
    }

    IEnumerator UpdatePunching()
    {
        stateComplete = false;
        speed = 0;
        yield return new WaitForSeconds(0.2f);
        speed = 5;
        stateComplete = true;
    }

    IEnumerator UpdateKicking()
    {
        stateComplete = false;
        speed = 0;
        yield return new WaitForSeconds(0.4f);
        speed = 5;
        stateComplete = true;
    }

    IEnumerator UpdateDucking()
    {
        stateComplete = false;
        speed = 0;
        yield return new WaitForSeconds(0.2f);
        speed = 5;
        stateComplete = true;
    }
}


