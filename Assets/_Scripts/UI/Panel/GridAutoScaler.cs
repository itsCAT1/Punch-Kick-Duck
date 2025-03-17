using UnityEngine;
using UnityEngine.UI;

public class GridAutoScaler : MonoBehaviour
{
    public GridLayoutGroup gridLayout;

    private void OnValidate()
    {
        gridLayout = GetComponent<GridLayoutGroup>();
    }

    private void OnEnable()
    {
        AdjustCellSize();
    }

    void AdjustCellSize()
    {
        // Lấy kích thước màn hình
        float screenWidth = Screen.width;
        float screenHeight = Screen.height;

        // Chia 3 cột, 2 hàng
        float cellHeight = screenHeight / 3;
        float cellWidth = screenHeight * 2.1f;

        // Đặt Cell Size
        gridLayout.cellSize = new Vector2(cellWidth, cellHeight);

        Debug.Log(screenWidth);
        Debug.Log(screenHeight);
    }
}
