using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class MiniBossController : MonoBehaviour
{
    public float attackRange;
    public bool canAttack;
    public AudioSource roarSound;

    void Update()
    {
        UpdateAction();
    }

    private void OnEnable()
    {
        roarSound.Play();
    }

    void UpdateAction()
    {
        if (!canAttack || MiniBoss.Instance.executer.GetCurrentState() == null) return;

        float distance = Vector3.Distance(transform.position, Player.Instance.transform.position);

        if (distance < attackRange - 0.5f)
        {
            MiniBoss.Instance.executer.SetCurrentState("Attack");
        }
        else if (distance > attackRange + 0.5f)
        {
            MiniBoss.Instance.executer.SetCurrentState("Walk");
        }

        UpdateIntensityCamera(distance);
    }

    void UpdateIntensityCamera(float distance)
    {
        if (distance < 15)
        {
            CameraShake.Instance.shakeIntensity = 0.01f;
        }
        else
        {
            CameraShake.Instance.shakeIntensity = 0.005f;
        }
    }

    public void ShakeCamera()
    {
        CameraShake.Instance.shakeTimer = CameraShake.Instance.shakeTime;
    }
}
