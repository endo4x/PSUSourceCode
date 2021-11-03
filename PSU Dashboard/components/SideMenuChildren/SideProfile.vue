<template>
  <div class="SideMenuProfile">
    <div class="SideMenuProfileImage">
      <img :src="currentUser.avatar">
    </div>

    <span>{{currentUser.email}}</span>
  </div>
</template>

<script>
export default {
  computed:{
    currentUser() {
      return this.$store.state.userData.currentUser
    }
  }
}
</script>

<style lang="scss">
  .SideMenuProfile {
    width: 100%;
    height: 175px;

    .SideMenuProfileImage {
      position: relative;

      margin: 0 auto;
      margin-top: 30px;
      width: 90px;
      height: 90px;

      border: #FFFFFF 2px solid;
      border-radius: 50%;

      img {
        position: absolute;
        left: 50%;
        top: 50%;

        transform: translateX(-50%) translateY(-50%);

        margin: 0 auto;
        width: 80px;
        height: 80px;
        border-radius: 50%;
      }
    }

    span {
      display: block;
      margin-top: 20px;
      text-align: center;
      width: 90%;
      margin: 20px auto;

      font-size: 16px;
      font-weight: 600;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  }
</style>
