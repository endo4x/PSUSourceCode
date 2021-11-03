<template>
  <div class="obfuscationWizard">
    <div v-if="!processingObfus && !obfusScript">
      <h1>Obfuscate Script</h1>
      <div class="scriptPreview">
        <div class="text">
          <h1>{{scriptData.title}}</h1>
          <p>{{scriptData.description}}</p>
        </div>
      </div>
      <div class="option">
        <h2>Advanced Options</h2>
        <label class="toggle-control">
          <input type="checkbox" v-model="advOptionsOpen">
          <span class="control"></span>
        </label>
      </div>
      <div class="option" v-if="advOptionsOpen">
        <h4>
          <span
            content='This replaces the Base36 bytecode skin into a custom one.'
            v-tippy>
              <font-awesome-icon icon="info-circle" />
          </span> Vanity Bytecode</h4>
        <v-select :appendToBody="true" :clearable="false" v-model="advOptions.selectBytecode" :options="['Default', 'Chinese', 'Arabic', 'Korean', 'Emoji', 'Emoji 2', 'Greek', 'Symbols 1', 'Symbols 2', 'Symbols 3']"></v-select>
      </div>
      <div class="option" v-if="advOptionsOpen">
        <h4>
          <span
            content='Encrypts every string that is being obfuscated by PSU Obfuscator. May decrease performance drastically.'
            v-tippy>
              <font-awesome-icon icon="info-circle" />
          </span> Encrypt All Strings</h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="advOptions.EncryptAllStrings">
          <span class="control"></span>
        </label>
      </div>
      <div class="option" v-if="advOptionsOpen">
        <h4>
          <span
            content='This will make your file size considerably larger and can affect performance.'
            v-tippy>
              <font-awesome-icon icon="info-circle" />
          </span> Enhanced Output</h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="advOptions.EnhancedOutput">
          <span class="control"></span>
        </label>
      </div>
      <div class="option" v-if="advOptionsOpen">
        <h4>
          <span
            content='Enables Max Security to prevent deobfuscation and avoid hooking the Equality Opcode.'
            v-tippy>
              <font-awesome-icon icon="info-circle" />
          </span> Maximum Security</h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="advOptions.MaximumSecurityEnabled">
          <span class="control"></span>
        </label>
      </div>
      <div class="option" v-if="advOptionsOpen">
        <h4>
          <span
            content='Disables the generation of super operators; this fixes some of the problems when using the obfuscator, but may decrease the performance of your script.'
            v-tippy>
              <font-awesome-icon icon="info-circle" />
          </span> Disable Super Operators</h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="advOptions.DisableSuperOperators">
          <span class="control"></span>
        </label>
      </div>
      <button v-bind:disabled="startingObf" v-on:click="queueObfuscation"><span v-if="startingObf"><font-awesome-icon icon="spinner" spin /></span> <span v-if="startingObf">{{obfusButtonStage}}</span> <span v-if="!startingObf">Start Obfuscation</span></button>
    </div>
    <div v-if="processingObfus && !obfusScript">
      <div class="loadingIcon">
        <div class="lds-ring"><div></div><div></div><div></div><div></div></div>
        <h2>Processing Obfuscation...</h2>
      </div>
    </div>
    <div v-if="obfusScript" class="completedObfus">
      <h1>Your obfuscated script</h1>
      <button class="copyButton" v-on:click="copyScript">{{ dataCopied ? 'Copied!' : 'Copy' }}</button>
      <textarea ref="computedScript" v-model="obfusScript" />
      <div class="buttons">
        <button v-on:click="saveFile">Save to File</button>
        <button v-on:click="closeObfus">Return</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props:['scriptData'],
  data() {
    return {
      advOptionsOpen: false,
      startingObf: false,
      obfusButtonStage: 'Requesting Document...',
      processingObfus: false,
      obfusScript: null,
      dataCopied: false,
      advOptions: {
        EncryptAllStrings: false,
        EnhancedOutput: false,
        MaximumSecurityEnabled: false,
        DisableSuperOperators: false,
        selectBytecode: 'Default'
      }
    }
  },
  computed: {
    apiKey() {
      return this.$store.state.userData.currentUser.api_key
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  methods: {
    async copyScript() {
      this.$refs.computedScript.select();
      this.$refs.computedScript.setSelectionRange(0, 999999999);

      document.execCommand("copy");
      this.dataCopied = true
      await new Promise(resolve => setTimeout(resolve, 3000))
      this.dataCopied = false
    },
    saveFile() {
      const myBlob = new Blob([this.obfusScript], {type : 'text/plain'});

      let url = URL.createObjectURL(myBlob)

      var a = document.createElement("a");
      document.body.appendChild(a);
      a.style = "display: none";
      a.href = url;
      a.download = "obfuscatedScript.lua";
      a.click();
      window.URL.revokeObjectURL(url);
    },
    closeObfus() {
      this.$emit('close-obfuscator')
    },
    async processObfusResponse(data) {
      if (data.status === "passed") {
        this.obfusScript = data.data

        if (this.scriptData.public) {
          // Upload public in the background
          fetch('https://next.psu.dev/api/v2/scripts/updatePublicScript', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              token: this.authToken,
              script_id: this.scriptData.id
            })
          })
        }
      } else {
        // Throw error
      }
    },
    async requestObfuscation(scriptData) {
      await fetch('https://api.psu.dev/obfuscate', {
        method: 'POST',
        body: JSON.stringify({
          script: scriptData.data,
          key: this.apiKey,
          options: this.advOptions,
          publicScript: this.scriptData.public
        })
      })
      .then(data => {
        return data
        })
      .then(data => data.json())
      .then(data => this.processObfusResponse(data))
    },
    async queueObfuscation() {
      this.startingObf = true
      this.obfusButtonStage = 'Requesting Document...'
      let documentData
      const scriptRequest = await window.projectsAPI.getScript(this.scriptData.id, this.authToken)

      if (scriptRequest.success) {
        documentData = scriptRequest.data
      } else {
        this.startingObf = false
        window.createNotification('ERROR', `Something went wrong getting the script.`, 15)
        return
      }

      this.obfusButtonStage = 'Queuing Script...'

      await new Promise(resolve => setTimeout(resolve, 2000))
      window.createNotification('INFO', `Script obfuscation started!`, 20)

      this.requestObfuscation(scriptRequest)
      this.startingObf = false
      this.processingObfus = true
    }
  }
}
</script>

<style lang="scss">
  .obfuscationPopup {
    width: calc(100% + 40px);
    height: calc(100% + 40px);
    position: absolute;
    left: -20px;
    top: -20px;
    background: #000000a8;
    z-index: 10;
  }

  .completedObfus {
    textarea {
      width: 90% !important;
      height: calc(100vh - 500px);
      display: block;
      margin: 0 auto;
      margin-top: 30px;
      margin-bottom: 30px;
      font-family: Consolas, "Lucida Console", "DejaVu Sans Mono", monospace;
    }

    .copyButton {
      position: absolute;
      right: 80px;
      bottom: 110px;
      font-size: 12px;
      padding: 8px;
    }

    .buttons {
      display: flex;
      align-content: center;
      justify-content: center;

      button {
        margin-left: 10px;
        margin-right: 10px;
      }
    }
  }

  .loadingIcon {
    text-align: center;
    margin-top: 30px;
    margin-bottom: 30px;

    .lds-ring {
      scale: 1.2;
    }

    h2 {
      font-weight: 200 !important;
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
  border: 8px solid #fff;
  border-radius: 50%;
  animation: lds-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
  border-color: #fff transparent transparent transparent;
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

  .scriptPreview {
    width: 230px;
    height: 230px;
    background: var(--background-secondary);
    margin: 0 auto;
    margin-top: 20px;
    margin-bottom: 20px;
    border-radius: 20px;
    font-family: "Poppins", sans-serif;
    position: relative;

    h1, p {
      text-align: center;
      width: 100%;
      margin: 0px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      text-align: center;
    }

    h1 {
      font-size: 30px;
    }

    .text {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      width: 100%;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      text-align: center;
    }
  }

  .obfuscationWizard {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translateX(-50%) translateY(-50%);
    width: 600px;
    border-radius: 20px;
    background: var(--background);
    max-height: 100%;
    overflow-y: auto;

    padding: 20px;
    box-sizing: border-box;

    > div {

    > h1 {
      text-align: center;
    }

    > .option {
      height: 50px;
      position: relative;

      .v-select {
        position: absolute;
        right: 0px;
        top: 50%;
        transform: translateY(-50%);
        height: 25px;
        width: 150px;
        border-radius: 5px;
        border: none;
      }

      svg {
        width: 15px;
        cursor: pointer;
        transform: translateY(2px);
      }

      > select {
        position: absolute;
        right: 0px;
        top: 50%;
        transform: translateY(-50%);
        height: 25px;
        width: 150px;
        border-radius: 5px;
        border: none;
      }

      > h2 {
        margin-bottom: 0px;
        text-align: left;
        position: absolute;
        left: 0px;
        top: 50%;
        transform: translateY(-50%);
        margin: 0px;
        font-weight: 400;
      }

      > h4 {
        margin-bottom: 0px;
        text-align: left;
        position: absolute;
        left: 0px;
        top: 50%;
        transform: translateY(-50%);
        margin: 0px;
        font-weight: 400;
      }

      > .toggle-control {
        right: 0px;
        top: 50%;
        transform: translateY(-50%);
        height: 25px;

        width: 100px;
        float: right;
      }

      > .toggle-control .control {
        right: 0px;
        left: unset;
      }
    }

    > button {
      margin: 0 auto;
      display: block;

        svg {
          width: 15px;
          cursor: pointer;
          transform: translateY(2px);
        }
      }
    }
  }
</style>
