using System.Collections;
using UnityEngine;

namespace StateTest
{
    public class TestPlayerController : MonoBehaviour
    {
        public StateManager stateManager;

        private IdleState idleState;
        private MovingState movingState;
        private JumpingState jumpingState;
        private AttackingState attackingState;

        public float moveSpeed = 5f;
        public float jumpForce = 7f;
        public bool isGrounded;

        private Rigidbody rb;

        void Start()
        {
            stateManager = this.GetComponent<StateManager>();
            rb = this.GetComponent<Rigidbody>();

            idleState = new IdleState(this);
            movingState = new MovingState(this);
            jumpingState = new JumpingState(this);
            attackingState = new AttackingState(this);

            stateManager.ChangeState(idleState); // Bắt đầu với trạng thái Idle
        }

        void Update()
        {
            CheckGrounded(); // Kiểm tra nhân vật đang ở trên mặt đất hay không
            CheckInput();    // Xử lý các đầu vào
        }

        void CheckGrounded()
        {
            isGrounded = Physics.Raycast(transform.position, Vector3.down, 0.1f);
        }

        void CheckInput()
        {
            if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
            {
                stateManager.ChangeState(jumpingState);
            }
            else if (Input.GetKeyDown(KeyCode.K))
            {
                stateManager.ChangeState(attackingState);
            }
            else if (Input.GetAxisRaw("Horizontal") != 0)
            {
                stateManager.ChangeState(movingState);
            }
            else
            {
                stateManager.ChangeState(idleState);
            }
        }

        public void PerformJump()
        {
            if (rb != null)
            {
                rb.velocity = new Vector3(rb.velocity.x, jumpForce, rb.velocity.z);
            }
        }
    }
}
