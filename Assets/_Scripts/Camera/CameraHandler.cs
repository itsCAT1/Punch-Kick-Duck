using Cinemachine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraHandler : MonoBehaviour
{
    public CinemachineBlendDefinition instantBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0);
    public CinemachineBlendDefinition smoothBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);

    public CinemachineVirtualCamera virtualCamera;
    CinemachineBrain cinemachineBrain;

    void Awake()
    {
        cinemachineBrain = Camera.main.GetComponent<CinemachineBrain>();
    }

    public void SwitchCamera()
    {
        StartCoroutine(CameraTransition());
    }

    IEnumerator CameraTransition()
    {
        CinemachineTransposer transposer = virtualCamera.GetCinemachineComponent<CinemachineTransposer>();
        cinemachineBrain.m_DefaultBlend = instantBlend;
        transposer.m_XDamping = 0;
        transposer.m_YDamping = 0;
        transposer.m_ZDamping = 0;

        yield return new WaitForSeconds(0.1f);

        cinemachineBrain.m_DefaultBlend = smoothBlend;
        transposer.m_XDamping = 0;
        transposer.m_YDamping = 1;
        transposer.m_ZDamping = 0;
    }
}

