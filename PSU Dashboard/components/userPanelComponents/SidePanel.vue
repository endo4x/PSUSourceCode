<template>
  <div class="sidePanel">
    <div class="loader" v-if="loading" />
    <div class="head">
      <p class="error" v-if="error">ERROR: {{error}}</p>
      <input placeholder="Search" type="text" v-model="searchQuery" v-on:keyup.enter="reloadUsers" />
    </div>
    <div class="scrollSection">
      <PerfectScrollbar :options="{useBothWheelAxes: false, suppressScrollX: false}">
        <SidePanelEntry v-for="user in userData" :key="user.id" :user="user" v-on:select-user="selectUser" />
      </PerfectScrollbar>
    </div>
  </div>
</template>

<script>
import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
import SidePanelEntry from '@/components/userPanelComponents/sidePanelEntry'

export default {
  computed: {
    authToken() {return this.$store.state.userData.authToken}
  },
  data() {
    return {
      loading: true,
      userData: [],
      error: false,
      page: 0,
      searchQuery: ''
    }
  },
  components: {
    PerfectScrollbar,
    SidePanelEntry
  },
  methods: {
    selectUser(user) {
      this.$emit('select-user', user)
    },
    reloadUsers() {
      let body = {
          token: this.authToken,
          page: this.page
      }

      if (this.searchQuery.length > 0) {
        body.search = this.searchQuery
      }

      this.userData = []

      this.loading = true

      fetch("https://next.psu.dev/api/v2/auth/perms/get_users", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
      }).then(data => data.json())
        .then(data => this.handleResponse(data))
    },
    handleResponse(data) {
      if (data.success) {
        this.userData = data.data
      } else {
        this.error = data.message
      }

      this.loading = false
    }
  },
  mounted() {
    this.reloadUsers()
  }
}
</script>

<style lang="scss">
  .sidePanel {
    float: left;
    width: 300px;
    height: 100%;
    border-right: 2px solid var(--border);
    position: relative;
    display: flex;
    flex-direction: column;

    .head {
      input {
        width: 90%;
        margin: 0 auto;
        margin-top: 10px;
        font-size: 13px;
        height: 45px;
      }

      .error {
        width: 90%;
        margin: 0 auto;
        margin-top: 10px;
        text-align: center;
      }

      margin-bottom: 10px;
    }

    .scrollSection {
      height: calc(100% - 100px);
    }
  }

      .loader,
.loader:before,
.loader:after {
  border-radius: 50%;
}
.loader {
  position: absolute;
  left: 50%;
  top: 50%;
  color: #ffffff;
  font-size: 11px;
  text-indent: -99999em;
  width: 10em;
  height: 10em;
  box-shadow: inset 0 0 0 1em;
  -webkit-transform: translateZ(0) translateY(-50%) translateX(-50%);
  -ms-transform: translateZ(0) translateY(-50%) translateX(-50%);
  transform: translateZ(0) translateY(-50%) translateX(-50%);
}
.loader:before,
.loader:after {
  position: absolute;
  content: '';
}
.loader:before {
  width: 5.2em;
  height: 10.2em;
  background: var(--background);
  border-radius: 10.2em 0 0 10.2em;
  top: -0.1em;
  left: -0.1em;
  -webkit-transform-origin: 5.1em 5.1em;
  transform-origin: 5.1em 5.1em;
  -webkit-animation: load2 2s infinite ease 1.5s;
  animation: load2 2s infinite ease 1.5s;
}
.loader:after {
  width: 5.2em;
  height: 10.2em;
  background: var(--background);
  border-radius: 0 10.2em 10.2em 0;
  top: -0.1em;
  left: 4.9em;
  -webkit-transform-origin: 0.1em 5.1em;
  transform-origin: 0.1em 5.1em;
  -webkit-animation: load2 2s infinite ease;
  animation: load2 2s infinite ease;
}
@-webkit-keyframes load2 {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes load2 {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
</style>
