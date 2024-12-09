using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    Rigidbody rb;
    Animator animator;

    public float moveSpeed;
    float inputHorizontal;

    public float punchCoolDown = 0.5f;
    public float punchTimeCycle = 1f;
    private float lastPunchTime = 0;
    public bool isPunching = false;
    public bool punchLeft = false;

    public bool isBlocking = false;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }


    void Update()
    {
        PerformMove();

        CheckInput();
    }


    void PerformMove()
    {
        inputHorizontal = Input.GetAxisRaw("Horizontal");
        this.transform.position += transform.forward * inputHorizontal * moveSpeed * Time.deltaTime;

        FlipCharacter();
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

    //Kiem tra nguoi choi bam phim
    void CheckInput()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            PerformPunch();
        }

        if (Input.GetKeyDown(KeyCode.X))
        {
            PerformKick();
        }
    }

    void PerformPunch()
    {
        if (Time.time - lastPunchTime > punchTimeCycle)
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

    void PerformKick()
    {
        animator.Play("Kick");
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Hand") && !isBlocking)
        {
            StartCoroutine(BlockDamage());
        }
    }

    IEnumerator BlockDamage()
    {
        isBlocking = true;
        Time.timeScale = 0;
        yield return new WaitForSecondsRealtime(1);
        Time.timeScale = 1;
        isBlocking = false;
    }
}
