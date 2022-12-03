package com.eterkit.edge_detector

import android.content.Context
import android.net.Uri
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.objects.ObjectDetection
import com.google.mlkit.vision.objects.defaults.ObjectDetectorOptions
import kotlinx.coroutines.tasks.await
import java.io.File

class EdgeDetector {
    private val options = ObjectDetectorOptions.Builder()
        .setDetectorMode(ObjectDetectorOptions.SINGLE_IMAGE_MODE)
        .build()

    private val objectDetector = ObjectDetection.getClient(options)

    suspend fun detectEdges(context: Context, filePath: String): EdgeDetectorResult {
        try {
            val imageFile = File(filePath)
            val uri = Uri.fromFile(imageFile)
            val image = InputImage.fromFilePath(context, uri)
            val detectedObjects = objectDetector.process(image).await()
            val detectedRect = detectedObjects.first().boundingBox
            return EdgeDetectorResult.fromRect(detectedRect)
        } catch (exception: Exception) {
            throw Exception("Could not detect edges for image from path: $filePath.\n$exception")
        }
    }
}