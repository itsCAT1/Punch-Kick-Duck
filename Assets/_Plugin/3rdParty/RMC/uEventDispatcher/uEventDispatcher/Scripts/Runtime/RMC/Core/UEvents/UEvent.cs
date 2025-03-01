using RMC.Core.UEvents.Assets;
using System;
using UnityEngine.Events;

namespace RMC.Core.UEvents
{
   [Serializable]
   public class UEvent : UnityEvent<IUEventData>, IUEvent
   {
      public void InvokeNull()
      {
         this.Invoke(null);
      }
   }

    [Serializable]
    public class PlayerHurt : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class PlayerDeath : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class PlayerBlocking : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class StartGame : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class InGame : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class EndGame : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }


    [Serializable]
    public class GameOver : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class PauseGame : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class RestartGame : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }


    [Serializable]
    public class LevelTransition : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class LevelSelection : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class GoLevelBoss : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class EndGameBoss : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class MenuGame : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class CharactorSelection : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class Tutorial : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }
}