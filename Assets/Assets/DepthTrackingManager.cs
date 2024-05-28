using GoogleARCore;
using UnityEngine;

public class DepthTrackingManager : MonoBehaviour
{
    void Start()
    {
        ARCoreSessionConfig config = new ARCoreSessionConfig();
        config.DepthMode = DepthMode.Automatic;
        ARCoreSession.SetConfiguration(config);
    }

    void Update()
    {
        if (Session.Status != SessionStatus.Tracking)
        {
            return;
        }

        // Check for and process depth data
        List<ARPointCloud> pointClouds = new List<ARPointCloud>();
        Session.GetTrackables(pointClouds, TrackableQueryFilter.Updated);

        foreach (var pointCloud in pointClouds)
        {
            Debug.Log("PointCloud updated with " + pointCloud.Points.Count + " points.");
            // Perform your logic with the depth data here.
        }
    }
}
