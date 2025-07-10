package com.example.bancamovil

import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setImmersiveMode()
    }

    private fun setImmersiveMode() {
        // Oculta la barra de navegación y la barra de estado (opcional)
        window.decorView.systemUiVisibility = (
            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
            or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
            or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
            or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION  // Oculta las teclas de navegación
            
        )
    }

    // Mantiene el modo inmersivo incluso al cambiar de app y volver
    override fun onResume() {
        super.onResume()
        setImmersiveMode()
    }

    // Opcional: Si quieres que se mantenga incluso después de interacciones
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) setImmersiveMode()
    }
}
