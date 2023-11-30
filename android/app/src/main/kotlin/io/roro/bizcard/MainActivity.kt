package io.roro.bizcard

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.tensorflow.lite.task.text.qa.BertQuestionAnswerer
import org.tensorflow.lite.task.text.qa.BertQuestionAnswerer.BertQuestionAnswererOptions
import org.tensorflow.lite.task.core.BaseOptions
import org.tensorflow.lite.task.text.qa.QaAnswer
import java.io.File

class MainActivity : FlutterActivity() {

    private val MobileBertChannel = "mobilebert"
    private var answerer: BertQuestionAnswerer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MobileBertChannel)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "initializeMobilebert" -> {
                    try {
                        val args : Map<String, String>? = call.arguments as? Map<String, String>
                        val path : String = args?.get("path") ?: ""
                        initializeMobilebert(path)
                        result.success(true)
                    } catch (err: Exception) {
                        result.error("initializeMobilebert", err.message, null)
                    }
                }
                "answer" -> {
                    val args : Map<String, String>? = call.arguments as? Map<String, String>
                    val context : String = args?.get("context") ?: ""
                    val question : String = args?.get("question") ?: ""
                    val answerResult = answer(context, question)
                    result.success(answerResult)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun initializeMobilebert(path: String) {
        val options = BertQuestionAnswererOptions
            .builder()
            .setBaseOptions(BaseOptions.builder().setNumThreads(4).build())
            .build()
        answerer = BertQuestionAnswerer
            .createFromFileAndOptions(
                applicationContext, path, options
            )
    }

    private fun answer(context : String, question : String): List<String>? {
        val suggestions = answerer?.answer(context, question)
        return suggestions?.map { it.text }
    }
}