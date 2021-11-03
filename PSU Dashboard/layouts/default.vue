<template>
  <div>
    <script src="https://kit.fontawesome.com/58f640bc7f.js" crossorigin="anonymous"></script>
    <script src="https://www.paypal.com/sdk/js?client-id=AUOKVmvIr3zDrclzkyi-PhVgzuUiFpN0PnfOehVv7wwlwm_M_QsOIHuvcbqIdNWfBaZEKpcxdvbJiLrx"></script>
    <script src="https://js.stripe.com/v3/"></script>
    <div v-if="signedIn">
      <div class="test">

      </div>
      <Header />
      <SideMenu />
      <NotificationManager />
      <div class="currentPage">
        <perfect-scrollbar>
          <Nuxt />
        </perfect-scrollbar>
      </div>
    </div>
    <Auth v-if="!signedIn" />
  </div>
</template>

<script>
import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
import 'vue-select/dist/vue-select.css'
import 'normalize.css'

export default {
  components: {
    PerfectScrollbar
  },
  computed: {
    signedIn() {
      return this.$store.state.userData.signedIn
    },
  },
  mounted() {
    if (!window.getCurrentPos) {
      let cursorX = -1
      let cursorY = -1

      document.onmousemove = function (event) {
        cursorX = event.pageX
        cursorY = event.pageY
      }

      window.getCurrentPos = function () {
        return { cursorX, cursorY }
      }
    }
  }
}
</script>

<style lang="scss">
  .currentPage {
    position: absolute;
    right: 0px;
    top: 101px;
    width: calc(100vw - 251px);
    height: calc(100vh - 101px);
  }

  .currentPage .ps {
    height: 100%;
    box-sizing: border-box;

    > div:first-child {
      padding: 20px;
      box-sizing: border-box
    }
  }

  @import "vue-select/src/scss/vue-select.scss";
</style>
