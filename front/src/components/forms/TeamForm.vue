<template>
  <div class="team-form flex f-column">
    <h3 class="team-form-title">Mise à jour équipe</h3>
    <div class="team-form-element flex js-between">
      <label for="name-input">Nom</label>
      <input
        v-model="name"
        id="name-input"
        type="text"
        class="team-form-field"
      />
    </div>
    <div class="team-form-users">
      <div
        class="team-form-row flex js-between"
        v-for="(user, idx) in users"
        :key="idx"
      >
        <span>{{ user.first_name[0] }}. {{ user.last_name }}</span>
        <div>
          <Button
            small
            icon
            negative
            @click="() => (users = users.filter((usr) => usr.id !== user.id))"
          >
            <UserXIcon />
          </Button>
        </div>
      </div>
    </div>
    <Button @click.once="() => submit()" class="team-form-button"
      >Sauvegarder</Button
    >
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import mixins from "vue-typed-mixins";
import { UserXIcon } from "vue-feather-icons";

import { API } from "@/mixins";
import { Button } from "@/components/global";

export default mixins(API).extend({
  name: "tm-teamform",
  components: {
    Button,
    UserXIcon,
  },
  props: {
    editId: { type: Number, default: 0 },
    currentValues: Object,
  },
  data() {
    return {
      name: "",
      users: [],
    };
  },
  created() {
    const { currentValues } = this;
    if (!this.currentValues) return;
    this.name = currentValues?.name;
    this.users = currentValues?.users;
  },
  methods: {
    submit: async function () {
      const { name, users, editId } = this;
      if (!editId) return;
      console.log("updating team", name);
      await this.updateTeam(editId, {
        name,
        user_ids: users.map((usr: any) => usr?.id),
      });
      this.$emit("edit-completed");
      return;
    },
  },
});
</script>

<style lang="scss">
div.application {
  .team-form {
    &-element {
      margin-top: 8px;
      margin-bottom: 16px;
    }
    &-field {
      margin-left: 16px;
      height: 32px;
    }
    &-button {
      margin-top: 16px;
    }
    &-users {
      border-top: 1px solid $color-border;
      padding-top: 16px;
    }
  }
}
</style>
