'use strict';

import { Uppy } from '@uppy/core';
import AwsS3 from '@uppy/aws-s3';
import FileInput from '@uppy/file-input';
import StatusBar from '@uppy/status-bar';

const getUploadParameters = (file) => {
  const fileName = encodeURIComponent(file.name);

  return fetch(`/api/presign?fileName=${fileName}`).then((response)=>{
    return response.json()
  })
}

const uploadSuccessHandler = (file, data) =>{
  const fileNameInput = document.getElementById('uploaded_file_file_name')
  fileNameInput.value = file.name

  console.log(file,data)
  
  const fileData = JSON.stringify({
    id: data.location.split('/').slice(-1)[0],
    storage: 'cache',
    metadata: {
      size:      file.size,
      filename:  file.name,
      mime_type: file.type
    }
  })
  const fileInfoInput = document.getElementById('uploaded_file_file_data')
  fileInfoInput.value = fileData
}

export const initUppy = ()=>{
  const uppy = new Uppy({ debug: true, autoProceed: true })

  uppy.use(
    FileInput,{
      target: '.UppyInput',
      pretty: false
  }).use(AwsS3,{
    getUploadParameters: getUploadParameters
  }).use(
    StatusBar, {
      target: '.UppyInput-Progress',
      hideUploadButton: true,
      hideAfterFinish: false
  })
  
  uppy.on('upload-success', uploadSuccessHandler)
}
