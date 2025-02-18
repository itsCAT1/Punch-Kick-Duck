using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionManger : Singleton<ConditionManger>
{
    [Header("Condition")]
    public bool startGame;
    public bool endGame;
    public bool gameOver;
    public bool pauseGame;

    [Header("UI")]
    public GameObject endGameUI;
    public GameObject attackUI;
    public GameObject gameOverUI;

    public GameObject miniBossUI;
    public GameObject bossUI;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<StartGame>(OnStartGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(OnEndGame);
        UEventDispatcherSingleton.Instance.AddEventListener<GameOver>(OnGameOver);
        UEventDispatcherSingleton.Instance.AddEventListener<PauseGame>(OnPauseGame);
    }

    void OnStartGame(IUEventData uEventData)
    {
        startGame = true;
        endGame = false;
        pauseGame = false;
        gameOver = false;

        ActiveCurrentUI();
    }

    void OnEndGame(IUEventData uEventData)
    {
        startGame = false;
        endGame = true;
        pauseGame = false;
        gameOver = false;

        ActiveCurrentUI();
        miniBossUI.SetActive(startGame);
    }

    void OnGameOver(IUEventData uEventData)
    {
        startGame = false;
        endGame = false;
        pauseGame = false;
        gameOver = true;

        ActiveCurrentUI();
    }

    void OnPauseGame(IUEventData uEventData)
    {
        startGame = false;
        endGame = false;
        pauseGame = true;
        gameOver = false;

        ActiveCurrentUI();
    }

    void ActiveCurrentUI()
    {
        attackUI.SetActive(startGame);
        endGameUI.SetActive(endGame);
        gameOverUI.SetActive(gameOver);

        if (DataManager.Instance.data.currentMap > 1 && DataManager.Instance.data.currentMap < 10)
        {
            miniBossUI.SetActive(startGame);
        }
        else
        {
            miniBossUI.SetActive(false);
        }

        if(DataManager.Instance.data.currentMap == 10)
        {
            bossUI.SetActive(startGame);
        }

        else
        {
            bossUI.SetActive(false);
        }
    }
}
