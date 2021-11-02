module.exports = {
  lintOnSave: false,
  css: {
    loaderOptions: {
      sass: {
        additionalData: `@import "~@/scss/_variables.scss";`,
      },
    },
  },
};
