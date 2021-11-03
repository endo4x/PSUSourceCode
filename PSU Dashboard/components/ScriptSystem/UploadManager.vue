<template>
  <div v-bind:class="fileHovering ? 'UploadManager' : 'UploadManager Hovering'" @drop="handleFileDrop" @dragover="onDropEnter" @dragleave="onDropLeave">
    <div>
      <h1 v-if="!fileHovering && !file">Drag file here or <span v-on:click="triggerManualUpload">browse</span></h1>
      <span v-if="!fileHovering && !file" >Max file size: 10mb</span>
      <h1 v-if="file && !fileHovering">{{this.file.name}}</h1>
      <h2 v-if="file && !fileHovering">{{this.file.size}}</h2>
      <span v-if="file && !fileHovering" v-on:click="triggerManualUpload">Upload different file</span>
      <h1 v-if="fileHovering">Drop file to start upload</h1>
    </div>
  </div>
</template>

<script>
export default {
  props: ['currentFile','fileUploader'],
  data() {
    return {
      fileHovering: false,
      file: false
    }
  },
  methods: {
    handleFileDrop(event) {
      event.preventDefault();
      this.fileHovering = false

      this.handleUpload(event.dataTransfer.files)
    },
    onDropEnter(event) {
      event.preventDefault();
      this.fileHovering = true
    },
    onDropLeave() {
      this.fileHovering = false
    },
    triggerManualUpload() {
      var fileUpload = document.createElement("input")
      fileUpload.type = "file"
      fileUpload.accept = ".lua,.txt"

      fileUpload.addEventListener('change', this.handleUpload)

      fileUpload.click();
    },
    handleUpload(files) {
      if (files.target) {
        files = files.target.files
      }

      files = [...files]
      if (files.length) {
        this.file = {name: files[0].name, file: files[0], size: '0 bytes'}

        if (files[0].size < 1024) {
          this.file.size = `${files[0].size} bytes`
        } else if (files[0].size < 1048576) {
          this.file.size = `${Math.round(files[0].size / 1024)} kb`
        } else if (files[0].size < 1e+7) {
          this.file.size = `${Math.round((files[0].size / 1048576 + Number.EPSILON) * 100) / 100} mb`
        } else {
          window.createNotification('ERROR', 'This file is greater than 10mb!')
          this.file = false
        }

        this.$emit('handle-upload', this.file.file, this.file.name)
      }
    }
  },
  mounted() {
    if (this.currentFile) {
      this.handleUpload(this.currentFile)
    }
  }
}
</script>

<style lang="scss">
  .UploadManager {
    width: 100%;
    height: 150px;
    margin: 0 auto;
    margin-top: 20px;
    border: 4px dashed var(--border);
    position: relative;

    > div {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      width: 100%;
    }

    h1, span, h2 {
      margin: 0 auto;
      max-width: 400px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      text-align: center;
    }

    span {
      font-weight: 600;
      color: var(--theme-gradient-2-secondary);
    }

    span:hover {
      cursor: pointer;
    }
  }

  .Hovering:active {
    cursor: grabbing;
    cursor: -moz-grabbing;
    cursor: -webkit-grabbing;
  }
</style>
