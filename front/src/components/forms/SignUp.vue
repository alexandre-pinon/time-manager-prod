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
    <div v-if="editId" class="sign-up-element flex js-between">
      <label for="role-input">Rôle</label>
      <input v-model="role" id="role-input" type="text" class="sign-up-field" />
    </div>
    <div v-if="!editId" class="sign-up-element flex js-between">
      <label for="password-input">Mot de passe</label>
      <input
        v-model="password"
        id="password-input"
        type="password"
        class="sign-up-field"
      />
    </div>
    <div v-if="!editId" class="sign-up-element flex js-between">
      <label for="password-confirm-input">Confirmation mot de passe</label>
      <input
        v-model="passwordConfirm"
        id="password-confirm-input"
        type="password"
        class="sign-up-field"
      />
    </div>
    <Button @click.once="() => submit()" class="sign-up-button">{{
      editId ? "Sauvegarder" : "Inscription"
    }}</Button>
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
  props: {
    editId: { type: Number, default: 0 },
    currentValues: Object,
  },
  data() {
    return {
      email: "",
      firstName: "",
      lastName: "",
      password: "",
      passwordConfirm: "",
      role: "",
    };
  },
  created() {
    const { currentValues } = this;
    if (!this.currentValues) return;
    this.email = currentValues?.email;
    this.firstName = currentValues?.first_name;
    this.lastName = currentValues?.last_name;
    this.role = currentValues?.role;
  },
  methods: {
    submit: async function () {
      const {
        email,
        firstName,
        lastName,
        password,
        passwordConfirm,
        role,
        editId,
      } = this;
      if (editId) {
        console.log("updating user", firstName);
        await this.updateUser(editId, {
          email,
          first_name: firstName,
          last_name: lastName,
        });
        await this.updateRole(editId, role);
        this.$emit("edit-completed");
        return;
      }
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
