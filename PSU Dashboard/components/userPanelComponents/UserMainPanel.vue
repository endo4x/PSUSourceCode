<template>
  <div class="UserMainPanel">
    <div class="NoUserNotice" v-if="!currentUser">
      <h1>Welcome to the user dashboard</h1>
      <h4>Please select a user to get started.</h4>
    </div>
    <div class="userSelected" v-if="currentUser">
      <div class="header">
        <div class="avatar">
          <img :src="currentUser.avatar" />
        </div>
        <div class="text">
          <h1>{{currentUser.username}}</h1>
          <h2>{{currentUser.email}}</h2>
        </div>
      </div>
      <span class="seperator" />
      <div class="permissionInfo">
        <UserPermissions :currentUser="currentUser" />
      </div>
      <UserPremium :currentUser="currentUser" />
    </div>
  </div>
</template>

<script>
export default {
  props: ["currentUser"],
  data() {
    return {
      processingPrem: false
    }
  },
  computed: {
    userPerms() {
      return this.$store.state.userData.perms;
    },
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  methods: {
    async removePremium() {
      this.processingPrem = true

      await fetch('https://next.psu.dev/api/v2/auth/premium/remove_premium', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken,
          target: this.currentUser.id
        })
      })

      // refresh user data here

      this.$emit('refresh-data')

      this.processingPrem = false
    },
    async addPremium(orderType) {
      this.processingPrem = true

      await fetch('https://next.psu.dev/api/v2/auth/premium/add_premium', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          orderType: orderType,
          token: this.authToken,
          target: this.currentUser.id
        })
      })

      // refresh user data here

      this.$emit('refresh-data')

      this.processingPrem = false
    }
  }
}
</script>

<style lang="scss">
  .UserMainPanel {
    flex-grow: 10;
    flex: 1 1 auto;
    overflow: hidden;
    height: 100%;
    position: relative;
    padding-right: 40px;
    padding-left: 40px;

    .seperator {
      margin-top: 15px;
      display: block;
      border-bottom: 1px solid var(--border);
      width: 100%;
    }

    .premiumInfo {
      margin-top: 30px;
      border-top: 1px solid var(--border);
    }

    .userSelected {
      max-width: 1000px;
      margin: 0 auto;
      min-height: 100%;
      padding-top: 50px;

      .header {
        display: flex;
        align-items: center;
        .avatar {
          position: relative;
          width: 125px;
          height: 125px;
          border: #FFFFFF 2px solid;
          border-radius: 50%;

          img {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translateX(-50%) translateY(-50%);
            margin: 0 auto;
            width: 115px;
            height: 115px;
            border-radius: 50%;
          }

        }

        .text {
          margin-top: 20px;
          margin-left: 10px;
          h1, h2 {
            margin: 0px;
          }

          h2 {
            font-weight: 100;
          }
        }
      }
    }

    .NoUserNotice {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);

      h4, h1 {
        text-align: center;
        margin: 0px;
        font-weight: 100;
      }
    }
  }
</style>
