using Cinemachine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraHandler : MonoBehaviour
{
    public CinemachineBlendDefinition instantBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0);
    public CinemachineBlendDefinition smoothBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);
    
    private CinemachineBrain cinemachineBrain;
    public CinemachineVirtualCamera virtualCamera;
    void Awake()
    {
        cinemachineBrain = Camera.main.GetComponent<CinemachineBrain>();
    }

    public void InstantCamera()
    {
        cinemachineBrain.m_DefaultBlend = instantBlend;
    }

    public void SmoothCamera()
    {
        cinemachineBrain.m_DefaultBlend = smoothBlend;
    }

}
