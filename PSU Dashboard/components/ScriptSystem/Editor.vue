<template>
  <div class="PSUEditor">
    <div class="initialising" v-if="initing">
      <div class="lds-ring"><div /><div /><div /><div /></div>
      <h1>Launching Editor</h1>
      <p>Contacting Scripts API for document...</p>
    </div>
    <div class="editorToolbar" v-if="!loadingError">
      <h1>Script: {{ scriptData.title }}</h1>

      <div class="editorButtons">
        <button v-bind:disabled="processingData.obfuscating" v-on:click="openObfuscation">
          <span v-if="!processingData.obfuscating">Obfuscate</span>
        </button>
        <button v-bind:disabled="processingData.prettyPrint" v-on:click="prettyPrint">
          <span v-if="!processingData.prettyPrint">Pretty Print</span>
          <span v-if="processingData.prettyPrint"><font-awesome-icon icon="spinner" spin /></span>
        </button>
        <button v-if="!processingData.saving" v-on:click="saveFile">
          <span>Save</span>
        </button>
        <button v-if="processingData.saving" disabled>
          <span><font-awesome-icon icon="spinner" spin /></span>
        </button>
      </div>
    </div>

    <div class="editorContainer" v-if="!loadingError">
      <aceEditor ref="aceEditor" v-model="content" v-if="!initing" @init="editorInit" lang="lua" theme="tomorrow_night" />
    </div>

    <div class="obfuscationPopup" v-if="obfuscatingScript" v-on:click.self="closeObfuscation">
      <Obfuscate v-bind:scriptData="obfuscatingScript" v-on:close-obfuscator="closeObfuscation" />
    </div>

    <div class="editorError" v-if="loadingError">
      <font-awesome-icon icon="exclamation-triangle" />
      <h1>Something went wrong loading this script.</h1>
      <p>You can try again later or contact support</p>
      <span v-on:click="closeEditor"><font-awesome-icon icon="chevron-left" /> Go Back</span>
    </div>
  </div>
</template>

<script>
import { formatText } from 'lua-fmt'

export default {
  props: ['scriptData'],
  components: {
    aceEditor: require('vue2-ace-editor')
  },
  computed: {
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  data() {
    return {
      initing: true,
      initStage: 'Contacting Scripts API for document...',
      content: `print('Hello World')`,
      loadingError: false,
      obfuscatingScript: false,
      processingData: {
        saving: false,
        obfuscating: false,
        prettyPrint: false
      },
      webWorkers: {
        prettyWorker: false
      }
    }
  },
  async mounted() {
    // Create our pretty print worker.
    this.webWorkers.prettyWorker = this.$worker.createWorker('PrettyWorker')
    this.webWorkers.prettyWorker.addEventListener('message', this.workerResponseHandler)
    // Contact server for document...
    const scriptRequest = await window.projectsAPI.getScript(this.scriptData.id, this.authToken)

    // Process and stuff
    if (scriptRequest.success) {
      this.content = scriptRequest.data
    } else {
      this.loadingError = true
    }

    // Init finished.
    this.initing = false

    // Check for web worker compatabiltiy
    if (!window.Worker) {
      window.createNotification('WARN', `Warning! Web Workers are not supported in this browser. Pretty Printing will lag or crash your browser!`, 13)
    }
  },
  methods: {
    workerResponseHandler: function (event) {
      if (event.data.success) {
        this.content = event.data.data
        this.processingData.prettyPrint = false
      } else {
        window.createNotification('ERROR', `ERROR: ${event.data.data}`, 15)
        this.processingData.prettyPrint = false
      }
    },
    editorInit: function (editor) {
      // Get ACE Extensions
      require('brace/ext/language_tools')
      require('brace/mode/lua')
      require('brace/theme/tomorrow_night.js')

      // Add customsiations
      editor.container.style.lineHeight = 2
      editor.renderer.updateFontSize()
    },
    closeEditor() {
      this.$emit('close-editor')
    },
    async openObfuscation() {
      await this.saveFile()
      this.obfuscatingScript = this.scriptData
    },
    closeObfuscation() {
      this.obfuscatingScript = null
    },
    saveFile: async function() {
      this.processingData.saving = true
      const form = new FormData()
      form.append('scriptID', this.scriptData.id)
      form.append('token', this.authToken)
      form.append('file', new Blob([this.content], { type: "text/plain;charset=utf-8" }))

      await fetch('https://next.psu.dev/api/v2/scripts/updateScript', {
        method: 'POST',
        body: form
      })
      .then(response => response.json())
      .then(async data => {
        if (data.success) {
          window.createNotification('INFO', `File successfully saved!`, 20)
          this.processingData.saving = false
        } else {
          window.createNotification('ERROR', `ERROR: ${data.error}`, 15)
          this.processingData.saving = false
        }
      })
      .catch(error => {
        window.createNotification('ERROR', `ERROR: ${error}`, 15)
        console.error(error)
        this.processingData.saving = false
      })

    },
    prettyPrint: function() {
      this.processingData.prettyPrint = true

      if (window.Worker) {
        this.webWorkers.prettyWorker.postMessage(this.content)
      } else {
        // No Web worker
        try {
          formatText(this.content)

          this.content = formatText(this.content)
          window.createNotification('INFO', `Successfully pretty-printed code!`, 20)
          this.processingData.prettyPrint = false
        } catch (err) {
          window.createNotification('ERROR', `ERROR: ${err}`, 15)
          this.processingData.prettyPrint = false
        }
      }
    }
  }
}
</script>

<style lang="scss">
  .PSUEditor {
    position: relative;
    width: 100%;
    height: 100%;

    .editorError {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      color: #595959;

      > svg {
        font-size: 200px;
        margin: 0 auto;
        display: block;
      }

      h1 {
        margin-top: 20px;
        font-weight: 500;
        margin-bottom: 0px;
      }

      p {
        margin-top: 10px;
        text-align: center;
      }

      span {
        margin: 0 auto;
        display: block;
        text-align: center;
        font-size: 20px;
        color: white;

        &:hover {
          cursor: pointer;
        }
      }
    }

    .editorContainer {
      width: 100%;
      height: calc(100% - 50px);
    }

    .editorToolbar {
      height: 50px;
      width: 100%;
      display: flex;
      position: relative;

      h1 {
        font-size: 25px;
      }

      button {
        padding-left: 10px;
        padding-right: 10px;
        height: 33px;
        line-height: 15px;
        margin-right: 5px;
      }

      .editorButtons {
        position: absolute;
        right: 10px;

        span {
          svg {
            display: inline-block;
            width: 12px;
          }
        }
      }
    }

    .lds-ring {
      display: inline-block;
      position: relative;
      width: 80px;
      height: 80px;
    }

    .lds-ring div {
      box-sizing: border-box;
      display: block;
      position: absolute;
      width: 64px;
      height: 64px;
      margin: 8px;
      border: 8px solid #595959;
      border-radius: 50%;
      animation: lds-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
      border-color: #595959 transparent transparent transparent;
    }
    .lds-ring div:nth-child(1) {
      animation-delay: -0.45s;
    }
    .lds-ring div:nth-child(2) {
      animation-delay: -0.3s;
    }
    .lds-ring div:nth-child(3) {
      animation-delay: -0.15s;
    }
    @keyframes lds-ring {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
      }
    }

    .initialising {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      width: 100%;
      text-align: center;
      color: #595959;

      h1 {
        font-size: 60px;
      }
    }
  }
</style>
