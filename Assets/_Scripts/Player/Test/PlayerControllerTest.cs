using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FSMC.Runtime;

public class PlayerControllerTest : MonoBehaviour
{
        Rigidbody rigid;
        public Animator animator;

        public float moveSpeed;
        public int facingDirection = 1;

        public float inputHorizontal;
        public FSMC_Executer executer;

        void Awake()
        {
            rigid = GetComponent<Rigidbody>();
            animator = GetComponent<Animator>();
            executer.SetCurrentState("Idle");
    }

        void Update()
        {
            FlipCharacter();
            if (inputHorizontal != 0) executer.SetCurrentState("Walk");
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
}
