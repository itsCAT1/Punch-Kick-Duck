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

    private void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(OnGameStart);
        UEventDispatcherSingleton.Instance.AddEventListener<GoLevelBoss>(GoBossArea);

        FollowPlayer();
    }

    private void Update()
    {
        //FollowPlayer();
    }

    public void FollowPlayer()
    {
        playerCamera.SetActive(true);
        InstantFollowPlayer();
    }

    public void FollowBoss()
    {
        playerCamera.SetActive(false);
    }

    void OnGameStart(IUEventData uEventData)
    {
        FollowPlayer();
    }

    public void GoBossArea(IUEventData uEventData)
    {
        StartCoroutine(MoveToBossAreaCoroutine());
    }

    IEnumerator MoveToBossAreaCoroutine()
    {
        FollowBoss();
        yield return new WaitForSeconds(3);
        FollowPlayer();
        yield return new WaitForSeconds(3);
        CombatManager.Instance.inBossArea = true;
    }

    public void InstantFollowPlayer()
    {
        if (playerCamera != null && Player.Instance != null)
        {
            var transposer = playerCamera.GetComponent<CinemachineVirtualCamera>().GetCinemachineComponent<CinemachineTransposer>();

            if (transposer != null)
            {
                transposer.m_XDamping = 0; 
                transposer.m_YDamping = 0; 
                transposer.m_ZDamping = 0;  
            }
        }
    }

    public void SmoothFollowPlayer()
    {
        if (playerCamera != null && Player.Instance != null)
        {
            var transposer = playerCamera.GetComponent<CinemachineVirtualCamera>().GetCinemachineComponent<CinemachineTransposer>();

            if (transposer != null)
            {
                transposer.m_XDamping = 1;
                transposer.m_YDamping = 1; 
                transposer.m_ZDamping = 1;
            }
        }
    }
}