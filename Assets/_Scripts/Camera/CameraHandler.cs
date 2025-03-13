using Cinemachine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraHandler : MonoBehaviour
{
    public CinemachineBlendDefinition instantBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0);
    public CinemachineBlendDefinition smoothBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);

    public CinemachineVirtualCamera virtualCameraPlayer;
    public CinemachineVirtualCamera virtualCameraBoss;
    public CinemachineVirtualCamera virtualCameraAdjustTouch;

    CinemachineBrain cinemachineBrain;

    public float followOffsetZ, camX, camW;

    public int borderValue = 0;

    void Awake()
    {
        cinemachineBrain = Camera.main.GetComponent<CinemachineBrain>();
    }

    private void Start()
    {
        InitDataCameraPlayer();
        CameraMenu();
    }

    void InitDataCameraPlayer()
    {
        UpdateScreenBorder(DataManager.Instance.data.screenBorder);
        UpdateFO(DataManager.Instance.data.screenBorder);
    }

    public void SwitchCamera()
    {
        StartCoroutine(CameraTransition());
    }

    IEnumerator CameraTransition()
    {
        CinemachineTransposer transposer = virtualCameraPlayer.GetCinemachineComponent<CinemachineTransposer>();
        cinemachineBrain.m_DefaultBlend = instantBlend;
        transposer.m_XDamping = 0;
        transposer.m_YDamping = 0;
        transposer.m_ZDamping = 0;

        yield return new WaitForSeconds(0.3f);

        cinemachineBrain.m_DefaultBlend = smoothBlend;
        transposer.m_XDamping = 0;
        transposer.m_YDamping = 1;
        transposer.m_ZDamping = 0;
    }
    
    public void UpdateScreenBorder(int value)
    {
        var cam = Camera.main.rect;

        cam.x = 0;
        cam.x += value * 0.025f;

        cam.width = 1;
        cam.width -= value * 0.05f;

        Camera.main.rect = cam;

        camX = cam.x;
        camW = cam.width;
    }

    public void UpdateFO(int value)
    {
        UpdateFO(virtualCameraPlayer, value);
        UpdateFO(virtualCameraBoss, value);
        UpdateFO(virtualCameraAdjustTouch, value);
    }

    public void UpdateFO(CinemachineVirtualCamera virtualCamera, int value)
    {
        CinemachineTransposer transposer = virtualCamera.GetCinemachineComponent<CinemachineTransposer>();

        transposer.m_FollowOffset.z = -10;

        transposer.m_FollowOffset.z -= value * 0.5f;

        followOffsetZ = transposer.m_FollowOffset.z;
    }

    public void CameraMenu()
    {
        var cam = Camera.main.rect;
        cam.x = 0;
        cam.width = 1;
        Camera.main.rect = cam;

        CinemachineTransposer transposer = virtualCameraPlayer.GetCinemachineComponent<CinemachineTransposer>();

        transposer.m_FollowOffset.z = -10;
    }


    public void OnStartGame()
    {
        StartCoroutine(SmoothChangeCamera(virtualCameraPlayer));
    }

    IEnumerator SmoothChangeCamera(CinemachineVirtualCamera camVirtual)
    {
        float duration = 0.3f;
        float elapsed = 0f;

        CinemachineTransposer transposer = camVirtual.GetCinemachineComponent<CinemachineTransposer>();
        Rect cam = Camera.main.rect;


        while (elapsed < duration)
        {
            camVirtual.m_Lens.FieldOfView = Mathf.Lerp(40, 60, elapsed / duration);
            transposer.m_FollowOffset.z = Mathf.Lerp(-10, followOffsetZ, elapsed / duration);
            cam.x = Mathf.Lerp(0, camX, elapsed / duration);
            cam.width = Mathf.Lerp(1, camW, elapsed / duration);

            Camera.main.rect = cam;

            elapsed += Time.deltaTime;
            yield return null;
        }

        camVirtual.m_Lens.FieldOfView = 60;
        transposer.m_FollowOffset.z = followOffsetZ;
        cam.x = camX;
        cam.width = camW;
        Camera.main.rect = cam;
    }
}

