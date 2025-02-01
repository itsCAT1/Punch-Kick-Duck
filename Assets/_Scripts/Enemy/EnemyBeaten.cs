using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyBeaten : ObjectJumping
{
    public Vector3 offset;
    Rigidbody rigid;
    public float dropChance = 0.3f;
    public GameObject coinPrefab;

    EnemyActionManager enemyActionManager;

    private void Start()
    {
        rigid = GetComponent<Rigidbody>();
        enemyActionManager =GetComponent<EnemyActionManager>();
    }

    public void EnemyIsBeaten()
    {
        enemyActionManager.DisableAction();
        rigid.isKinematic = false;
        RandomDropCoin();

        float signX = Mathf.Sign(transform.forward.x);
        var targetPos = this.transform.position + new Vector3(offset.x * signX, offset.y, offset.z);
        PerformJumping(targetPos);
    }

    void RandomDropCoin()
    {
        float randomValue = Random.value;
        if (randomValue <= dropChance)
        {
            SpawnCoin();
        }
    }
    void SpawnCoin()
    {
        Instantiate(coinPrefab, this.transform.position, Quaternion.Euler(90, 0, 0));
    }
}
