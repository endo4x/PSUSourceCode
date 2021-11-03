<template>
  <div class="sideMenu">
    <SideProfile />

    <div class="sideNav">
      <perfect-scrollbar>
        <NuxtLink to="/">
          <DashLogo />
          <span>Dashboard</span>
        </NuxtLink>

        <NuxtLink to="/scripts/personal" v-if="hasPremium">
          <ScriptsLogo />
          <span>My Scripts</span>
        </NuxtLink>

        <NuxtLink to="/scripts/public">
          <PublicLogo />
          <span>Public Scripts</span>
        </NuxtLink>

        <NuxtLink to="/api" v-if="hasPremium">
          <APILogo />
          <span>API</span>
        </NuxtLink>

        <NuxtLink to="/purchasePremium" v-if="!hasPremium">
          <PurchasesLogo />
          <span>Purchase Premium</span>
        </NuxtLink>

        <div class="adminNav" v-if="userPerms">
          <span />
          <NuxtLink to="/admin/whitelists" v-if="userPerms.includes('user.whitelist.read') || userPerms.includes('system.admin')">
            <WhitelistLogo />
            <span>Whitelist Dashboard</span>
          </NuxtLink>

          <NuxtLink to="/admin/users" v-if="userPerms.includes('user.users.read') || userPerms.includes('system.admin')">
            <UserLogo />
            <span>Users & Permissions</span>
          </NuxtLink>

          <NuxtLink to="/admin/roles" v-if="userPerms.includes('user.perms.read') || userPerms.includes('system.admin')">
            <PermLogo />
            <span>Roles</span>
          </NuxtLink>

          <NuxtLink to="/admin/purchases" v-if="userPerms.includes('user.purchases.read') || userPerms.includes('system.admin')">
            <PurchasesLogo />
            <span>Purchases</span>
          </NuxtLink>

          <NuxtLink to="/announcements">
            <AnnounceLogo />
            <span>Announcements</span>
          </NuxtLink>

          <NuxtLink to="/settings">
            <SettingsLogo />
            <span>Settings</span>
          </NuxtLink>
        </div>
      </perfect-scrollbar>
    </div>
  </div>
</template>

<script>
import DashLogo from '@/assets/icons/pageIcons/Dashboard.svg';
import ObfuscateLogo from '@/assets/icons/pageIcons/Obfuscate.svg';
import APILogo from '@/assets/icons/pageIcons/API.svg';
import ScriptsLogo from '@/assets/icons/pageIcons/MyScripts.svg';
import PublicLogo from '@/assets/icons/pageIcons/PubScripts.svg';

import PurchasesLogo from '@/assets/icons/pageIcons/Purchases.svg';
import AnnounceLogo from '@/assets/icons/pageIcons/Announcements.svg';
import PermLogo from '@/assets/icons/pageIcons/RolesPerms.svg';
import SettingsLogo from '@/assets/icons/pageIcons/Settings.svg';
import UserLogo from '@/assets/icons/pageIcons/Users.svg';
import WhitelistLogo from '@/assets/icons/pageIcons/WhitelistDash.svg';

import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
import 'vue2-perfect-scrollbar/dist/vue2-perfect-scrollbar.css'

export default {
  components: {
    DashLogo,
    ObfuscateLogo,
    APILogo,
    ScriptsLogo,
    PublicLogo,
    PerfectScrollbar,
    PurchasesLogo,
    AnnounceLogo,
    PermLogo,
    SettingsLogo,
    UserLogo,
    WhitelistLogo
  },
  computed:{
    userPerms() {
      return this.$store.state.userData.perms
    },
    hasPremium() {
      return this.$store.state.userData.currentUser.has_premium
    }
  }
}
</script>

<style lang="scss">
  .sideMenu {
    position: absolute;
    left: 0px;
    top: 101px;
    width: 250px;
    height: calc(100vh - 101px);

    border-right: var(--border) 1px solid;
    box-shadow: 0 0 1px 0 var(--border) inset, 0 0 1px 0 var(--border); /* Border anti-aliasing */

    .ps {
      height: calc(100vh - 101px - 240px);
    }

    .ps .ps__rail-x:hover, .ps .ps__rail-y:hover, .ps .ps__rail-x:focus, .ps .ps__rail-y:focus, .ps .ps__rail-x.ps--clicking, .ps .ps__rail-y.ps--clicking {
    	background-color: transparent !important;
    	opacity: 0.9;
    }
  }

  .sideNav {
    a {
      display: flex;
      align-items: center;

      width: 220px;
      height: 50px;

      margin: 0 auto;
      margin-bottom: 5px;

      text-decoration: none;
      color: var(--text-color-primary);
      font-size: 16px;
      font-weight: 400;
      line-height: 50px;

      padding-left: 10px;
      box-sizing: border-box;
      border-radius: 10px;

      outline: none;
      box-shadow: none;

      svg {
        margin-right: 10px;
      }
    }

    a:hover {
      background-color: #1D1C1C;
      transition: 0.1s ease-in-out;
      cursor: pointer;
    }

    .adminNav > span {
      display: block;
      width: 200px;
      margin: 0 auto;
      border-top: var(--border) 1px solid;
      margin-bottom: 10px;


    }

    .nuxt-link-exact-active {
      background-color: #1D1C1C;
    }
  }
</style>
