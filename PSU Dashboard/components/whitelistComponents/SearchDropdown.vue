<template>
  <div class="searchDropdown">
    {{dropdownName}}
    <svg class="dropdownArrow" xmlns="http://www.w3.org/2000/svg" width="12.098" height="6.734" viewBox="0 0 12.098 6.734">
      <path id="Path_439" data-name="Path 439" d="M11.038,15.731a.81.81,0,0,1-.552-.221L5.31,10.7A1.04,1.04,0,0,1,5.2,9.346a.8.8,0,0,1,1.216-.125l4.624,4.308,4.624-4.154a.8.8,0,0,1,.635-.21.843.843,0,0,1,.581.354,1.034,1.034,0,0,1,.215.731.994.994,0,0,1-.335.673l-5.176,4.644a.8.8,0,0,1-.543.163Z" transform="translate(-4.999 -8.999)" fill="currentColor" />
    </svg>
  </div>
</template>

<script>
export default {
  props: ['dropdownName']
}
</script>

<style lang="scss">
    .searchDropdown {
      position: relative;
      background: var(--background-secondary);
      border: none;
      height: 40px;
      width: 170px;
      border-radius: 10px;

      font-size: 13px;
      color: var(--text-color-primary);
      padding-left: 10px;
      box-sizing: border-box;
      font-family: "Poppins", sans-serif;
      transition: 0.3s ease-in-out;
      outline: none;
      border: 2px solid transparent;
      float: left;
      margin-left: 10px;
      line-height: 37px;
      color: #626262;

      .dropdownArrow {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #626262;
      }
    }

    .searchDropdown:hover {
      cursor: pointer;
      color: #cacaca;
    }
</style>
