<template>
  <div class="HomePage commonPage">
    <h1>Dashboard Overview</h1>

    <div class="overviewCards">
      <Card title="Profile Settings" v-bind:icon="ProfileIcon" v-on:click="openProfile" v-on:view="openProfile" />
      <Card title="Obfuscations" v-bind:icon="ObfusIcon" />
      <Card title="Activity Log" v-bind:icon="ActivityIcon" />
    </div>

    <div class="overviewChart">
      <h1>Daily Activity</h1>
      <Chart v-bind:options="options" />
    </div>
  </div>
</template>

<style lang="scss">
  .HomePage {
    font-family: 'Poppins', sans-serif;

    > h1 {
      font-size: 25px;
    }

    .overviewCards {
      margin-top: 20px;
      width: 100%;
      display: flex;
      justify-content: space-around;
      box-sizing: border-box;
    }

    .overviewChart {
      height: calc(100% - 300px);
      margin-top: 30px;
      min-height: 400px;
      border: 2px #2C2C2C solid;
      border-radius: 15px;
      background: linear-gradient(141deg, var(--theme-black-gradient-primary) 32%, var(--theme-black-gradient-secondary) 100%);
      padding: 20px;
      box-sizing: border-box;

      > div {
        height: calc(100% - 50px);
      }

      > h1 {
        font-size: 20px;
        margin-bottom: 30px;
      }
    }
  }
</style>

<script>
import ProfileIcon from '@/assets/icons/HomeIcons/ProfileSettings.svg'
import ObfusIcon from '@/assets/icons/HomeIcons/Folder.svg'
import ActivityIcon from '@/assets/icons/HomeIcons/UpArrow.svg'

import Card from '@/components/CommonComponents/Card'
import Chart from '@/components/CommonComponents/Chart'

export default {
  mounted() {
    this.$store.commit('routerManager/CHANGE_PAGE', 'Dashboard')
  },
  methods: {
    openProfile() {
      this.$router.push('/profile')
    }
  },
  data: () => {
    return {
      ProfileIcon,
      ObfusIcon,
      ActivityIcon,

      options: {
        tooltips: {
          callbacks: {
            title: function(tooltipItems, data) {
              return '';
            },
            label: function(tooltipItem, data) {
              return ` ${data.datasets[0].data[tooltipItem.index]} Logins`;
            }
          }
        },
        legend: {
          display: false
        },
        scales: {
          xAxes: [
            {
              ticks: {
                display: false
              }
            }
          ],
          yAxes: [
            {
              ticks: {
                beginAtZero:true,
              }
            }
          ]
        },
        responsive: true,
        maintainAspectRatio: false
      }
    }
  },
  components: {
    Card,
    Chart
  }
}
</script>
