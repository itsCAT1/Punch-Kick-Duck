using UnityEngine;
using Cinemachine;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using DG.Tweening;

public class CameraManager : Singleton<CameraManager>
{
    public GameObject playerCamera;
    public GameObject seletctCamera;
    public GameObject bossCamera;
    public CameraHandler handler;
    public CameraSkinSelector skinSelector;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenuGame);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(OnRestartGame);
        UEventDispatcherSingleton.Instance.AddEventListener<CharactorSelection>(OnCharactorSelection);
        UEventDispatcherSingleton.Instance.AddEventListener<GoLevelBoss>(GoBossArea);

    }

    void InstantFollowPlayer()
    {
        playerCamera.SetActive(true);
        handler.InstantCamera();
    }

    void SmoothFollowPlayer()
    {
        playerCamera.SetActive(true);
        handler.SmoothCamera();
    }
    public void SmoothFollowBoss()
    {
        playerCamera.SetActive(false);
        seletctCamera.SetActive(false);
        handler.SmoothCamera();
    }

    public void OnGameStart()
    {
        CinemachineVirtualCamera cam = playerCamera.GetComponent<CinemachineVirtualCamera>();
        StartCoroutine(SmoothFOV(cam));
        handler.SmoothCamera();
    }

    void OnMenuGame(IUEventData uEventData)
    {
        InstantFollowPlayer();
        seletctCamera.SetActive(false);
        playerCamera.GetComponent<CinemachineVirtualCamera>().m_Lens.FieldOfView = 45;
    }

    void OnCharactorSelection(IUEventData uEventData)
    {
        playerCamera.SetActive(false);
        seletctCamera.SetActive(true);
        handler.InstantCamera();
    }

    void OnRestartGame(IUEventData uEventData)
    {
        InstantFollowPlayer();
    }

    IEnumerator SmoothFOV(CinemachineVirtualCamera cam)
    {
        float duration = 0.3f;
        float elapsed = 0f;

        while (elapsed < duration)
        {
            cam.m_Lens.FieldOfView = Mathf.Lerp(45, 60, elapsed / duration);
            elapsed += Time.deltaTime;
            yield return null;
        }
        cam.m_Lens.FieldOfView = 60;
    }

    void GoBossArea(IUEventData uEventData)
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