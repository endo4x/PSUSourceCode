<template>
  <div class="card">
    <div class="cardDropdown" v-on:click.self="triggerDropdown" v-click-outside="closeDropdown">
      <Ellipsis v-on:click.self="triggerDropdown" />
      <Dropdown ref="dropdownComponent">
        <span v-on:click="triggerView">View</span>
        <span v-on:click="closeDropdown">Cancel</span>
      </Dropdown>
    </div>
    <div class="cardIcon"><component :is="icon"></component></div>
    <h1>{{title}}</h1>
  </div>
</template>

<script>
import Ellipsis from '@/assets/icons/HomeIcons/Ellipsis.svg'
export default {
  props: ['title', 'icon'],
  components: {
    Ellipsis,
    'cardIcon': () => icon
  },
  methods: {
    triggerView() {
      this.$emit('view')
      this.$refs.dropdownComponent.closeDropdown()
    },
    triggerDropdown: function () {
      this.$refs.dropdownComponent.openDropdown()
    },
    closeDropdown: function () {
      this.$refs.dropdownComponent.closeDropdown()
    }
  }
}
</script>

<style lang="scss">
  .card {
    position: relative;
    width: 375px;
    height: 180px;
  }
</style>
