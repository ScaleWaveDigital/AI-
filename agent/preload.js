const { contextBridge, ipcRenderer, webUtils } = require('electron');
contextBridge.exposeInMainWorld('agent', {
  state: () => ipcRenderer.invoke('state'),
  signIn: (email, password) => ipcRenderer.invoke('signin', email, password),
  signOut: () => ipcRenderer.invoke('signout'),
  run: (text, paths) => ipcRenderer.invoke('run', text, paths),
  stop: () => ipcRenderer.invoke('stop'),
  setScreen: (on) => ipcRenderer.invoke('screen', on),
  setOpacity: (v) => ipcRenderer.invoke('opacity', v),
  hide: () => ipcRenderer.invoke('hide'),
  quit: () => ipcRenderer.invoke('quit'),
  pathFor: (file) => webUtils.getPathForFile(file),
  onLog: (cb) => ipcRenderer.on('log', (_e, m) => cb(m)),
});
