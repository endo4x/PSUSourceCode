<template>
  <div class="notifCore">
    <div v-for="notif in currentNotifications" :key="notif.ID" v-bind:class="`notification ${notif.type}`" v-on:click="() => removeNotification(notif.ID)">
      <div class="timer"/>
      <div class="icon">
        <font-awesome-icon icon="info-circle" v-if="notif.type == 'INFO'"/>
        <font-awesome-icon icon="exclamation-circle" v-if="notif.type == 'WARN'"/>
        <font-awesome-icon icon="times-circle" v-if="notif.type == 'ERROR'"/>
      </div>
      <h1 v-bind:style="`font-size: ${notif.fontsize}px`">{{notif.message}}</h1>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentNotifications: []
    }
  },
  methods: {
    async createNotification(type, message, fontsize) {
      const ID = Math.random().toString(36).substr(2, 9)
      this.currentNotifications.push({ID: ID, type: type, message: message, fontsize: fontsize})
      await new Promise(resolve => setTimeout(resolve, 10000))
      this.removeNotification(ID);
    },

    removeNotification(ID) {
      this.currentNotifications = this.currentNotifications.filter(notif => notif.ID !== ID)
    }
  },
  mounted() {
    // Bind to global
    window.createNotification = this.createNotification
  }
}
</script>

<style lang="scss">
  .notifCore {
    position: fixed;
    right: 10px;
    top: 10px;
    z-index: 100;

    --colour-notif-info-primary: #328246;
    --colour-notif-warn-primary: #8a831f;
    --colour-notif-error-primary: #8a1f1f;

    .INFO {
      background: var(--theme-gradient-1-primary);
    }

    .ERROR {
      background: #8a1f1f;
    }

    .WARN {
      background: var(--colour-notif-warn-primary);
    }

    > div {
      position: relative;
      margin-top: 10px;
      width: 400px;
      height: 50px;
      background: white;
      border-radius: 10px;
      overflow: hidden;
      animation: notifAni 10s ease-in-out forwards;

      &:hover {
        cursor: pointer;
      }

      .icon {
        width: 50px;
        height: 50px;
        background: #00000063;
        float: left;
        margin-right: 10px;
        position: relative;

        svg {
          height: 35px;
          position: absolute;
          left: 50%;
          top: 50%;
          transform: translateY(-50%) translateX(-50%);
        }
      }

      h1 {
        font-size: 20px;
        position: absolute;
        left: 60px;
        top: 50%;
        transform: translateY(-50%);
        font-weight: 600;
        margin: 0px;
      }

      .timer {
        position: absolute;
        left: 0px;
        width: 0px;
        height: 100%;
        animation: notifTimer 8s ease-in-out forwards 1s;
        background: #00000063;
        z-index: -1;
      }
    }
  }

  @keyframes notifTimer {
    0% {
      width: 0px;
    }

    100% {
      width: 100%;
    }
  };

  @keyframes notifAni {
    0% {
      transform: translateX(420px);
    }

    10% {
      transform: translateX(0px);
    }

    90% {
      transform: translateX(0px);
    }

    100% {
      transform: translateX(420px);
    }
  }
</style>
