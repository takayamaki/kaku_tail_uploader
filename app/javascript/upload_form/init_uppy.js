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
  const uppy = new Uppy({
    restrictions:{
      maxFileSize:5*(1000**3), //5GB
      maxNumberOfFiles: 1
    },
    debug: true,
    autoProceed: true
  })

  uppy.use(
    FileInput,{
      target: '.FileInput',
      pretty: true
  }).use(AwsS3,{
    getUploadParameters: getUploadParameters
  }).use(
    StatusBar, {
      target: '.UppyProgress',
      hideUploadButton: true,
      hideAfterFinish: false
  })
  
  uppy.on('upload-success', uploadSuccessHandler)
}
