<template>
  <div class="settingsAbout">
    <h1>About</h1>
    <h2>PSU Dashboard</h2>
    <h3>Version: PRODUCTION</h3>
    <h3>Commit: {{commitHash}}</h3>
    <h3>Compiled At: {{compiledAt}}</h3>
  </div>
</template>

<script>
export default {
  data() {
    return {
      commitHash: __COMMIT_HASH__,
      compiledAt: __COMPILED_AT_,
      compiledWith: __COMPILED_WITH__
    }
  },
}
</script>

<style lang="scss">
  .settingsAbout {
    h2, h3 {
      font-weight: 300;
    }

    h3 {
      margin: 0px;
    }
  }
</style>
