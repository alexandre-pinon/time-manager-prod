<template>
  <div class="sign-up flex f-column">
    <h3 class="sign-up-title">Inscription</h3>
    <div class="sign-up-element flex js-between">
      <label for="email-input">Email</label>
      <input
        v-model="email"
        id="email-input"
        type="email"
        class="sign-up-field"
      />
    </div>
    <div class="sign-up-element flex js-between">
      <label for="firstname-input">Prénom</label>
      <input
        v-model="firstName"
        id="firstname-input"
        type="text"
        class="sign-up-field"
      />
    </div>
    <div class="sign-up-element flex js-between">
      <label for="lastname-input">Nom</label>
      <input
        v-model="lastName"
        id="lastname-input"
        type="text"
        class="sign-up-field"
      />
    </div>
    <div class="sign-up-element flex js-between">
      <label for="password-input">Mot de passe</label>
      <input
        v-model="password"
        id="password-input"
        type="password"
        class="sign-up-field"
      />
    </div>
    <div class="sign-up-element flex js-between">
      <label for="password-confirm-input">Confirmation mot de passe</label>
      <input
        v-model="passwordConfirm"
        id="password-confirm-input"
        type="password"
        class="sign-up-field"
      />
    </div>
    <Button @click="() => submit()" class="sign-up-button">S'inscrire</Button>
  </div>
</template>

<script lang="ts">
import mixins from "vue-typed-mixins";

import { API } from "@/mixins";
import { Button } from "@/components/global";

export default mixins(API).extend({
  name: "tm-signup",
  components: {
    Button,
  },
  data() {
    return {
      email: "",
      firstName: "",
      lastName: "",
      password: "",
      passwordConfirm: "",
    };
  },
  methods: {
    submit: async function () {
      const { email, firstName, lastName, password, passwordConfirm } = this;
      const { token, id } =
        (await this.signUp(
          email,
          firstName,
          lastName,
          password,
          passwordConfirm
        )) || {};
      if (!token || !id) return;
      await this.$store.dispatch("updateAuthStatus", { token, id });
      this.$router.push(`/home/${id}`);
      this.$emit("sign-up");
    },
  },
});
</script>

<style lang="scss">
div.application {
  .sign-up {
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
