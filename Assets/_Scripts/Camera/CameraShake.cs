using Cinemachine;
using UnityEngine;

public class CameraShake : Singleton<CameraShake>
{
    CinemachineVirtualCamera virtualCamera;
    public float shakeIntensity;
    public float shakeTime;
    public float shakeTimer;

    private void Start()
    {
        virtualCamera = GetComponent<CinemachineVirtualCamera>();
    }

    private void Update()
    {
        UpdateShake();
    }

    public void UpdateShake()
    {
        if (shakeTimer > 0)
        {
            shakeTimer -= Time.deltaTime;

            var transposer = virtualCamera.GetCinemachineComponent<CinemachineTransposer>();
            transposer.m_FollowOffset.y += shakeIntensity;

            if (shakeTimer <= 0)
            {
                transposer.m_FollowOffset.y = 4;
            }
        }
    }
}
