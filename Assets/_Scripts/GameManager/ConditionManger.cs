using RMC.Core.UEvents.UEventDispatcher;
using RMC.Core.UEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionManger : Singleton<ConditionManger>
{
    [Header("Condition")]
    public bool inGame;
    public bool endGame;
    public bool endGameBoss;
    public bool gameOver;
    public bool pauseGame;
    public bool selectCharactor;
    public bool menuGame;
    public bool startGame;


    [Header("UI")]
    public GameObject endGameUI;
    public GameObject endGameBossUI;
    public GameObject attackUI;
    public GameObject gameOverUI;
    public GameObject miniBossUI;
    public GameObject bossUI;
    public GameObject menuGameUI;
    public GameObject selectCharactorUI;

    void Start()
    {
        UEventDispatcherSingleton.Instance.AddEventListener<InGame>(OnInGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGame>(OnEndGame);
        UEventDispatcherSingleton.Instance.AddEventListener<EndGameBoss>(OnEndGameBoss);
        UEventDispatcherSingleton.Instance.AddEventListener<GameOver>(OnGameOver);
        UEventDispatcherSingleton.Instance.AddEventListener<PauseGame>(OnPauseGame);
        UEventDispatcherSingleton.Instance.AddEventListener<CharactorSelection>(OnSelectCharactor);
        UEventDispatcherSingleton.Instance.AddEventListener<MenuGame>(OnMenuGame);

    }

    void OnInGame(IUEventData uEventData)
    {
        inGame = true;
        endGame = false;
        pauseGame = false;
        gameOver = false;
        endGameBoss = false;

        ActiveCurrentUI();
    }

    void OnEndGame(IUEventData uEventData)
    {
        inGame = false;
        pauseGame = false;
        gameOver = false;
        endGame = true;
        endGameBoss = false;

        ActiveCurrentUI();
    }

    void OnEndGameBoss(IUEventData uEventData)
    {
        inGame = false;
        pauseGame = false;
        gameOver = false;
        endGame = false;
        endGameBoss = true;

        ActiveCurrentUI();
    }

    void OnGameOver(IUEventData uEventData)
    {
        inGame = false;
        endGame = false;
        pauseGame = false;
        gameOver = true;
        endGameBoss = false;

        ActiveCurrentUI();
    }

    void OnPauseGame(IUEventData uEventData)
    {
        inGame = false;
        endGame = false;
        pauseGame = true;
        gameOver = false;
        endGameBoss = false;

        ActiveCurrentUI();
    }

    void OnSelectCharactor(IUEventData uEventData)
    {
        inGame = false;
        endGame = false;
        pauseGame = false;
        gameOver = false;
        endGameBoss = false;
        selectCharactor = true;
        menuGame = false;

        ActiveCurrentUI();
    }

    void OnMenuGame(IUEventData uEventData)
    {
        inGame = false;
        endGame = false;
        pauseGame = false;
        gameOver = false;
        endGameBoss = false;
        selectCharactor = false;
        menuGame = true;

        ActiveCurrentUI();
    }

    void ActiveCurrentUI()
    {
        attackUI.SetActive(inGame);
        endGameUI.SetActive(endGame);
        endGameBossUI.SetActive(endGameBoss);
        gameOverUI.SetActive(gameOver);
        selectCharactorUI.SetActive(selectCharactor);
        menuGameUI.SetActive(menuGame);


        if (DataManager.Instance.data.currentMap > 1 && DataManager.Instance.data.currentMap < 10)
        {
            miniBossUI.SetActive(inGame);
        }
        else
        {
            miniBossUI.SetActive(false);
        }

        if(DataManager.Instance.data.currentMap == 10)
        {
            bossUI.SetActive(inGame);
        }

        else
        {
            bossUI.SetActive(false);
        }
    }
}
