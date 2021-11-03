export const state = () => ({
  currentPage: 'Dashboard'
})

export const mutations = {
  CHANGE_PAGE (state, pageName) {
    state.currentPage = pageName
  }
}
