using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyThrowBottle : MonoBehaviour
{
    Animator animator;
    EnemyController enemyController;

    public GameObject bottleAvatar;
    public Transform bottlePosition;
    public GameObject bottlePrefab;
    bool onAttack = false;

    private void Start()
    {
        animator = GetComponent<Animator>();
        enemyController = GetComponent<EnemyController>();
    }

    public void PerformThrowBottle()
    {
        if (!onAttack)
        {
            animator.Play("ThrowBottle");
        }

        //StartCoroutine(TimeToChangeAttack(2));
    }

    public void CreateBottle()
    {
        bottleAvatar.SetActive(false);
        Instantiate(bottlePrefab, bottlePosition.position, this.transform.rotation);
    }

    IEnumerator TimeToChangeAttack(float time)
    {
        onAttack = true;
        yield return new WaitForSeconds(time);

        enemyController.haveBottle = false;
    }
}
