// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import org.junit.Test;

public class ObjectStorageTest {

    @Test
    public void objectForKey_returnsStoredObject() {
        final Object value = new Object();
        ObjectStorage.addObject(1, value);

        assertEquals(value, ObjectStorage.objectForKey(1));
    }

    @Test
    public void objectForKey_returnsNullForUnknownKey() {
        assertNull(ObjectStorage.objectForKey(999));
    }

    @Test
    public void addObject_overwritesExistingKey() {
        ObjectStorage.addObject(2, "first");
        ObjectStorage.addObject(2, "second");

        assertEquals("second", ObjectStorage.objectForKey(2));
    }
}
