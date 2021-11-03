<template>
  <div class="linkDiscord">
    <div v-if="loadingLink">
      <h2>Linking Discord...</h2>
      <div class="lds-ring premiumLoader"><div></div><div></div><div></div><div></div></div>
    </div>
    <div v-if="loadingError" >
      <h2>Link Error!</h2>
      <p class="error">ERROR: {{loadingError}}</p>
      <button v-on:click="returnToDash">Return to dashboard</button>
    </div>
    <div v-if="!loadingLink && discordUser" class="linkSuccess">
      <h2>Link Success!</h2>
      <div class="linkedImages">
        <img :src="currentUser.avatar" />
        <font-awesome-icon icon="check-circle" />
        <img :src="`https://cdn.discordapp.com/avatars/${discordUser.id}/${discordUser.avatar}.png`" />
      </div>
      <h3>Hello {{discordUser.username}}#{{discordUser.discriminator}}!</h3>
      <p>Your Discord account has been successfully linked with your PSU Account. Any benefits you have on the PSU Website has been transfered over to your Discord Account.</p>
      <button v-on:click="returnToDash">Return to Home</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loadingLink: true,
      loadingError: false,
      discordUser: null
    }
  },
  methods: {
    returnToDash() {
      this.$router.push("/")
    },
    async refreshProfile() {
      let response = await fetch('https://next.psu.dev/api/v2/auth/me', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              "token": this.authToken
          })
      })
          .then(response => response.json())
          .catch(err => {
              this.processingRequest = false
              this.loginError = err.message
          });

      if (response.success) {
        this.$store.commit('userData/SET_USER', response.userData)
        return
      } else {
        // Handle error
        document.cookie = "PSUToken=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
        console.error(response.message)
      }
    },
  },
  computed: {
    authToken() {return this.$store.state.userData.authToken},
    currentUser() {
      return this.$store.state.userData.currentUser
    }
  },
  async mounted() {
    let response = await fetch("https://next.psu.dev/api/v2/auth/connnections/discord", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        token: this.authToken,
        discord_code: new URLSearchParams(document.location.search).get("code")
      })
    }).then(data => data.json())
      .catch(err => {
        this.loadingError = 'Something went wrong connecting your discord account. Please try again another time.'
        this.loadingLink = false
        })

    if (response.success) {
      this.loadingLink = false
      this.discordUser = response.user
      this.refreshProfile()
    } else {
      this.loadingError = response.message
      this.loadingLink = false
    }
  }
}
</script>

<style lang="scss">
  .linkDiscord {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translateX(-50%) translateY(-50%);
    border: var(--border) 2px solid;
    padding: 10px;
    border-radius: 10px;
    width: 500px;
    text-align: center;
  }

  .linkSuccess {
    h2 {
      font-size: 30px;
      margin-bottom: 5px;
    }

    p {
      text-align: center;
    }

    .linkedImages {
      display: flex;

      justify-content: center;

      svg {
        width: 50px;
        margin: 40px;
        color: #4eca43;
      }

      img {
        height: 150px;
        width: 150px;
        border-radius: 50%;
      }
    }
  }
</style>
