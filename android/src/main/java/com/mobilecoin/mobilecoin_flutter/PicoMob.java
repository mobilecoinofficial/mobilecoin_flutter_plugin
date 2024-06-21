// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import java.math.BigDecimal;
import java.math.BigInteger;

public class PicoMob {
    static PicoMob parsePico(String picoCount) {
        return new PicoMob(new BigInteger(picoCount));
    }

    private final BigInteger picoMob;

    PicoMob(BigInteger picoMob) {
        this.picoMob = picoMob;
    }

    BigInteger getPicoCountAsBigInt() {
        return picoMob;
    }

    BigDecimal getMobFractionAsBigDecimal() {
        return new BigDecimal(picoMob).divide(new BigDecimal("1e12"));
    }
}
