<template>
  <div class="scriptDisplayChild" v-on:click.self="openProject">
    <div class="text" v-on:click="openProject">
      <h1>{{ script.title }}</h1>
      <p>{{ script.description }}</p>
    </div>
    <span v-if="script.public" class="publicNotice">Public</span>
    <div class="scriptDropdown" v-on:click.self="triggerDropdown" v-click-outside="closeDropdown">
      <svg v-on:click="triggerDropdown" xmlns="http://www.w3.org/2000/svg" width="19" height="5" class="">
        <g transform="translate(1287 -1704)" fill="#d1d1d1">
          <circle data-name="Ellipse 1" cx="2.5" cy="2.5" r="2.5" transform="translate(-1287 1704)"></circle>
          <circle data-name="Ellipse 2" cx="2.5" cy="2.5" r="2.5" transform="translate(-1280 1704)"></circle>
          <circle data-name="Ellipse 3" cx="2.5" cy="2.5" r="2.5" transform="translate(-1273 1704)"></circle>
        </g>
      </svg>
      <Dropdown ref="dropdownComponent">
        <span v-if="!publicScript" v-on:click.self="openProject">Open Editor</span>
        <span v-if="!publicScript" v-on:click.self="startObfuscation">Obfuscate</span>
        <span v-if="!publicScript" v-on:click="deleteProject" class="alertOption">Delete</span>
        <span v-if="publicScript" v-on:click="getLoadstring">Get Loadstring</span>
        <span v-on:click="closeDropdown">Cancel</span>
      </Dropdown>
    </div>
  </div>
</template>

<script>
export default {
  props: ['script', 'publicScript'],
  computed: {
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  methods: {
    triggerDropdown: function () {
      this.$refs.dropdownComponent.openDropdown()
    },
    closeDropdown: function () {
      this.$refs.dropdownComponent.closeDropdown()
    },
    deleteProject: async function () {
      await window.projectsAPI.deleteScript(this.script.id, this.authToken)
      this.$emit('request-refresh')
    },
    openProject: function() {
      this.closeDropdown()
      this.$emit('projectSelect')
    },
    startObfuscation: function() {
      this.closeDropdown()
      this.$emit('request-obfuscation')
    },
    getLoadstring: function() {
      this.closeDropdown()
      this.$emit('get-loadstring')
    }
  }
}
</script>

<style lang="scss">
  .scriptDisplayChild {
    width: 230px;
    height: 230px;
    background: var(--background-secondary);
    margin: 10px;
    border-radius: 20px;
    font-family: "Poppins", sans-serif;
    position: relative;

    .publicNotice {
      background: #239177;
      margin-bottom: 10px;
      padding: 4px;
      border-radius: 3px;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
      bottom: 10px;
      font-weight: bold;
    }

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

    .scriptDropdown {
      position: absolute;
      right: 20px;
      top: 10px;
    }

    &:hover {
      cursor: pointer;
    }
  }
</style>
