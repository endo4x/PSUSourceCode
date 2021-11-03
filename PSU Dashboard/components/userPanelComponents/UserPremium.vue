<template>
  <div class="premiumInfo">
    <h2>Premium Information:</h2>
  <p
  class="error"
  v-if="
    !(
      userPerms.includes('user.premium.get') ||
      userPerms.includes('system.admin')
    )">You do not have the permission "user.premium.get"</p>
    <div v-if="
    (
      userPerms.includes('user.premium.get') ||
      userPerms.includes('system.admin')
    )">
      <p v-if="currentPremium">User has premium, Runs out at {{currentPremium}}</p>
      <p v-if="currentPremium === null">Loading Premium Information...</p>
      <p style="color: #E32B2B; font-weight: 600" v-if="premiumError">ERROR: {{premiumError}}</p>
      <p v-if="currentPremium === false">User does not have premium</p>
      <p style="color: #E32B2B; font-weight: 600">Overwrite Premium Status. WARNING: This will overwrite current premium status!</p>
      <div class="buttons" v-if="
    (
      userPerms.includes('user.premium.set') ||
      userPerms.includes('system.admin')
    )">
        <button :disabled="processingPrem" v-on:click="() => addPremium(0)">One Month</button>
        <button :disabled="processingPrem" v-on:click="() => addPremium(1)">One Year</button>
        <button :disabled="processingPrem" v-on:click="() => addPremium(2)">Lifetime</button>
        <button :disabled="processingPrem" v-on:click="removePremium" style="background: linear-gradient(90deg, var(--red-gradient-1-primary) 0%, var(--red-gradient-1-secondary) 100%)">Remove Premium</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["currentUser"],
  data() {
    return {
      processingPrem: false,
      currentPremium: null,
      premiumError: false
    }
  },
  watch: {
    currentUser() {
      this.premiumError = false;
      this.currentPremium = null;
      this.processingPrem = false;
      this.refreshData();
    },
  },
  async mounted() {
    if (!(
      this.userPerms.includes('user.premium.get') ||
      this.userPerms.includes('system.admin')
    )) {return};

    this.refreshData()
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
    async refreshData() {
      if (!(
        this.userPerms.includes('user.premium.get') ||
        this.userPerms.includes('system.admin')
      )) {return};

      let response = await fetch('https://next.psu.dev/api/v2/auth/premium/get_premium', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken,
          target: this.currentUser.id
        })
      }).then(data => data.json())

      if (response.success == true) {
        this.currentPremium = response.data
      } else {
        this.premiumError = response.message
      }
    },
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

      this.refreshData()

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

      await new Promise(resolve => setTimeout(resolve, 600));

      this.refreshData()

      this.processingPrem = false
    }
  }
}
</script>

<style>

</style>
