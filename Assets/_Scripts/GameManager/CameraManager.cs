using UnityEngine;
using Cinemachine;
using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using DG.Tweening;
using Cinemachine.Editor;

public class CameraManager : Singleton<CameraManager>
{
    public GameObject playerCamera;
    public GameObject bossCamera;
    public CameraHandler handler;

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(OnGameStart);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenuGame);
        UEventDispatcherSingleton.Instance.AddEventListener<CharactorSelection>(OnCharactorSelection);
        UEventDispatcherSingleton.Instance.AddEventListener<GoLevelBoss>(GoBossArea);

        UEventData uEventData = new UEventData();
        UEventDispatcherSingleton.Instance.Invoke<MenuGame>(uEventData);

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
        handler.SmoothCamera();
    }

    void OnGameStart(IUEventData uEventData)
    {
        CinemachineVirtualCamera cam = playerCamera.GetComponent<CinemachineVirtualCamera>();
        StartCoroutine(SmoothFOV(cam));
        handler.SmoothCamera();
    }

    void OnMenuGame(IUEventData uEventData)
    {
        handler.InstantCamera();
        playerCamera.GetComponent<CinemachineVirtualCamera>().m_Lens.FieldOfView = 45;
        if (handler == null) Debug.Log("a");
    }

    void OnCharactorSelection(IUEventData uEventData)
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