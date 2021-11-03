<template>
  <div class="DashHead">
    <div class="DashHeadImage">
      <NuxtLink to="/"><img src="@/assets/images/psu.png"></NuxtLink>
    </div>

    <div class="DashHeadSectionName">
      {{currentPage}}
    </div>

    <div class="DashHeadAccount" v-click-outside="closeDropdown">
      <Dropdown ref="dropdownComponent">
        <span v-on:click="openProfile">Profile</span>
        <span v-on:click="signOut">Logout</span>
        <span v-on:click="closeDropdown">Cancel</span>
      </Dropdown>

      <div v-click-outside="closeNotifDropdown" v-on:click.self="openNotifDropdown" v-bind:class="unreadNotifications ? 'DashHeadAlerts AlertActive' : 'DashHeadAlerts'"> <NotifLogo v-on:click="openNotifDropdown" /> <NotificationDropdown v-if="notificationsOpen" /> </div>

      <div class="DashHeadDropdown" v-on:click="triggerDropdown"> <DropdownLogo /> </div>

      <span class="DashHeadUsername" v-on:click.self="triggerDropdown">
        {{currentUser.username}}
        <font-awesome-icon icon="crown" v-tippy content="Premium User" v-if="currentUser.has_premium"/>
      </span>

      <div class="DashHeadAvatar" v-on:click="triggerDropdown">
        <img :src="currentUser.avatar">
      </div>
    </div>
  </div>
</template>

<script>
import NotifLogo from '@/assets/icons/headerIcons/Notification.svg'
import DropdownLogo from '@/assets/icons/headerIcons/Dropdown.svg'

export default {
  components: {
    NotifLogo,
    DropdownLogo
  },
  data() {
    return {
      notificationsOpen: false
    }
  },
  methods: {
    openProfile: function () {
      this.$router.push('/profile')
      this.$refs.dropdownComponent.closeDropdown()
    },
    triggerDropdown: function () {
      this.$refs.dropdownComponent.openDropdown()
    },
    closeDropdown: function () {
      this.$refs.dropdownComponent.closeDropdown()
    },
    signOut: function () {
      document.cookie = "PSUToken=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
      this.$store.commit('userData/SIGNOUT')
      this.$refs.dropdownComponent.closeDropdown()
    },
    closeNotifDropdown: function () {
      this.notificationsOpen = false
    },
    openNotifDropdown: function () {
      this.notificationsOpen = true
    }
  },
  computed: {
    currentPage() {
      return this.$store.state.routerManager.currentPage
    },
    unreadNotifications() {
      return this.$store.state.userData.notificationsUnread
    },
    currentUser() {
      return this.$store.state.userData.currentUser
    }
  }
}
</script>

<style lang="scss">
  .DashHead {
    width: 100%;
    height: 100px;
    border-bottom: var(--border) 1px solid;
    box-shadow: 0 0 1px 0 var(--border) inset, 0 0 1px 0 var(--border); /* Border anti-aliasing */
    position: relative;
    color: #ffffff;
    display: flex;
    align-items: center;
  }

  .DashHeadImage {
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);

    img {
      width: 220px;
    }
  }

  .DashHeadSectionName {
    position: absolute;
    left: 250px;
    top: 50%;
    transform: translateY(-50%);

    height: 45px;
    border-left: var(--border) 1px solid;

    line-height: 45px;
    padding-left: 15px;
    font-weight: 600;
    font-size: 20px;
  }

  .DashHeadAccount {
    position: absolute;
    right: 20px;

    display: flex;
    align-items: center;
    flex-direction: row-reverse;
    z-index: 10;

    .DashHeadAlerts {
      width: 25px;
      height: 25px;
      margin-left: 10px;
      transform: translateY(3px);
      transition: 0.1s ease-in-out;
      position: relative;
    }

    .AlertActive:before {
      position: absolute;
      content: ' ';
      display: block;
      width: 10px;
      height: 10px;
      background: #FF0639;
      font-size: 10px;

      bottom: -5px;
      right: -5px;
      border: 3px var(--background) solid;
      border-radius: 50%;
    }

    .DashHeadDropdown {
      width: 25px;
      height: 25px;
      margin-left: 10px;
      transform: translateY(3px);
      transition: 0.1s ease-in-out;
    }

    .DashHeadUsername {
      font-size: 20px;
      margin-left: 15px;

      svg {
        height: 20px;
        margin-left: 5px;
        color: #ddba30;
      }
    }

    .DashHeadAvatar {
      width: 40px;
      height: 40px;

      img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
      }
    }
  }

  .DashHeadAccount > div:hover, .DashHeadAccount > span:hover {
    cursor: pointer;
    color: white;
  }
</style>
