// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.eterkit.health_flutter

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Enum representing permission levels. */
enum class PermissionType(val raw: Int) {
  READ(0),
  WRITE(1),
  READWRITE(2);

  companion object {
    fun ofRaw(raw: Int): PermissionType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Enum representing health units. */
enum class HealthUnit(val raw: Int) {
  KILOCALORIE(0),
  /** In celsius. */
  DEGREE(1);

  companion object {
    fun ofRaw(raw: Int): HealthUnit? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * Enum representing health data types.
 * **Important**: Order of this enum is respected on native platforms.
 *
 * Please keep it in alphabetical order on every platform.
 */
enum class HealthDataType(val raw: Int) {
  ACTIVEENERGYBURNED(0),
  BASALBODYTEMPERATURE(1),
  BASALENERGYBURNED(2);

  companion object {
    fun ofRaw(raw: Int): HealthDataType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * Helper object to group `HealthDataType` and `PermissionType` together.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class HealthPermission (
  val dataType: HealthDataType,
  val permissionType: PermissionType

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): HealthPermission {
      val dataType = HealthDataType.ofRaw(list[0] as Int)!!
      val permissionType = PermissionType.ofRaw(list[1] as Int)!!
      return HealthPermission(dataType, permissionType)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      dataType.raw,
      permissionType.raw,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object HealthApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HealthPermission.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is HealthPermission -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface HealthApi {
  fun checkAvailability(): Boolean
  fun canRequestPermissions(permissions: List<HealthPermission>, callback: (Result<Boolean>) -> Unit)
  fun requestPermissions(permissions: List<HealthPermission>, callback: (Result<Boolean>) -> Unit)
  fun getDataForType(type: HealthDataType, startDateMillisecondsSinceEpoch: Long, endDateMillisecondsSinceEpoch: Long, callback: (Result<List<Map<Any, Any?>>>) -> Unit)

  companion object {
    /** The codec used by HealthApi. */
    val codec: MessageCodec<Any?> by lazy {
      HealthApiCodec
    }
    /** Sets up an instance of `HealthApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: HealthApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.health_flutter.HealthApi.checkAvailability", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.checkAvailability())
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.health_flutter.HealthApi.canRequestPermissions", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val permissionsArg = args[0] as List<HealthPermission>
            api.canRequestPermissions(permissionsArg) { result: Result<Boolean> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.health_flutter.HealthApi.requestPermissions", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val permissionsArg = args[0] as List<HealthPermission>
            api.requestPermissions(permissionsArg) { result: Result<Boolean> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.health_flutter.HealthApi.getDataForType", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val typeArg = HealthDataType.ofRaw(args[0] as Int)!!
            val startDateMillisecondsSinceEpochArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            val endDateMillisecondsSinceEpochArg = args[2].let { if (it is Int) it.toLong() else it as Long }
            api.getDataForType(typeArg, startDateMillisecondsSinceEpochArg, endDateMillisecondsSinceEpochArg) { result: Result<List<Map<Any, Any?>>> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
