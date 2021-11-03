<template>
  <div class="scriptCreator">
    <button class="cancelButton" v-on:click="() => this.$emit('cancelEvent')">Cancel</button>
    <form v-on:submit.prevent="handleCreation">
      <h1>Create a new script</h1>
      <UploadManager v-bind:currentFile="currentFile" v-on:handle-upload="handleUpload" />
      <p>TIP: You can upload no file and we'll generate a blank file</p>
      <h2>Script Title</h2>
      <input type="text" v-model="formData.title" v-bind:readonly="processingCreation" required/>
      <h2>Script Description</h2>
      <textarea v-model="formData.description" v-bind:readonly="processingCreation" required/>
      <div>
        <h2 style="margin-bottom: 0px;text-align: left;float: left;">Public Script</h2>
        <p style="color: rgb(225, 74, 74)">Warning: This toggle will make the obfuscated script public!</p>
        <label class="toggle-control">
          <input type="checkbox" v-model="formData.public" v-bind:readonly="processingCreation">
          <span class="control"></span>
        </label>
      </div>
      <button type="submit" v-bind:disabled="processingCreation">
        <span v-if="!processingCreation">Create script</span>
        <span v-if="processingCreation">Creating Script...</span>
      </button>
    </form>
  </div>
</template>

<script>
export default {
  props: ['currentFile'],
  computed: {
    userData() {
      return this.$store.state.userData.currentUser
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  data() {
    return {
      processingCreation: false,
      formData: {
        file: null,
        fileName: '',
        title: '',
        description: '',
        public: false
      }
    }
  },
  methods: {
    async handleCreation() {
      this.processingCreation = true

      // Create form Data with our project
      const form = new FormData()

      form.append('title', this.formData.title)
      form.append('description', this.formData.description)
      form.append('public', this.formData.public)
      form.append('token', this.authToken)
      if (this.formData.file) {
        form.append('file', this.formData.file)
      } else {
        form.append('file', new Blob(["print('Hello World!')"], {type : 'text/plain'}))
      }

      // Now request
      await fetch('https://next.psu.dev/api/v2/scripts/createScript', {
        method: 'POST',
        body: form
      })
      .then(response => response.json())
      .then(async data => {
        if (data.success) {
          await window.projectsAPI.loadData()
          this.$emit('project-created')
        } else {
          window.createNotification('ERROR', `ERROR: ${data.error}`, 15)
        }
      })
      .catch(error => {
        window.createNotification('ERROR', `ERROR: ${error}`, 15)
        console.error(error)
      })
      this.processingCreation = false
    },
    handleUpload(FileURL, FileName) {
      this.formData.file = FileURL
      this.formData.fileName = FileName
    }
  }
}
</script>

<style lang="scss">
  .scriptCreator {
    position: relative;
    width: 50%;
    border-radius: 10px;
    border: 2px var(--border) solid;
    margin: 0 auto;
    text-align: center;
    padding: 30px;
    background: #242424;
    font-family: "Poppins", sans-serif;
    padding-left: 10%;
    padding-right: 10%;
    box-sizing: border-box;

    > form > h2 {
      margin-bottom: 5px;
      text-align: left;
      float: left;
    }

    form > p {
      display: block;
      text-align: center;
      margin: 0 auto;
      width: 100%;
    }

    p {
      margin-top: 0px;
      text-align: left;
      font-size: 13px;
      float: left;
    }

    form {
      position: relative;
    }

    > form > input {
      width: 100%;
    }

    > form > button {
      margin-top: 20px;
    }

    label {
      float: right;
      transform: translateY(-20px);
    }

    .cancelButton {
      position: absolute;
      top: 0px;
      left: 10px;
      top: 10px;
      background: linear-gradient(90deg, #4f4f4f 0%, #9D9D9D 100%);
    }
  }
</style>
