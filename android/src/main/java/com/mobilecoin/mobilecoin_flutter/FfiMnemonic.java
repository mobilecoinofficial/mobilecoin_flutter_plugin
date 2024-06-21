// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import android.text.TextUtils;

import androidx.annotation.Keep;
import com.mobilecoin.lib.Mnemonics;
import com.mobilecoin.lib.exceptions.BadEntropyException;
import com.mobilecoin.lib.exceptions.BadMnemonicException;;

@Keep
public class FfiMnemonic {

    private FfiMnemonic() {
    }

    public static String fromBip39Entropy(byte[] entropy) throws BadEntropyException {
        return Mnemonics.bip39EntropyToMnemonic(entropy);
    }

    public static byte[] toBip39Entropy(String mnemonicPhrase) throws BadMnemonicException {
        return Mnemonics.bip39EntropyFromMnemonic(mnemonicPhrase);
    }

    public static String allWords() throws BadMnemonicException {
        return TextUtils.join(",", Mnemonics.wordsByPrefix(""));
    }
}
