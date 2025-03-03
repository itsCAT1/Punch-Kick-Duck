using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.PackageManager;
using UnityEngine;

public class PlayerOnTutorial : MonoBehaviour
{
    public float distanceReach;
    public float duration;

    public bool canWait;

    public bool isWaiting;
    bool isChangingState = false;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<Tutorial>(OnReset);
    }

    public bool EnemyInRange()
    {
        if (Player.Instance.detecter.hitInfo.collider == null) return false;

        Collider inforEnemy = Player.Instance.detecter.hitInfo.collider;
        var distance = Vector3.Distance(this.transform.position, inforEnemy.gameObject.transform.position);

        if (distance <= distanceReach && inforEnemy.CompareTag("Enemy"))
        {
            return true;
        }
        else return false;
    }

    public void UpdatePlayerState()
    {
        if (canWait)
        {
            Player.Instance.executer.SetCurrentState("Idle");
            return;
        }

        if (EnemyInRange())
        {
            if (!isWaiting)
            {
                if(!isChangingState) StartCoroutine(ChangeState());

                return;
            }

            Player.Instance.executer.SetCurrentState("Walk");
        }
        else
        {
            Player.Instance.executer.SetCurrentState("Walk");
        }
    }

    IEnumerator ChangeState()
    {
        isChangingState = true;
        Player.Instance.attack.canAttack = false;

        Player.Instance.executer.SetCurrentState("Idle");

        yield return new WaitForSeconds(duration);

        Player.Instance.attack.canAttack = true;
        isWaiting = true;
        isChangingState = false; 
    }

    void OnReset(IUEventData uEventData)
    {
        canWait = false;
        isWaiting = false;
        isChangingState = false; 
    }
}
