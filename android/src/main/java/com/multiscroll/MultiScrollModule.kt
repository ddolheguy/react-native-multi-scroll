package com.multiscroll

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.uimanager.NativeViewHierarchyManager
import com.facebook.react.uimanager.UIManagerModule
import com.facebook.react.uimanager.UIBlock
import android.view.View

class NativeSyncScrollViews(context: ReactApplicationContext) : ReactContextBaseJavaModule(context) {

    init {
        // Initialization if needed
    }

    override fun getName(): String {
        return "NativeSyncScrollViews"
    }

    private var view1YPosition = 0
    private var view2YPosition = 0

    @ReactMethod
    fun syncScrollEvent(view1Id: Int, view2Id: Int) {
        val uiManager = reactApplicationContext.getNativeModule(UIManagerModule::class.java)

        uiManager?.addUIBlock(object : UIBlock {
            override fun execute(nativeViewHierarchyManager: NativeViewHierarchyManager) {
                val view1 = nativeViewHierarchyManager.resolveView(view1Id)
                val view2 = nativeViewHierarchyManager.resolveView(view2Id)

                view1.setOnScrollChangeListener { view, x, y, oldX, oldY ->
                    view1YPosition = y
                    if (view2YPosition != view1YPosition) {
                        view2.scrollTo(0, y)
                    }
                }

                view2.setOnScrollChangeListener { view, x, y, oldX, oldY ->
                    if (y != oldY) {
                        view2YPosition = y
                    }
                }
            }
        })
    }
}
