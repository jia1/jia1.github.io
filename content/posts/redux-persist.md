---
title: "redux-persist"
date: 2020-10-08T22:36:00+08:00
draft: false
tags: ["redux"]
---
If you need your Redux store to last beyond a page load or refresh, look no further! [redux-persist](https://github.com/rt2zz/redux-persist) is here to the rescue. Based on [this guide](https://medium.com/@dharacharolap/get-rid-of-data-consistency-with-the-redux-persist-86559e96de32) and [this guide](https://levelup.gitconnected.com/persisting-your-react-application-state-with-redux-and-typescript-51e4e66c4e53), you need to update your reducers and store to enjoy persistence:

Install `redux-persist`:

```bash
yarn add redux-persist @types/redux-persist
```

Update root reducer and store:

```typescript
// Copied from the official README and edited
import { Provider } from 'react-redux';
import { createStore, Store } from 'redux';
import { persistReducer, persistStore } from 'redux-persist';
import storage from 'redux-persist/lib/storage';

import rootReducer from './reducers';
// Import YourReduxStoreModel interface here

import { PersistGate } from 'redux-persist/integration/react';
import thunk from 'redux-thunk';

// Import Blah component here

const persistConfig = {
  key: 'anyKeyInTheStore', // Or 'root' if you want the entire store to be persistent
  storage,
  // Can blacklist or whitelist one or more keys with blacklist: [...] and whitelist: [...]
};

const persistedReducer = persistReducer(persistConfig, rootReducer)

const configureStore: () => Store<YourReduxStoreModel> = () => {
  let store = createStore(persistedReducer, initialStore, applyMiddleware(thunk));
  let persistor = persistStore(store);
  return { store, persistor };
};

// The stuff below can be in a separate file.
const { store, persistor } = configureStore();

const App = () => {
  return (
    <Provider store={store}>
      <PersistGate loading={null} persistor={persistor}>
        <Blah />
      </PersistGate>
    </Provider>
  );
};
```

The TypeScript type checker will then highlight `initialStore` because its type is `YourReduxStoreModel`. It does not contain `_persist` key and other keys related to `redux-persist`. This is a [known issue](https://github.com/rt2zz/redux-persist/issues/1169). For a quick fix, I added the missing keys to `YourReduxStoreModel`.

To access `persistor` elsewhere, [the author recommends](https://github.com/rt2zz/redux-persist/issues/349) accessing it through the config.

```typescript
// Copied from https://github.com/rt2zz/redux-persist/issues/349
import { purgeStoredState } from 'redux-persist';
import { persistConfig } from 'relative path to your persistConfig';

purgeStoredState(persistConfig);
```

Cheers!
