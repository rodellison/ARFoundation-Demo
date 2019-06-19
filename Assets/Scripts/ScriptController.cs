using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScriptController : MonoBehaviour
{
    void Awake()
    {
        Input.backButtonLeavesApp = true;
    }

    // Update is called once per frame
    void Update()
    {
        //Use the Back button to exit
        if (Input.GetKeyDown(KeyCode.Escape))
        {
#if UNITY_EDITOR
            UnityEditor.EditorApplication.isPlaying = false;
#elif UNITY_ANDROID
            ShutDownAndroid();
#elif UNITY_IOS
            Application.Quit();
#endif
        }
    }

    void ShutDownAndroid()
    {
        Application.Quit();
        System.Diagnostics.Process.GetCurrentProcess().Kill();
    }
}