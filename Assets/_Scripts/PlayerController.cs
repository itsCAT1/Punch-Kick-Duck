using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public enum PlayerState
    {
        Idle,
        Walking,
        Punching,
        Kicking,
        Ducking,
        KnockedDown,
        GettingUp,
        Winning
    }
    public PlayerState state;

    public bool stateComplete = true; 

    Rigidbody rb;
    Animator animator;

    public float speed;

    float xInput;

    int isTouched = 0;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }

    void Update()
    {
        CheckState();

        Moving();
        UpdateState();
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

    void CheckState()
    {
        if (stateComplete)
        {
            CheckInput();
        }
    }

    void CheckInput()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            state = PlayerState.Punching;
            StartPunching();
            return;
        }

        else if (Input.GetKeyDown(KeyCode.X))
        {
            state = PlayerState.Kicking;
            StartKicking();
            return;
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
        }
    }


    void StartIdle()
    {
        animator.Play("Idle");
        Debug.Log("Idle");
    }

    void StartWalking()
    {
        animator.Play("Walk");
        Debug.Log("Walk");
    }

    void StartPunching()
    {
        stateComplete = false; 
        
        Debug.Log("PunchLeft");
    }

    void StartKicking()
    {
        stateComplete = false;
        animator.Play("Kick");
        Debug.Log("Kick");
    }

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
            stateComplete = true;
        }
    }

    void InputPunch()
    {
        if(isTouched == 0)
        {
            isTouched = 1;
            animator.Play("PunchLeft");
        }
        else if (isTouched == 1)
        {
            isTouched = 0;
            animator.Play("PunchRight");
        }
    }

    IEnumerator UpdatePunching()
    {
        yield return new WaitForSeconds(0.2f);
        Debug.Log("ket thuc");
        stateComplete = true;
    }

    IEnumerator CountTouched()    
    {
        yield return new WaitForSeconds(1f);
        isTouched = 0;
    }

    IEnumerator UpdateKicking()
    {
        yield return new WaitForSeconds(0.4f); 
        stateComplete = true;
    }
}
