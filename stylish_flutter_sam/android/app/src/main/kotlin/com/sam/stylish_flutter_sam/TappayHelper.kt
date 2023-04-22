package com.sam.stylish_flutter_sam

import android.content.Context
import tech.cherri.tpdirect.api.TPDCard
import tech.cherri.tpdirect.api.TPDServerType
import tech.cherri.tpdirect.api.TPDSetup

object TappayHelper {
    // 設置Tappay環境
    fun setupTappay(
        context: Context,
        appId: Int?,
        appKey: String?,
        serverType: String?,
        errorMessage: (String) -> (Unit)
    ) {
        var message = ""

        if (appId == 0 || appId == null) {
            message += "appId error"
        }

        if (appKey.isNullOrEmpty()) {
            message += "/appKey error"
        }

        if (serverType.isNullOrEmpty()) {
            message += "/serverType error"
        }

        if (message.isNotEmpty()) {
            errorMessage(message)
            return
        }

        val st: TPDServerType =
            if (serverType == "sandBox") (TPDServerType.Sandbox) else (TPDServerType.Production)

        appId?.let { id -> TPDSetup.initInstance(context, id, appKey, st) }
    }

    //檢查信用卡的有效性
    fun isCardValid(
        cardNumber: String?,
        dueMonth: String?,
        dueYear: String?,
        ccv: String?
    ): Boolean {

        if (cardNumber.isNullOrEmpty()) {
            return false
        }

        if (dueMonth.isNullOrEmpty()) {
            return false
        }

        if (dueYear.isNullOrEmpty()) {
            return false
        }

        if (ccv.isNullOrEmpty()) {
            return false
        }

        val result = TPDCard.validate(
            StringBuffer(cardNumber),
            StringBuffer(dueMonth),
            StringBuffer(dueYear),
            StringBuffer(ccv)
        )

        return result.isCCVValid && result.isCardNumberValid && result.isExpiryDateValid
    }

    //取得Prime
    fun getPrime(
        context: Context,
        cardNumber: String?,
        dueMonth: String?,
        dueYear: String?,
        ccv: String?,
        prime: (String) -> (Unit),
        failCallBack: (String) -> (Unit)
    ) {

        if (cardNumber == null || dueMonth == null || dueYear == null || ccv == null) {
            failCallBack("{\"status\":\"\", \"message\":\"something is null\", \"prime\":\"\"}")
        } else {
            val cn = StringBuffer(cardNumber)
            val dm = StringBuffer(dueMonth)
            val dy = StringBuffer(dueYear)
            val cv = StringBuffer(ccv)
            val card = TPDCard(context, cn, dm, dy, cv).onSuccessCallback { tpPrime, _, _, _ ->
                prime("{\"status\":\"\", \"message\":\"\", \"prime\":\"$tpPrime\"}")
            }.onFailureCallback { status, message ->
                failCallBack("{\"status\":\"$status\", \"message\":\"$message\", \"prime\":\"\"}")
            }
            card.createToken("Unknown")
        }

    }
}
