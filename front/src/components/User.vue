<template>
  <div class="user">
    <Modal v-if="showEditModal" @close-modal="() => (showEditModal = false)">
      <SignUp
        :edit-id="selectedUser.id"
        :current-values="selectedUser"
        @edit-completed="() => handleEvent('saveUser')"
      />
    </Modal>
    <Modal v-if="showTeamModal" @close-modal="() => (showTeamModal = false)">
      <TeamForm
        :edit-id="selectedTeam.id"
        :current-values="selectedTeam"
        @edit-completed="() => handleEvent('saveTeam')"
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
          class="user-table-row flex js-between pointer"
          @click="() => handleEvent('selectUser', user.id)"
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
            <Button
              icon
              small
              @btn-click="() => handleEvent('editUser', user.id)"
            >
              <UserIcon />
            </Button>
            <Button
              negative
              icon
              small
              @btn-click="() => handleEvent('deleteUser', user.id)"
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
            <label for="team-input">Ajouter à</label>
            <input
              v-model="newTeamName"
              id="team-input"
              type="text"
              class="user-field"
              placeholder="Nom"
            />
          </div>
          <Button small @btn-click="() => handleEvent('team')">{{
            computedFieldTeam.id ? "Ajouter" : "Créer"
          }}</Button>
        </div>
        <div
          v-if="selectedUser && (selectedUser.teams || []).length"
          class="user-team-body"
        >
          <div class="flex js-between user-table-header">
            <span class="user-table-cell" :style="{ width: '33%' }">Nom</span>
            <span class="user-table-cell" :style="{ width: '33%' }"
              >Taille</span
            >
            <span class="user-table-cell" :style="{ width: '33%' }">Adm.</span>
          </div>
          <div
            v-for="(team, idx) in selectedUser.teams || []"
            :key="idx"
            class="user-table-row flex js-between pointer"
            @click="() => handleEvent('selectTeam', team.id)"
          >
            <span class="user-table-cell" :style="{ width: '33%' }">{{
              team.name
            }}</span>
            <span class="user-table-cell" :style="{ width: '33%' }">Temp</span>
            <div class="user-table-cell flex js-even" :style="{ width: '33%' }">
              <Button
                icon
                small
                @btn-click="() => handleEvent('editTeam', team.id)"
              >
                <UserIcon />
              </Button>
              <Button
                negative
                icon
                small
                @btn-click="() => handleEvent('deleteTeam', team.id)"
              >
                <UserXIcon />
              </Button>
            </div>
          </div>
        </div>
        <div v-else class="user-team-body-empty">
          <span v-if="selectedUser.id"
            >L'utilisateur sélectionné n'a pas d'équipe</span
          >
          <span v-else>Aucun utilisateur sélectionné</span>
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
import { SignUp, TeamForm } from "@/components/forms";
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
    TeamForm,
  },
  data() {
    return {
      currentDate: moment(),
      newTeamName: "",
      users: [],
      teams: [],
      selectedUser: {},
      selectedTeam: {},
      showEditModal: false,
      showTeamModal: false,
    };
  },
  computed: {
    computedFieldTeam: function (): Record<string, any> {
      const { teams, newTeamName } = this;
      return teams.find((tm: any) => tm?.name === newTeamName) || {};
    },
    ...mapState(["currentUser", "isAdmin"]),
  },
  created() {
    this.init();
  },
  methods: {
    init: async function () {
      await this.loadUsers();
      await this.loadTeams();
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
    loadTeams: async function () {
      const data = _.sortBy(
        await this.getAllTeams().then((result: any) => result?.data),
        "name"
      );
      this.$set(this, "teams", data);
    },
    handleEvent: async function (event: string, targetId: number) {
      const {
        newTeamName,
        computedFieldTeam: team,
        teams,
        users,
        selectedUser,
      } = this;
      switch (event) {
        case "deleteUser":
          await this.deleteUser(targetId);
          await this.loadTeams();
          await this.loadUsers();
          break;
        case "deleteTeam":
          await this.deleteTeam(targetId);
          await this.loadTeams();
          await this.loadUsers();
          this.selectedUser = {};
          break;
        case "editUser":
          this.selectedUser = users.find(
            (usr: any) => usr?.id === targetId
          ) as any;
          this.showEditModal = true;
          break;
        case "editTeam":
          this.selectedTeam = teams.find(
            (tm: any) => tm?.id === targetId
          ) as any;
          this.showTeamModal = true;
          break;
        case "saveUser":
          this.showEditModal = false;
          this.selectedUser = {};
          await this.loadTeams();
          await this.loadUsers();
          break;
        case "saveTeam":
          this.showTeamModal = false;
          this.selectedTeam = {};
          await this.loadTeams();
          await this.loadUsers();
          break;
        case "team":
          if (team?.id)
            await this.updateTeam(team?.id, {
              user_ids: [
                ...team?.users?.map((usr: any) => usr?.id),
                (selectedUser as any)?.id,
              ],
            });
          else
            await this.createTeam(
              newTeamName,
              (selectedUser as any)?.id ? [(selectedUser as any)?.id] : []
            );
          await this.loadTeams();
          await this.loadUsers();
          this.selectedUser = {};
          break;
        case "selectUser":
          this.selectedUser = users.find(
            (usr: any) => usr?.id === targetId
          ) as any;
          this.$emit("select-user", this.selectedUser);
          break;
        case "selectTeam":
          this.selectedTeam = teams.find(
            (tm: any) => tm?.id === targetId
          ) as any;
          this.$emit("select-team", this.selectedTeam);
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
