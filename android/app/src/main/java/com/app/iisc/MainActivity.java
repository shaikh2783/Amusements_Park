package com.app.iisc;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Base64;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import java.io.OutputStream;
import android.net.Uri;
import io.flutter.embedding.android.FlutterFragmentActivity;
import androidx.annotation.NonNull;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {
    private static final String CHANNEL = "com.example.app/download";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("saveFile")) {
                        String base64String = call.argument("base64String");
                        String fileName = call.argument("fileName");
                        String mimeType = getMimeType(fileName);
                        String fileUri = saveFileToDownloads(base64String, fileName, mimeType);

                        if (fileUri != null) {
                            result.success(fileUri);  // ✅ Return the file URI
                        } else {
                            result.error("ERROR", "File could not be saved", null);
                        }
                    } else {
                        result.notImplemented();
                    }
                });
    }
    private String getMimeType(String fileName) {
        if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) return "image/jpeg";
        if (fileName.endsWith(".png")) return "image/png";
        if (fileName.endsWith(".pdf")) return "application/pdf";
        return "application/octet-stream"; // Default MIME type
    }
    private String saveFileToDownloads(String base64String, String fileName, String mimeType) {
        try {
            byte[] fileBytes = Base64.decode(base64String, Base64.DEFAULT);
            ContentResolver resolver = getContentResolver();
            ContentValues values = new ContentValues();

            values.put(MediaStore.MediaColumns.DISPLAY_NAME, fileName);
            values.put(MediaStore.MediaColumns.MIME_TYPE, mimeType);
            values.put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);

            Uri uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);

            if (uri != null) {
                try (OutputStream outputStream = resolver.openOutputStream(uri)) {
                    if (outputStream != null) {
                        outputStream.write(fileBytes);
                        outputStream.flush();
                    }
                }

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    values.put(MediaStore.MediaColumns.IS_PENDING, 0);
                    resolver.update(uri, values, null, null);
                }

                return uri.toString(); // ✅ Return the file URI instead of a file path
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // ❌ Return null if saving fails
    }
}