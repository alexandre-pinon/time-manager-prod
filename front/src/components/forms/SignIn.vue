<template>
  <div class="sign-in flex f-column">
    <h3 class="sign-in-title">Connexion</h3>
    <div class="sign-in-element flex js-between">
      <label for="signin-email-input">Email</label>
      <input
        v-model="email"
        id="signin-email-input"
        type="email"
        class="sign-in-field"
      />
    </div>
    <div class="sign-in-element flex js-between">
      <label for="signin-password-input">Mot de passe</label>
      <input
        v-model="password"
        id="signin-password-input"
        type="password"
        class="sign-in-field"
      />
    </div>
    <Button @click="() => submit()" class="sign-in-button">Se connecter</Button>
  </div>
</template>

<script lang="ts">
import mixins from "vue-typed-mixins";

import { API } from "@/mixins";
import { Button } from "@/components/global";

export default mixins(API).extend({
  name: "tm-signin",
  components: {
    Button,
  },
  data() {
    return {
      email: "",
      password: "",
    };
  },
  methods: {
    submit: async function () {
      const { email, password } = this;
      const { token } = (await this.signIn(email, password)) || {};
      if (!token) return;
      localStorage.setItem("token", token);
      this.$store.dispatch("updateAuthStatus");
      this.$router.push("/home/TODO");
      this.$emit("sign-in");
    },
  },
});
</script>

<style lang="scss">
div.application {
  .sign-in {
    &-element {
      margin-top: 8px;
    }
    &-field {
      margin-left: 16px;
      height: 32px;
    }
    &-button {
      margin-top: 16px;
    }
  }
}
</style>
