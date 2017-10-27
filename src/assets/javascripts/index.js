import '../stylesheets/index.scss'

import m from 'mithril'
import Dropzone from 'dropzone'

Dropzone.options.uploadZone = {
  thumbnail: (file, dataUrl) => {
    let preview = document.getElementById('upload-preview')
    preview.style.backgroundImage = `url('${dataUrl}')`
  },
  uploadprogress: (file, progress) => {
    let preview = document.getElementById('upload-preview')
    preview.style.opacity = progress
  },
  success: (file, response) => {
    let zone = document.getElementById('upload-zone')
    zone.style.borderRadius = '10px'
    zone.style.width = '300px'
    zone.style.height = '300px'
    zone.style.marginTop = '-150px'
    zone.style.marginLeft = '-150px'
    zone.style.boxShadow = '2px 2px 8px rgba(0, 0, 0, 0.5)'
  }
}

document.addEventListener('DOMContentLoaded', () => {
  var zone = new Dropzone("div#upload-zone", { url: "/upload"});
});
