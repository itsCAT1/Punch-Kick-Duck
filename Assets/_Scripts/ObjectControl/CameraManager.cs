using UnityEngine;
using Cinemachine;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using Cinemachine.Editor;

public class CameraManager : Singleton<CameraManager>
{
    public GameObject playerCamera;
    public GameObject bossCamera;

    public CinemachineBlendDefinition instantBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0);
    public CinemachineBlendDefinition smoothBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f); 

    private CinemachineBrain cinemachineBrain;

    private void Start()
    {
        cinemachineBrain = Camera.main.GetComponent<CinemachineBrain>();

        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(OnGameStart);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenuGame);
        UEventDispatcherSingleton.Instance.AddEventListener<CharactorSelection>(OnCharactorSelection);
        UEventDispatcherSingleton.Instance.AddEventListener<GoLevelBoss>(GoBossArea);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<MenuGame>(uEventData);
    }

    public void InstantCamera()
    {
        cinemachineBrain.m_DefaultBlend = instantBlend;
    }

    public void SmoothCamera()
    {
        cinemachineBrain.m_DefaultBlend = smoothBlend;
    }

    void InstantFollowPlayer()
    {
        playerCamera.SetActive(true);
        InstantCamera();
    }

    void SmoothFollowPlayer()
    {
        playerCamera.SetActive(true);
        SmoothCamera();
    }

    void OnGameStart(IUEventData uEventData)
    {
        playerCamera.GetComponent<CinemachineVirtualCamera>().m_Lens.FieldOfView = 60;
    }

    void OnMenuGame(IUEventData uEventData)
    {
        InstantFollowPlayer();
        playerCamera.GetComponent<CinemachineVirtualCamera>().m_Lens.FieldOfView = 45;
    }

    void OnCharactorSelection(IUEventData uEventData)
    {
        InstantFollowPlayer();
    }

    public void SmoothFollowBoss()
    {
        playerCamera.SetActive(false);
        SmoothCamera();
    }

    public void GoBossArea(IUEventData uEventData)
    {
        StartCoroutine(MoveToBossAreaCoroutine());
    }

    IEnumerator MoveToBossAreaCoroutine()
    {
        SmoothFollowBoss();
        yield return new WaitForSeconds(3);
        SmoothFollowPlayer();
        yield return new WaitForSeconds(3);
        CombatManager.Instance.inBossArea = true;
    }
}