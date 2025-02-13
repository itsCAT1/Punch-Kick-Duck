using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyMovement : MonoBehaviour
{
    Enemy enemy;
    public float moveSpeed;

    private void Start()
    {
        enemy = GetComponent<Enemy>();
    }

    public void PerformMove()
    {
        var direction = (Player.Instance.transform.position - transform.position).normalized;
        transform.rotation = Quaternion.LookRotation(direction);

        enemy.rigid.velocity = direction * moveSpeed;
    }
}
