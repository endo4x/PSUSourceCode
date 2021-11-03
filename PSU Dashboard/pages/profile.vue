<template>
  <div class="profileEditpage">
    <div class="profileEditHeader">
      <div class="avatarDisplay" v-on:click="startImageUpload">
        <img :src="currentUser.avatar">
        <div class="editImageButton"><font-awesome-icon icon="pen" /></div>
      </div>
      <div class="profileDetails">
        <h1>{{currentUser.username}}<font-awesome-icon icon="crown" v-tippy content="Premium User" v-if="currentUser.has_premium"/></h1>
        <h2>{{currentUser.email}}</h2>
        <p style="width:1000px" id="premiumEnds"></p>
      </div>
    </div>
    <p class="error" v-if="profileEditError">{{profileEditError}}</p>
    <form class="editForm" v-on:submit.prevent="updateProfile">
      <div class="field">
        <span>First Name</span>
        <input type="text" required v-model="formData.first_name">
      </div>
      <div class="field">
        <span>Last Name</span>
        <input type="text" required v-model="formData.last_name">
      </div>
      <div class="field">
        <span>Email Address</span>
        <input type="email" required v-model="formData.email">
      </div>
      <div class="field">
        <span>Last Login</span>
        <input type="text" required v-model="currentUser.last_login" readonly>
      </div>
      <div class="field" v-if="!currentUser.discord_username">
        <span>Link Discord</span>
        <a type="button" href="https://discord.com/api/oauth2/authorize?client_id=818928010820321300&redirect_uri=https%3A%2F%2Fpsu.dev%2FlinkDiscord&response_type=code&scope=identify%20email%20guilds.join"><button type="button" class="discordButton">
          <font-awesome-icon :icon="['fab', 'discord']" />
          <span>Login with Discord</span></button></a>
      </div>
      <div class="field discordField" v-if="currentUser.discord_username">
        <span>Linked Discord User</span>
        <div>
          <img :src="currentUser.discord_avatar" />
          <h4>{{currentUser.discord_username}}</h4>
          <p>{{currentUser.discord_id}}</p>
        </div>
        <button type="button" :disabled="processingDelink" v-on:click="delinkDiscord">Unlink Account</button>
        <p class="unlinkWarn">Unlinking will remove any PSU benefits that user has.</p>
      </div>
      <div class="buttons">
        <button type="submit" :disabled="processingUpdate"><span v-if="!updateSuccess">Save Changes</span><span v-if="updateSuccess"><font-awesome-icon icon="check-circle" /></span></button>
      </div>
    </form>
  </div>
</template>

<script>
import parse from 'postgres-date';

export default {
  data() {
    return {
      premiumEnds: false,
      processingDelink: false,
      processingUpdate: false,
      updateSuccess: false,
      profileEditError: false,
      formData: {
        email: '',
        first_name: '',
        last_name: '',
      }
    }
  },
  methods: {
    prependZero(number) {
      if (number < 9)
        return "0" + number;
      else
        return number;
    },
    async updateProfile() {
      this.processingUpdate = true
      this.profileEditError = false

      let response = await fetch('https://next.psu.dev/api/v2/auth/me/update', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({token: this.authToken, ...this.formData})
      }).then(data => data.json())
        .catch(err => this.profileEditError = err)

      if (!response.success) {
        this.profileEditError = response.message
        this.processingUpdate = false
        return
      }

      await this.refreshProfile()

      this.updateSuccess = true

      await new Promise(resolve => setTimeout(resolve, 500))

      this.updateSuccess = false

      this.processingUpdate = false
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
    async delinkDiscord() {
      this.processingDelink = true

      await fetch('https://next.psu.dev/api/v2/auth/connnections/delink_discord', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken
        })
      })

      await this.refreshProfile()

      this.processingDelink = false
    },
    async handleUpload(data) {
      // TODO: Add downscaling for files bigger than 5MB.

      var file = data.srcElement.files[0]

      if (!(file && file.size < 5242880)) {
        return
      }

      this.processingAvatarChange = true

      let formObject = new FormData()

      formObject.append('file', file, file.name)
      formObject.append('token', this.authToken)

      // Upload file here
      await fetch('https://next.psu.dev/api/v2/auth/update_avatar', {
        method: 'POST',
        body: formObject
      })

      //TODO: Handle Errors

      this.refreshProfile()
    },
    async updatePremiumExpiry() {
    if (this.currentUser.has_premium) {
      let premiumDate = parse(this.currentUser.has_premium)
      let premiumText = document.getElementById('premiumEnds');
      if (premiumDate.getFullYear() > 2200) {
        premiumText.innerHTML = "Premium Status: <b>Lifetime</b>"
      } else {
         premiumText.innerHTML = `Premium Expires at: <b>${premiumDate.toLocaleTimeString()} ${premiumDate.toLocaleDateString()}</b> (UTC)`
      }
    }
  },
    startImageUpload() {
      var fileUpload = document.createElement("input")
      fileUpload.type = "file"
      fileUpload.accept = "image/jpeg, image/png, image/gif"

      fileUpload.addEventListener('change', this.handleUpload)

      fileUpload.click();
    }
  },
  mounted() {
    this.updatePremiumExpiry();

    this.formData = {
      email: this.currentUser.email,
      first_name: this.currentUser.first_name,
      last_name: this.currentUser.last_name
    }
  },
  computed: {
    currentUser() {
      return this.$store.state.userData.currentUser
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  }
}
</script>

<style lang="scss">
  .profileEditpage {
    max-width: 1000px;
    margin: 0 auto;
    position: relative;

    .profileEditHeader {
      height: 150px;

      .avatarDisplay {
        position: relative;
        width: 150px;
        height: 150px;
        float: left;
        box-sizing: border-box;

        &:hover {
          cursor: pointer;
        }

        img {
          height: 150px;
          width: 150px;
          border-radius: 50%;
          box-sizing: border-box;
        }

        .editImageButton {
          position: absolute;
          width: 20px;
          height: 20px;
          right: 5px;
          bottom: 5px;
          background: #3e9537;
          padding: 10px;
          border-radius: 50%;
          box-shadow: 0px 0px 10px black;
        }
      }

      .profileDetails {
        width: 300px;
        float: left;
        margin-left: 20px;
        margin-top: 40px;

        h1 {
          margin: 0px;

          svg {
            height: 25px;
            margin-left: 5px;
            color: #ddba30;
          }
        }

        h2 {
          margin: 0px;
          font-weight: 300;
          font-size: 20px;
        }
      }

      margin-top: 30px;
    }

    .editForm {
      display: flex;
      width: 100%;
      flex-wrap: wrap;
      justify-content: space-between;

      .buttons {
        margin-top: 50px;
        width: 100%;

        display: flex;
        justify-content: center;

        button {
          padding: 15px;

          svg {
            height: 30px;
          }
        }
      }

      .discordField {
        span {
          margin-bottom: 10px;
        }

        > div {
          width: 100%;
          border: var(--border) 2px solid;
          border-radius: 5px;
          background: var(--background-secondary);
        }

        img {
          border-radius: 50%;
          height: 100px;
          width: 100px;
          margin: 0 auto;
          display: block;
          margin-top: 20px;
        }

        h4 {
          text-align: center;
          font-size: 20px;
          margin-top: 5px;
          margin-bottom: 5px;
        }

        p {
          text-align: center;
          margin: 5px;
          color: #fff3;
        }

        button {
          margin-top: 10px;
          width: 100%;
          background: linear-gradient(90deg, var(--red-gradient-1-primary) 0%, var(--red-gradient-1-secondary) 100%);

          &:disabled {
            background: linear-gradient(90deg, #4f4f4f 0%, #9D9D9D 100%);
          }
        }

        .unlinkWarn {
          color: #d04040;
          margin-top: 10px;
          font-size: 15px;
        }
      }

      .field {
        width: 45%;

        .discordButton {
          margin-top: 10px;
          width: 100%;
          height: 50px;
          background: #7289da;

          svg {
            height: 30px;
            display: inline;
            vertical-align: middle;
          }

          span {
            vertical-align: middle;
          }
        }

        > span {
          display: block;
          margin-top: 30px;
          color: rgba(255, 255, 255, 0.75);
        }

        input {
          margin-top: 10px;
          width: 100%;
        }
      }
    }
  }
</style>
