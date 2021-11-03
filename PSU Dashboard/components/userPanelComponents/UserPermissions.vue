<template>
  <div class="userPermissions">
    <div class="header">
      <h2>User Permissions:</h2>
      <div class="spacer" />
      <form v-on:submit.prevent="addPermission">
      <input
        type="text"
        placeholder="Add Permission"
        required
        v-model="addPermID"
        v-if="
          userPerms.includes('permission.user_perms.set') ||
          userPerms.includes('system.admin')"/>
          <button v-if="
          userPerms.includes('permission.user_perms.set') ||
          userPerms.includes('system.admin')">
        Add
      </button>
      </form>
    </div>
    <p
      class="error"
      v-if="
        !(
          userPerms.includes('permission.user_perms.get') ||
          userPerms.includes('system.admin')
        )
      "
    >
      You do not have the permission "permission.user_perms.get"
    </p>
    <div class="loader" v-if="loading" />
    <p v-if="!loading && currentPerms.length == 0">
      This user has no special permissions
    </p>
    <div class="currentPerms">
      <div v-for="perm in currentPerms" :key="perm" v-on:click="() => deletePermision(perm)">
        <h3>{{ perm }}</h3>
        <font-awesome-icon icon="trash" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["currentUser"],
  data() {
    return {
      currentPerms: [],
      loading: true,
      processingAdd: false,
      addPermID: ''
    };
  },
  watch: {
    currentUser() {
      this.currentPerms = [];
      this.loading = true;
      this.refreshUser();
    },
  },
  methods: {
    processResponse(data) {
      if (data.success) {
        this.currentPerms = data.data;
      } else {
        this.error = data.message;
      }

      this.loading = false;
    },
    refreshUser() {
      if (
        !(
          this.userPerms.includes("permission.user_perms.get") ||
          this.userPerms.includes("system.admin")
        )
      ) {
        return;
      }

      fetch("https://next.psu.dev/api/v2/auth/perms/get_user_perms", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          token: this.authToken,
          target: this.currentUser.id,
        }),
      })
        .then((data) => data.json())
        .then((data) => this.processResponse(data));
    },
    async deletePermision(permID) {
      await fetch('https://next.psu.dev/api/v2/auth/perms/remove_perm' , {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken,
          permission_id: permID,
          target: this.currentUser.id
        })
      })
      .then(data => this.refreshUser())
    },
    async addPermission() {
      await fetch('https://next.psu.dev/api/v2/auth/perms/add_perm' , {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken,
          permission_id: this.addPermID,
          target: this.currentUser.id
        })
      })
      .then(data => {
        this.refreshUser()
        this.addPermID = ''
      })
    }
  },
  computed: {
    userPerms() {
      return this.$store.state.userData.perms;
    },
    authToken() {
      return this.$store.state.userData.authToken;
    },
  },
  mounted() {
    this.refreshUser();
  },
};
</script>

<style lang="scss">
.userPermissions {
  text-align: center;

  .header {

    form {
      display: flex;
    }

    h2 {
      float: left;
    }

    .spacer {
      flex-grow: 10;
    }

    button {
      display: block;
      float: right;
      height: 50px;
      padding-left: 20px;
      padding-right: 20px;
      font-size: 13px;
      margin-left: 10px;
    }
  }

  .currentPerms {
    display: flex;

    > div {
      padding: 8px;
      background: var(--background-secondary);
      margin: 3px;
      border-radius: 5px;
      border: 2px solid var(--border);
      position: relative;
      user-select: none;

      &:hover {
        background: var(--red-gradient-1-primary);
        cursor: pointer;

        > h3 {
          opacity: 0;
        }

        > svg {
          display: block;
        }
      }

      > h3 {
        margin: 0px;
      }

      > svg {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translateX(-50%) translateY(-50%);
        display: none;
        width: 15px;
      }
    }
  }
}
</style>
