using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeeMovement : MonoBehaviour
{
    public Vector3[] targetPos;
    public float duration;

    public float rotationDuration = 0.5f;
    public float targetAngle;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            PerformMoving();
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

    public void PerformMoving()
    {
        float playerPosX = Player.Instance.transform.position.x;
        float beePosX = transform.position.x;



        if (beePosX > playerPosX)
        {
            targetPos[0] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 4.5f, 0);
            targetPos[1] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 4.5f, 0);
            targetPos[2] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 4.5f, 0);
        }
        else
        {
            targetPos[0] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 4.5f, 0);
            targetPos[1] = new Vector3(playerPosX - 6, Player.Instance.transform.position.y + 4.5f, 0);
            targetPos[2] = new Vector3(playerPosX + 6, Player.Instance.transform.position.y + 4.5f, 0);
        }

        Sequence beeMovementSequence = DOTween.Sequence();

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

}
