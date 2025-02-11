using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class BeeAttack : MonoBehaviour
{
    public Vector3[] targetPos;
    public float duration;

    public float rotationDuration = 0.5f;
    public float angle;
    public float targetAngle;
    
    Sequence beeMovementSequence;
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            PerformAttack();
        }

        if (Input.GetKeyDown(KeyCode.X))
        {
            EnemyIsBeaten();
        }

        if (transform.position.x < Player.Instance.transform.position.x)
        {
            targetAngle = 180;
        }

        else
        {
            targetAngle = 0;
        }
    }

    public void PerformAttack()
    {
        float playerPosX = Player.Instance.transform.position.x;
        float beePosX = transform.position.x;

        if (beePosX > playerPosX)
        {
            targetPos[0] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 4.5f, 0);
            targetPos[1] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 2f, 0);
            targetPos[2] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 2f, 0);
            targetPos[3] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 4.5f, 0);
        }
        else
        {
            targetPos[0] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 4.5f, 0);
            targetPos[1] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 2f, 0);
            targetPos[2] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 2f, 0);
            targetPos[3] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 4.5f, 0);
        }

        transform.DOKill(this.transform);
        beeMovementSequence = DOTween.Sequence();

        foreach (var pos in targetPos)
        {
            beeMovementSequence.AppendCallback(() =>
            {
                float currentAngle = transform.rotation.eulerAngles.y;
                if (currentAngle != targetAngle)
                {
                    transform.DORotate(new Vector3(0, targetAngle, 0), rotationDuration, RotateMode.Fast);
                }
            });

            beeMovementSequence.Append(transform.DOMove(pos, duration));
        }
    }

    public void EnemyIsBeaten()
    {
        if (beeMovementSequence != null)
        {
            beeMovementSequence.Kill();
        }

        var targetPos = this.transform.position + new Vector3(-2, -5, -3);
        transform.DOJump(targetPos, 5, 1, 0.5f);
    }
}
