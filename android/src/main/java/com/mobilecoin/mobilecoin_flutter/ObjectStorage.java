package com.mobilecoin.mobilecoin_flutter;

import java.util.HashMap;

class ObjectStorage {
    private static HashMap<Integer, Object> managedObjects = new HashMap<>();

    private ObjectStorage() { }

    public static synchronized void addObject(final Integer key, final Object object) {
        managedObjects.put(key, object);
    }

    public static synchronized Object objectForKey(final Integer key) {
        return managedObjects.get(key);
    }
}
