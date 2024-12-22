using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace StateTest
{
    public class IdleState : IState
    {
        private PlayerController controller;

        public IdleState(PlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            
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
        private PlayerController controller;

        public MovingState(PlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            Debug.Log("Moving Enter State");
        }

        public void Execute()
        {
            
        }

        public void Exit()
        {
            Debug.Log("Moving Exit State");
        }
    }

    public class AttackingState : IState
    {
        private PlayerController controller;

        public AttackingState(PlayerController controller)
        {
            this.controller = controller;
        }

        public void Enter()
        {
            

        }

        public void Execute()
        {
            
        }

        public void Exit()
        {
            Debug.Log("Attacking Exit State");
        }

    }

}


