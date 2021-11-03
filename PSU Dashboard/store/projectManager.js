export const state = () => ({
  currentProjects: [],
  currentPubProjects: []
})

export const mutations = {
  SET_PROJECTS (state, projects) {
    state.currentProjects = projects
  },
  SET_PUB_PROJECTS (state, projects) {
    state.currentPubProjects = projects
  }
}
