using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.PackageManager;
using UnityEngine;

public class PlayerOnTutorial : MonoBehaviour
{
    public float distanceReach;
    public bool isWaiting;

    public bool EnemyInRange()
    {
        if (Player.Instance.detecter.hitInfo.collider == null) return false;

        Collider inforEnemy = Player.Instance.detecter.hitInfo.collider;
        var distance = Vector3.Distance(this.transform.position, inforEnemy.gameObject.transform.position);

        if (distance <= distanceReach && inforEnemy.CompareTag("Enemy"))
        {
            return true;
        }
        else  return false;
    }

    public void UpdatePlayerState()
    {
        if (EnemyInRange())
        {
            if (!isWaiting)
            {
                StartCoroutine(ChangeState());
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
        Player.Instance.executer.SetCurrentState("Idle");

        yield return new WaitForSeconds(3);

        isWaiting = true;
    }
}
