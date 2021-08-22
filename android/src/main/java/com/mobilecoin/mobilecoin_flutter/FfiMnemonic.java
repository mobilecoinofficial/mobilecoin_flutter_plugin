package com.mobilecoin.mobilecoin_flutter;

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
        return String.join(",", Mnemonics.wordsByPrefix(""));
    }
}
