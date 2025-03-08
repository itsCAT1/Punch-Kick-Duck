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
    public GameObject adjustCamera;
    public GameObject bossCamera;
    public CameraHandler handler;
    public CameraSkinHandler skinSelector;

    private void Start()
    {
        InitialGame();

        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenuGame);
        UEventDispatcherSingleton.Instance.AddEventListener<RestartGame>(InstantCamera);
        UEventDispatcherSingleton.Instance.AddEventListener<CharactorSelection>(OnCharactorSelection);
        UEventDispatcherSingleton.Instance.AddEventListener<LevelSelection>(InstantCamera);
    }


    public void InitialGame()
    {
        handler.SwitchCamera();
        playerCamera.GetComponent<CinemachineVirtualCamera>().m_Lens.FieldOfView = 40;
    }

    void OnMenuGame(IUEventData uEventData)
    {
        seletctCamera.SetActive(false);
        playerCamera.SetActive(true);
        InitialGame();
        handler.CameraMenu();
    }

    void OnCharactorSelection(IUEventData uEventData)
    {
        seletctCamera.SetActive(true);
        handler.SwitchCamera();
    }

    public void OnAdjustTouch()
    {
        adjustCamera.SetActive(true);
        handler.SwitchCamera();
    }

    public void OutAdjustTouch()
    {
        adjustCamera.SetActive(false);
        handler.SwitchCamera();
    }

    void InstantCamera(IUEventData uEventData)
    {
        handler.SwitchCamera();
    }

    public void GoBossArea()
    {
        StartCoroutine(MoveToBossAreaCoroutine());
    }

    IEnumerator MoveToBossAreaCoroutine()
    {
        playerCamera.SetActive(false);
        yield return new WaitForSeconds(3);
        playerCamera.SetActive(true);
        yield return new WaitForSeconds(3);
        CombatManager.Instance.inBossArea = true;
    }
}