<template>
  <div class="userSidePanelEntry" v-on:click="selectUser">
    <div class="avatar" v-on:click="selectUser">
      <img :src="user.avatar" >
    </div>
    <div class="username">
      <h4>{{user.username}}</h4>
    </div>
  </div>
</template>

<script>
export default {
  props: ['user'],
  methods: {
    selectUser() {
      this.$emit('select-user', this.user)
    }
  }
}
</script>

<style lang="scss">
  .userSidePanelEntry {
    width: 90%;
    background: var(--background-secondary);
    height: 60px;
    margin: 0 auto;
    margin-top: 10px;
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 0px !important;
    display: flex;
    position: relative;

    &:hover {
      cursor: pointer;
    }

    .username {
      position: relative;
      height: 100%;
      width: 60px;

      h4 {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        margin: 0px;
      }
    }

    .avatar {
      position: relative;

      height: 100%;
      width: 60px;
      margin-left: 5px;
      margin-right: 5px;

      img {
        position: absolute;
        border-radius: 50%;
        height: 80%;
        left: 50%;
        top: 50%;
        transform: translateX(-50%) translateY(-50%);
      }
    }
  }
</style>
