<template>
  <div class="scriptsUI">
    <div class="scriptPage" v-if="currentStage == 0" @drop="handleFileDrop" @dragover="onDropEnter" @dragleave="onDropLeave">
      <div class="scriptsUIHeader">
        <button v-on:click="() => this.currentStage = 1" v-if="scripts.length >= 1">Create New</button>
        <p v-if="refreshingData">Refreshing Data...</p>
      </div>

      <div v-if="scripts.length <= 0 && !fileHovering" class="noScriptsMessage">
        <h1>No Scripts!</h1>
        <h2>You currently have no scripts, would you like to create one?</h2>
        <p>TIP: You can drag and drop scripts into this section to upload them.</p>
        <button v-on:click="() => this.currentStage = 1">Create New</button>
      </div>

      <div class="dragOverlay" v-if="fileHovering">
        <h1>Drop file to upload</h1>
      </div>

      <div class="scriptDisplay" v-if="scripts.length >= 1 && !fileHovering">
        <ScriptDisplayChild v-for="script in scripts"
        :key="script.id"
        v-bind:script="script"
        v-on:request-refresh="loadData"
        v-on:projectSelect="() => openEditor(script)"
        v-on:request-obfuscation="() => openObfuscation(script)"
        />
      </div>
    </div>

    <div class="scriptPage" v-if="currentStage == 1">
      <CreateNewScript v-bind:currentFile="currentFile" v-on:cancelEvent="cancelNewScript" v-on:project-created="cancelNewScript" />
    </div>

    <div class="scriptPage" v-if="currentStage == 2">
      <Editor v-bind:scriptData="openScript" v-on:close-editor="closeEditor" />
    </div>

    <div class="obfuscationPopup" v-if="obfuscatingScript" v-on:click.self="closeObfuscation">
      <Obfuscate v-bind:scriptData="obfuscatingScript" v-on:close-obfuscator="closeObfuscation" />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dataLoaded: false,
      fileHovering: false,
      openScript: false,
      currentStage: 0,
      currentFile: null,
      openID: null,
      obfuscatingScript: false,
      timer: null,
      refreshingData: false
    }
  },
  computed: {
    hasPremium() {
      return this.$store.state.userData.currentUser.has_premium
    },
    scripts() {
      return this.$store.state.projectManager.currentProjects
    },
    userData() {
      return this.$store.state.userData.currentUser
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  },

  methods: {
    handleFileDrop(event) {
      event.preventDefault();
      this.fileHovering = false
      this.createNewScript(event.dataTransfer.files)
    },
    onDropEnter(event) {
      event.preventDefault();
      this.fileHovering = true
    },
    onDropLeave() {
      this.fileHovering = false
    },
    createNewScript(file) {
      this.currentStage = 1
      this.currentFile = file
    },
    cancelNewScript() {
      this.currentStage = 0
      this.currentFile = false
    },
    openEditor(scriptData) {
      this.currentStage = 2
      this.openScript = scriptData
    },
    closeEditor() {
      this.currentStage = 0
      this.openScript = false
    },
    openObfuscation(script) {
      this.obfuscatingScript = script
    },
    closeObfuscation() {
      this.obfuscatingScript = null
    },
    async loadData() {
      this.refreshingData = true
      if (typeof window.loadProjects == "undefined") {
        setTimeout(this.loadData, 1000)
      } else {
        window.loadProjects(this.authToken).then(value => {
          this.$store.commit('projectManager/SET_PROJECTS', value)
          this.refreshingData = false
        })
      }
    }
  },

  mounted() {
    if (!this.hasPremium) {
      this.$router.push('/purchasePremium')
    }
    this.$store.commit('routerManager/CHANGE_PAGE', 'My Scripts')
    window.projectsAPI.loadData = this.loadData
    this.loadData()
    this.timer = setInterval(this.loadData, 60000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>

<style lang="scss">
  .scriptsUI, .scriptPage {
    position: relative;
    width: 100%;
    height: 100%;
  }

  .scriptsUIHeader {
    height: 50px;
    position: relative;

    > button {
      margin-left: 10px;
    }

    > p {
      position: absolute;
      right: 0px;
      top: 0px;

      animation: fadeInOut 1s ease-in-out infinite;
    }
  }

  @keyframes fadeInOut {
    0% {
      color: #fff;
    }

    50% {
      color: #ffffff7a;
    }

    100% {
      color: #fff;
    }
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

  .dragOverlay {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translateX(-50%) translateY(-50%);
    text-align: center;
    border-radius: 50px;

    text-align: center;

    color: var(--text-color-secondary);

    h1 {
      font-size: 50px;
    }
  }

  .scriptDisplay {
    display: flex;
    width: 100%;
    height: calc(100% - 50px);
    flex-wrap: wrap;
    align-content: flex-start;
  }
</style>
