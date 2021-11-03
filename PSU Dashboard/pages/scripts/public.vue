<template>
  <div class="scriptsUI">
    <div class="scriptsUI">
      <p v-if="refreshingData" class="refreshData">Refreshing Data...</p>

      <div v-if="scripts.length <= 0" class="noScriptsMessage">
        <h1>No Scripts!</h1>
        <h2>There are no public scripts, Feel free to create one in "My Scripts"</h2>
        <nuxt-link to="/scripts/personal"><button>Goto My Scripts</button></nuxt-link>
      </div>

      <div class="scriptDisplay" v-if="scripts.length >= 1">
      <ScriptDisplayChild v-for="script in scripts"
      :key="script.id"
      :publicScript="true"
      v-bind:script="script"
      v-on:projectSelect="() => showLoadstring(script)"
      v-on:get-loadstring="() => showLoadstring(script)"
      />
      </div>
    </div>
    <div class="loadstringPopup" v-if="activeScript">
      <div class="core">
        <h1>Script Loadstring</h1>
        <input type="text" :value="`loadstring(game:HttpGet('https://cdn.psu.dev/publicScript/${activeScript.location}'))`" readonly ref="loadstring" />
        <div class="buttons">
          <button v-on:click="copyLoadstring">{{!dataCopied ? 'Copy Loadstring' : 'Copied!'}}</button>
          <button v-on:click="closeLoadstring">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dataLoaded: false,
      openScript: false,
      timer: null,
      refreshingData: false,
      errorLoading: false,
      activeScript: false,
      dataCopied: false
    }
  },
  computed: {
    scripts() {
      return this.$store.state.projectManager.currentPubProjects
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  methods: {
    showLoadstring(script) {
      this.activeScript = script
    },
    closeLoadstring() {
      this.activeScript = false
    },
    async copyLoadstring() {
      this.$refs.loadstring.select();
      this.$refs.loadstring.setSelectionRange(0, 99999);

      document.execCommand("copy");
      this.dataCopied = true
      await new Promise(resolve => setTimeout(resolve, 3000))
      this.dataCopied = false
    },
    processResponse(data) {
      if (data.success) {
        this.$store.commit('projectManager/SET_PUB_PROJECTS', data.data)
      } else {
        this.errorLoading = data.message
      }

      this.refreshingData = false
    },
    async loadData() {
      this.refreshingData = true
      await fetch('https://next.psu.dev/api/v2/scripts/public/getAllScripts', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken
        })
      })
      .then(data => data.json())
      .then(data => this.processResponse(data))
      .catch(err => {
        console.error(err)
        this.errorLoading = "Something went wrong loading data. Please check console."
      })
    }
  },
  mounted() {
    this.$store.commit('routerManager/CHANGE_PAGE', 'Public Scripts')
    this.loadData()
  },
}
</script>

<style lang="scss">
    .scriptsUI {
      width: 100%;
      height: 100%;
    }

    .noScriptsMessage {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      text-align: center;

      color: var(--text-color-secondary);

      h1 {
        font-size: 100px;
      }

      h2 {
        margin-top: 0px;
      }

      button {
        margin-top: 30px;
        font-size: 20px;
      }
    }

  .loadstringPopup {
    position: absolute;
    width: calc(100% + 40px);
    height: calc(100% + 40px);
    left: -20px;
    top: -20px;
    background: #000000a8;
    z-index: 10;

    .core {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      width: 800px;
      border-radius: 20px;
      background: var(--background);
      max-height: 100%;
      overflow-y: auto;
      padding: 20px;
      box-sizing: border-box;

      > h1 {
        text-align: center;
      }

      > input {
        margin: 0 auto;
        width: 90%;
        font-size: 12px;
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
      }

      .buttons {
        display: flex;
        justify-content: center;

        > button {
          margin-left: 10px;
          margin-right: 10px;
        }
      }
    }
  }

  .refreshData {
    position: absolute;
    right: 0px;
    top: 0px;
    animation: fadeInOut 1s ease-in-out infinite;
  }
</style>
