<template>
  <div class="user">
    <Modal v-if="showEditModal" @close-modal="() => (showEditModal = false)">
      <SignUp
        :edit-id="selectedUser"
        :current-values="users.find((usr) => usr.id === selectedUser)"
        @edit-complete="() => handleEvent('save')"
      />
    </Modal>
    <h2>Gérer vos équipes</h2>
    <Card class="user-card" full-width>
      <div class="user-card-header">
        Le {{ currentDate.format("DD/MM/YYYY") }} à
        {{ currentDate.format("HH:mm") }} - Semaine {{ currentDate.week() }}
      </div>
      <span class="user-card-splitter" />
      <div class="user-card-body">
        <div class="flex js-between user-table-header">
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >Nom</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >H/semaine</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >H/nuit</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >H/sup</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >Présence ?</span
          >
          <span
            v-if="isAdmin"
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >Adm.</span
          >
        </div>
        <div
          v-for="(user, idx) in users"
          :key="idx"
          :class="{ 'user-table-row flex js-between': true, pointer: isAdmin }"
          @click="() => handleEvent('select', user.id)"
        >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >{{ user.first_name[0] }}. {{ user.last_name }}</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >{{ user.weekly_hours }}</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >{{ user.night_hours }}</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >{{ user.overtime_hours }}</span
          >
          <span
            class="user-table-cell"
            :style="{ width: isAdmin ? '16%' : '20%' }"
            >{{ user.presence ? "Oui" : "Non" }}</span
          >
          <div
            v-if="isAdmin"
            class="user-table-cell flex js-even"
            :style="{ width: isAdmin ? '16%' : '20%' }"
          >
            <Button icon small @click.stop="() => handleEvent('edit', user.id)">
              <UserIcon />
            </Button>
            <Button
              negative
              icon
              small
              @click.stop="() => handleEvent('delete', user.id)"
            >
              <UserXIcon />
            </Button>
          </div>
        </div>
      </div>
      <span class="user-card-splitter" />
      <div class="user-card-footer">
        <div class="user-team-header flex js-between">
          <div>
            <label for="team-input">Equipe n°</label>
            <input
              v-model="currentTeam"
              id="team-input"
              type="text"
              class="user-field"
            />
          </div>
          <Button small @click="() => handleEvent('team')">Valider</Button>
        </div>
        <div
          v-if="team.name && (team.users || []).length"
          class="user-team-body"
        >
          <div class="flex js-between user-table-header">
            <span class="user-table-cell" :style="{ width: '33%' }">Nom</span>
            <span class="user-table-cell" :style="{ width: '33%' }">Rôle</span>
            <span class="user-table-cell" :style="{ width: '33%' }"
              >Retirer</span
            >
          </div>
          <div
            v-for="(user, idx) in team.users"
            :key="idx"
            class="user-table-row flex js-between"
          >
            <span class="user-table-cell" :style="{ width: '33%' }"
              >{{ user.first_name[0] }}. {{ user.last_name }}</span
            >
            <span class="user-table-cell" :style="{ width: '33%' }">{{
              user.role
            }}</span>
            <div class="user-table-cell flex js-even" :style="{ width: '33%' }">
              <Button
                negative
                icon
                small
                @click.stop="() => handleEvent('remove', user.id)"
              >
                <UserXIcon />
              </Button>
            </div>
          </div>
        </div>
        <div v-else class="user-team-body-empty">
          <div v-if="team.name">L'équipe sélectionnée est vide</div>
          <div v-else>Aucune équipe sélectionnée</div>
        </div>
        <div v-if="team.name" class="user-team-footer flex js-between">
          <div>
            <label for="email-input">Utilisateur :</label>
            <input
              v-model="selectedUser"
              id="email-input"
              type="number"
              class="user-field"
            />
          </div>
          <Button small @click="() => handleEvent('add', selectedUser)"
            >Ajouter</Button
          >
        </div>
      </div>
    </Card>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-this-alias */
/* eslint-disable @typescript-eslint/no-empty-function */
import mixins from "vue-typed-mixins";
import _ from "lodash";
import { mapState } from "vuex";
import moment from "moment";
import { UserXIcon, UserIcon } from "vue-feather-icons";

import { Card, Button, Modal } from "@/components/global";
import { SignUp } from "@/components/forms";
import { API } from "@/mixins";
import { chainPromises } from "@/utils/helpers";

export default mixins(API).extend({
  name: "tm-user",
  components: {
    Card,
    Button,
    UserXIcon,
    UserIcon,
    SignUp,
    Modal,
  },
  data() {
    return {
      currentDate: moment(),
      currentTeam: "",
      users: [],
      team: {},
      selectedUser: 0,
      showEditModal: false,
    };
  },
  computed: {
    ...mapState(["currentUser", "isAdmin"]),
  },
  created() {
    this.init();
  },
  methods: {
    init: async function () {
      await this.loadUsers();
    },
    loadUsers: async function () {
      const data = _.sortBy(
        await this.getAllUsers().then((result: any) => result?.data),
        "last_name"
      );
      const promises = data.map((user: any) =>
        this.getWorkingTimes(
          user?.id,
          moment().startOf("week").format("YYYY-MM-DD"),
          moment().endOf("week").format("YYYY-MM-DD")
        )
      );
      const wtData = await chainPromises(promises);
      this.$set(
        this,
        "users",
        data.map((user: any, idx: number) => {
          return {
            ...user,
            ...this.computeHours(wtData[idx]?.data),
          };
        })
      );
    },
    loadTeam: async function () {
      const { currentTeam } = this;
      let data;
      if (!+currentTeam)
        data = ((await this.createTeam(currentTeam)) || {})?.data;
      else data = ((await this.getSingleTeam(+currentTeam)) || {})?.data;
      this.$set(this, "team", data);
      console.log({ team: data });
    },
    handleEvent: async function (event: string, userId: number) {
      const { team } = this;
      switch (event) {
        case "delete":
          await this.deleteUser(userId);
          await this.loadUsers();
          break;
        case "edit":
          this.selectedUser = userId;
          this.showEditModal = true;
          break;
        case "save":
          this.showEditModal = false;
          this.selectedUser = 0;
          await this.loadUsers();
          break;
        case "team":
          await this.loadTeam();
          break;
        case "select":
          this.selectedUser = userId;
          break;
        case "add":
          if (userId && !(team as any)?.users?.includes(+userId))
            await this.updateTeam((team as any)?.id, {
              user_ids: [
                ...(team as any)?.users.map((usr: any) => usr?.id),
                +userId,
              ],
            });
          await this.loadTeam();
          break;
        case "remove":
          if (userId && !(team as any)?.users?.includes(+userId))
            await this.updateTeam((team as any)?.id, {
              user_ids: (team as any)?.users
                .map((usr: any) => usr?.id)
                .filter((usrId: any) => usrId !== +userId),
            });
          await this.loadTeam();
          break;
        default:
          return;
      }
    },
    computeHours: function (wt: Array<any>): Record<string, any> {
      const { total, night } = wt.reduce(
        (acc: any, curr: any) => {
          const tmpTotal = Math.abs(
            moment(curr?.start).diff(moment(curr?.end), "minutes")
          );
          const tmpNight =
            moment(curr?.end).isBetween("20:00", "6:00") ||
            moment(curr?.start).isBetween("20:00", "6:00")
              ? Math.abs(
                  moment
                    .max(moment(curr?.start), moment(curr?.start).hour(20))
                    .diff(
                      moment.min(moment(curr?.end), moment(curr?.end).hour(6)),
                      "minutes"
                    )
                )
              : 0;
          return {
            ...acc,
            total: acc?.total + Math.round(tmpTotal / 60),
            night: acc?.night + Math.round(tmpNight / 60),
          };
        },
        { total: 0, night: 0 }
      );
      return {
        weekly_hours: total,
        night_hours: night,
        overtime_hours: Math.max(0, total - 35),
        presence: wt?.length
          ? moment(_.last(wt)?.end).isSame(moment(), "day")
          : false,
      };
    },
  },
});
</script>

<style lang="scss">
div.application {
  .user {
    width: 100%;
    &-field {
      margin-left: 16px;
      height: 32px;
    }
    &-table {
      &-header {
        font-weight: bold;
        margin-bottom: 8px;
        margin-top: 8px;
      }
      &-row {
        border-top: 1px solid $color-border;
        padding-top: 4px;
        padding-bottom: 4px;
        &:hover {
          background: $color-border;
        }
      }
      &-cell {
        min-width: 15%;
        max-width: 20%;
        align-self: center;
      }
    }
    &-card {
      margin-top: 8px;
      &-header {
        margin-bottom: 8px;
      }
      &-body {
        margin-top: 8px;
        margin-bottom: 8px;
        overflow-y: auto;
        max-height: 50vh;
      }
      &-footer {
        margin-top: 8px;
        max-height: 50vh;
      }
      &-splitter {
        border-bottom: 1px solid $color-border;
        width: 100%;
      }
    }
    &-team {
      &-body {
        padding-top: 16px;
        padding-bottom: 16px;
        &-empty {
          padding-top: 64px;
          padding-bottom: 64px;
        }
      }
    }
  }
}
</style>
