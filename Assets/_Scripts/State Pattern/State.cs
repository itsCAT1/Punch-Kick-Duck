using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace StateTest
{
    public class IdleState : IState
    {
        private TestPlayerController controller;

        public IdleState(TestPlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            Debug.Log("Idle Enter State");
        }

        public void Execute()
        {
            Debug.Log("Idle Execute State");
        }

        public void Exit()
        {
            Debug.Log("Idle Exit State");
        }
    }

    public class MovingState : IState
    {
        private TestPlayerController controller;

        public MovingState(TestPlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            Debug.Log("Moving Enter State");
        }

        public void Execute()
        {
            float inputHorizontal = Input.GetAxisRaw("Horizontal");
            controller.transform.position += controller.transform.forward * inputHorizontal * controller.moveSpeed * Time.deltaTime;
        }

        public void Exit()
        {
            Debug.Log("Moving Exit State");
        }
    }

    public class JumpingState : IState
    {
        private TestPlayerController controller;

        public JumpingState(TestPlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            Debug.Log("Jumping Enter State");
            controller.PerformJump();
        }

        public void Execute()
        {
            if (controller.isGrounded)
            {
                controller.stateManager.ChangeState(new IdleState(controller));
            }
        }

        public void Exit()
        {
            Debug.Log("Jumping Exit State");
        }
    }

    public class AttackingState : IState
    {
        private TestPlayerController controller;
        private bool isAttacking;

        public AttackingState(TestPlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            Debug.Log("Attacking Enter State");
            isAttacking = true;

            // Thực hiện tấn công (bạn có thể thêm hoạt ảnh tại đây)
            controller.StartCoroutine(Attack());
        }

        public void Execute()
        {
            // Trạng thái đánh sẽ quay về Idle sau khi hoàn tất
        }

        public void Exit()
        {
            Debug.Log("Attacking Exit State");
        }

        private IEnumerator Attack()
        {
            // Thời gian thực hiện đòn đánh (giả định là 0.5 giây)
            yield return new WaitForSeconds(0.5f);
            isAttacking = false;

            // Quay lại trạng thái phù hợp
            if (controller.isGrounded)
            {
                controller.stateManager.ChangeState(new IdleState(controller));
            }
            else
            {
                controller.stateManager.ChangeState(new JumpingState(controller));
            }
        }
    }

}


