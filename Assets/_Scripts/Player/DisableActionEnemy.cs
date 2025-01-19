using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DisableActionEnemy : MonoBehaviour
{

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Enemy"))
        {
            var action = other.GetComponent<EnemyActionManager>();
            //StartCoroutine(StartDisableAction(action));
            DisableAction(action);
            Invoke(nameof(EnableAction), 2);
        }
    }

    void DisableAction(EnemyActionManager action)
    {
        Debug.Log("disable");
        action.DisableAction();
    }

    void EnableAction(EnemyActionManager action)
    {
        Debug.Log("enable");
        action.EnableAction();
    }

    IEnumerator StartDisableAction(EnemyActionManager action)
    {
        this.gameObject.SetActive(false);
        action.DisableAction();
        yield return new WaitForSecondsRealtime(2f);
        action.EnableAction();
    }
}
