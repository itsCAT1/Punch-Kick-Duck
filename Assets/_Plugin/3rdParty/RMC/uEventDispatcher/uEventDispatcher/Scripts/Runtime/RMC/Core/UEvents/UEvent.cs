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
    public class StatusPlayerHurt : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class StatusPlayerDead : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }

    [Serializable]
    public class OnValueHeartChange : UnityEvent<IUEventData>, IUEvent
    {
        public void InvokeNull()
        {
            this.Invoke(null);
        }
    }
}