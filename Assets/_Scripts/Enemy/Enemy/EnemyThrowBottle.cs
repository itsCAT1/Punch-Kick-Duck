using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyThrowBottle : MonoBehaviour
{
    Enemy enemy;

    public GameObject bottleAvatar;
    public Transform bottlePosition;
    public GameObject bottlePrefab;

    private void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    public void PerformThrowBottle()
    {
        enemy.animator.Play("ThrowBottle");

        StartCoroutine(RemoveAttacking());
    }

    public void CreateBottle()
    {
        bottleAvatar.SetActive(false);
        var bottleTemp = Instantiate(bottlePrefab, bottlePosition.position, this.transform.rotation, SpawnManager.Instance.spawnParent);
        SpawnManager.Instance.objectHaveSpawned.Add(bottleTemp);
    }

    IEnumerator RemoveAttacking()
    {
        yield return new WaitForSeconds(0.1f);
        AttackingEnemyManager.Instance.ClearAttackingEnemy(this.gameObject);
    }
}
