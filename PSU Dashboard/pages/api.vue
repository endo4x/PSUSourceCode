<template>
  <div class="apiPage">
    <div class="apiKeySection pageSection">
      <div class="text">
        <h1>API Key</h1>
        <p>Your API key for using the PSU Obfuscation API</p>
      </div>
      <div class="apiKeyDisplay">
        <input readonly ref="APIKey" type="text" v-bind:value="apiKey">
        <button v-on:click="copyAPIKey">{{ dataCopied.APIKey ? 'Copied!' : 'Copy' }}</button>
      </div>
    </div>

    <div class="apiExampleSection pageSection">
      <div class="text">
        <h1>API Sandbox</h1>
        <p>Immediately start testing and experimenting with the PSU API using this API Sandbox. It allows you to create and visualise what your requests will look like.</p>
      </div>
    </div>

    <div class="sandboxDisplay">
      <div class="sandboxTabs">
        <span v-on:click="() => changeSandboxTab(0)" v-bind:class="sandboxTab == 0 ? 'selected': ''">Request</span>
        <span v-on:click="() => changeSandboxTab(1)" v-bind:class="sandboxTab == 1 ? 'selected': ''">Response</span>
      </div>
      <textarea v-if="sandboxTab == 0" v-bind:value="computedVersion" readonly ref="APIJSON" />
      <textarea v-if="sandboxTab == 1" v-bind:value="computedResponse" readonly />
      <div v-if="sandboxTab == 0" class="jsonCopy">
        <button v-on:click="copyJSON">{{ dataCopied.APIJSON ? 'Copied!' : 'Copy JSON' }}</button>
        <button v-on:click="submitRequest" :disabled="processingResponse">Submit Request</button>
      </div>
      <h3>Endpoint</h3>
      <input type="text" value="https://api.psu.dev/obfuscate" readonly>
    </div>

    <div class="sandboxControls">
      <div class="option">
        <h4>Encrypt All Strings
          <span
          content="Encrypts every string that is being obfuscated by PSU Obfuscator. May decrease performance drastically."
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.EncryptAllStrings">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Enhanced Output
          <span
          content='This will make your file size considerably larger and can affect performance.'
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.EnhancedOutput">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Maximum Security
          <span
          content="Enables Max Security to prevent deobfuscation and avoid hooking the Equality Opcode."
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.MaximumSecurityEnabled">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Disable Super Operators
          <span
          content="Disables the generation of super operators; this fixes some of the problems when using the obfuscator, but may decrease the performance of your script."
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.DisableSuperOperators">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Disable All Macros
          <span
          content="Disables all PSU Macros"
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.DisableAllMacros">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Compress Output
          <span
          content="Compress the output of the script to create a smaller file size."
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.CompressedOutput">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Premium Format
          <span
          content="This uses a more complex script structure. This is best paired with PSU_MAX_SECURITY Macro."
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <label class="toggle-control">
          <input type="checkbox" v-model="requestOptions.PremiumFormat">
          <span class="control"></span>
        </label>
      </div>
      <div class="option">
        <h4>Vanity Bytecode
          <span
          content="This replaces the Base36 bytecode skin into a custom one."
          v-tippy>
            <font-awesome-icon icon="info-circle" />
          </span>
        </h4>
        <v-select :appendToBody="true" :clearable="false" v-model="requestOptions.ByteCodeMode" :options="['Default', 'Chinese', 'Arabic', 'Korean', 'Emoji', 'Emoji 2', 'Greek', 'Symbols 1', 'Symbols 2', 'Symbols 3']"></v-select>
      </div>
    </div>

    <div class="regenerateAPI">
      <div class="text">
        <h1>Stolen API Key?</h1>
        <p class="error" v-if="regenError">ERROR: {{regenError}}</p>
        <p>Did you accidentally push your key into a public github repo again? No worries. Simply regenerate your API Key by clicking the button below.</p>
      </div>
      <button class="warning" v-on:click="regenerateAPIKey">
        <span v-if="!processingRegen">Regenerate Key</span>
        <span v-if="processingRegen"><font-awesome-icon icon="spinner" spin /></span>
      </button>
      <p class="error">WARNING: Regenerating your API Key will remove the previous API Key.</p>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    hasPremium() {
      return this.$store.state.userData.currentUser.has_premium
    },
    apiKey() {
      return this.$store.state.userData.currentUser.api_key
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  data() {
    return {
      regenError: false,
      processingRegen: false,
      processingResponse: false,
      dataCopied: {
        APIKey: false,
        APIJSON: false
      },
      sandboxTab: 0,
      script: "print('Hello World!')",
      requestOptions: {
        DisableSuperOperators: false,
        MaximumSecurityEnabled: false,
        EncryptAllStrings: false,
        DisableAllMacros: false,
        EnhancedOutput: false,
        CompressedOutput: false,
        PremiumFormat: false,
        ByteCodeMode: 'Default'
      },
      computedVersion: '',
      computedResponse: 'No Response, Create a request first.'
    }
  },
  watch: {
    requestOptions: {
      deep: true,
      handler() {
        this.computeJSON()
      }
    },
    apiKey() {
      this.computeJSON()
    }
  },
  mounted() {
    if (!this.hasPremium) {
      this.$router.push('/purchasePremium')
    }
    this.computeJSON()
    this.$store.commit('routerManager/CHANGE_PAGE', 'API')
  },
  methods: {
    async submitRequest() {
      if (this.processingResponse) {return}
      this.processingResponse = true
      await fetch('https://api.psu.dev/obfuscate', {
        method: 'POST',
        body: this.computedVersion
      }).then(data => data.json())
        .then(data => {this.computedResponse = JSON.stringify(data, null, 2); this.sandboxTab = 1})
        .catch(err => {console.error(err); this.computedResponse = 'Something went wrong processing this request, Please check console log.'; this.sandboxTab = 1})
      this.processingResponse = false
    },
    processAPIRegen(data) {
      if (data.success) {
        this.$store.commit('userData/SET_APITOKEN', data.api_key);
      } else {
        this.regenError = data.message
      }

      this.processingRegen = false
    },
    async regenerateAPIKey() {
      if (this.processingRegen) {return}
      this.processingRegen = true
      fetch('https://next.psu.dev/api/v2/auth/regenerate_apikey', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken
        })
      })
      .then(data => data.json())
      .then(data => this.processAPIRegen(data))
      .catch(err => {
        this.regenError = err
      })
    },
    changeSandboxTab(index) {
      this.sandboxTab = index
    },
    computeJSON() {
      let JSONData = {
        script: this.script,
        key: this.apiKey,
        options: this.requestOptions
      }
      this.computedVersion = JSON.stringify(JSONData, null, 2)
    },
    async copyJSON() {
      this.$refs.APIJSON.select();
      this.$refs.APIJSON.setSelectionRange(0, 99999);

      document.execCommand("copy");
      this.dataCopied.APIJSON = true
      await new Promise(resolve => setTimeout(resolve, 3000))
      this.dataCopied.APIJSON = false
    },
    async copyAPIKey() {
      this.$refs.APIKey.select();
      this.$refs.APIKey.setSelectionRange(0, 99999);

      document.execCommand("copy");
      this.dataCopied.APIKey = true
      await new Promise(resolve => setTimeout(resolve, 3000))
      this.dataCopied.APIKey = false
    }
  }
}
</script>

<style lang="scss">
  .apiPage {
    font-family: "Poppins", sans-serif;
  }

  .apiExampleSection {
    width: calc(100% - 650px);

    .text {
      max-width: 100% !important;
    }
  }

  .sandboxControls {
    margin-top: 30px;
    width: calc(100% - 650px);
    height: 300px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    flex-wrap: wrap;

    > .option {
      height: 25px;
      max-width: 45%;
      margin-bottom: 30px;
      svg {
        width: 15px;
        cursor: pointer;
        transform: translateY(2px);
      }

      .v-select {
        width: 150px;
        float: right;
      }

      > h4 {
        float: left;
        margin: 0px;

        svg {
          color: #717171;

          &:hover {
            cursor: pointer;
          }
        }
      }

      > label {
        float: right;
      }

      > select {
        float: right;
      }
    }
  }

  .pageSection {
    height: 100px;


    .text {
      float: left;
      > p, > h1 {
        margin: 0px;
      }

      max-width: calc(100% - 650px);

    }

    .apiKeyDisplay {
      float: right;
    }
  }

  .regenerateAPI {
    width: calc(100% - 650px);

    button {
      margin: 0 auto;
      display: block;
      padding-left: 30px;
      padding-right: 30px;

      svg {
        height: 20px;
      }
    }

    p.error {
      width: 100%;
      text-align: center;
    }
  }

  .sandboxDisplay {
    height: 640px;
    width: 600px;
    position: relative;
    background: var(--background-secondary);
    border: 1px solid var(--border);
    border-radius: 10px;
    float: right;
    transform: translateY(-100px);

    .jsonCopy {
      position: absolute;
      bottom: 150px;
      right: 40px;

      > button {
        padding: 7px;
        font-size: 12px;
      }

    }

    > textarea {
      width: 90% !important;
      height: calc(100% - 200px);
      display: block;
      margin: 0 auto;
      margin-top: 10px;
      font-family: Consolas, 'Lucida Console', 'DejaVu Sans Mono', monospace;
    }

    > input {
      width: 90% !important;
      margin: 0 auto;
    }

    > h3 {
      text-align: center;
    }

    .sandboxTabs {
      display: flex;
      height: 50px;
      justify-content: center;
      align-items: center;
      box-sizing: border-box;

      > span {
        display: block;
        width: 100px;
        height: 30px;
        text-align: center;
      };

      .selected {
        border-bottom: 2px var(--border) solid;
      }

      &:hover {
        cursor: pointer;
      }
    }
  }

  .apiKeyDisplay {
    margin-top: 20px;
    > input {
      display: block;
      width: 600px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      float: left;
    }

    > button {
      float: left;
      margin-left: 10px;
      height: 50px;
    }
  }
</style>
