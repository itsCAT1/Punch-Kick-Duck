using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class cam : MonoBehaviour
{
    public Transform[] items; // Mảng chứa các transform của các item
    public float swipeSpeed = 1.0f; // Tốc độ di chuyển camera khi kéo chuột
    public float snapSpeed = 5.0f; // Tốc độ snap camera vào item
    public float minDistanceToSnap = 0.1f; // Khoảng cách tối thiểu để snap vào item

    public Vector2 mouseStartPos; // Vị trí bắt đầu kéo chuột
    public bool isDragging = false; // Kiểm tra xem có đang kéo chuột không
    public int currentItemIndex = 0; // Chỉ số của item hiện tại

    private void Update()
    {
        HandleMouseInput();
        MoveCameraToItem();
    }

    private void HandleMouseInput()
    {
        if (Input.GetMouseButtonDown(0)) // Khi nhấn chuột trái
        {
            mouseStartPos = Input.mousePosition; // Lưu vị trí bắt đầu kéo
            isDragging = true;
            Debug.Log("click");
        }

        if (Input.GetMouseButton(0) && isDragging) // Khi đang giữ chuột trái
        {
            Vector2 mouseDelta = (Vector2)Input.mousePosition - mouseStartPos; // Tính khoảng cách di chuyển chuột
            float swipeDelta = mouseDelta.x * swipeSpeed * Time.deltaTime; // Tính toán độ dịch chuyển
            transform.Translate(-swipeDelta, 0, 0); // Di chuyển camera theo hướng kéo chuột
            Debug.Log("keo");
        }

        if (Input.GetMouseButtonUp(0)) // Khi thả chuột trái
        {
            isDragging = false;
            //SnapToNearestItem(); // Snap camera vào item gần nhất
            Debug.Log("tha");
        }
    }

    private void SnapToNearestItem()
    {
        float minDistance = float.MaxValue;
        int nearestItemIndex = 0;

        // Tìm item gần nhất với vị trí hiện tại của camera
        for (int i = 0; i < items.Length; i++)
        {
            float distance = Mathf.Abs(transform.position.x - items[i].position.x);
            if (distance < minDistance)
            {
                minDistance = distance;
                nearestItemIndex = i;
            }
        }

        currentItemIndex = nearestItemIndex; // Cập nhật chỉ số item hiện tại
    }

    private void MoveCameraToItem()
    {
        if (!isDragging) // Nếu không đang kéo chuột
        {
            // Di chuyển camera đến vị trí của item hiện tại
            Vector3 targetPosition = new Vector3(items[currentItemIndex].position.x, transform.position.y, transform.position.z);
            transform.position = Vector3.Lerp(transform.position, targetPosition, snapSpeed * Time.deltaTime);
        }
    }
}
