package com.eterkit.edge_detector

import android.graphics.Rect

data class EdgeDetectorResult(
    val left: Int,
    val top: Int,
    val right: Int,
    val bottom: Int,
) {
    companion object {
        fun fromRect(rect: Rect): EdgeDetectorResult {
            // Note that the results are in fact two points:
            // top-left & bottom-right (it has to be converted to 4 Offset's on dart side)
            return EdgeDetectorResult(
                left = rect.left,
                top = rect.top,
                right = rect.right,
                bottom = rect.bottom,
            )
        }
    }

    fun toJson(): Map<String, Int> = mapOf(
        "left" to this.left,
        "top" to this.top,
        "right" to this.right,
        "bottom" to this.bottom,
    )
}
