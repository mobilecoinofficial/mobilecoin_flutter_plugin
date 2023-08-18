package mistyswap;

import androidx.annotation.NonNull;

import com.mobilecoin.lib.network.uri.MobileCoinScheme;

public final class MistySwapScheme implements MobileCoinScheme {

    @NonNull
    @Override
    public String secureScheme() {
        return"mistyswap";
    }

    @NonNull
    @Override
    public String insecureScheme() {
        return "insecure-mistyswap";
    }

    @Override
    public int securePort() {
        return 443;// TODO: Is this correct?
    }

    @Override
    public int insecurePort() {
        return 4040;// TODO: Has this value been decided yet?
    }

}
