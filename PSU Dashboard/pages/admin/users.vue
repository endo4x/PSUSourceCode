<template>
  <div class="userPanel">
    <SidePanel v-on:select-user="handleUserSelection" />
    <UserMainPanel :currentUser="currentSelected" />
  </div>
</template>

<script>

import SidePanel from '~/components/userPanelComponents/SidePanel'

export default {
  data() {
    return {
      currentSelected: false
    }
  },
  methods: {
    handleUserSelection(user) {
      this.currentSelected = user
    }
  },
  components: {
    SidePanel
  }
}
</script>

<style lang="scss">
  .userPanel {
    width: 100%;
    height: 100%;
    padding: 0px !important;
    display: flex;
    overflow: hidden;
  }

</style>
