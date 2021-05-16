<template>
  <div class="main">
    <el-button class="btn-add" @click="showDialog('', '', 'add')" type="primary"
      >Add Scheduled Bus</el-button
    >
    <el-input
      class="search-input"
      v-model="search"
      max-width="250"
      placeholder="Type to search"
    />
    <el-table
      class="bus-table"
      :data="
        scheduledBusesData.filter(
          (data) =>
            !search ||
            data.departure_date.toLowerCase().includes(search.toLowerCase())
        )
      "
      border
      style="width: 100%"
    >
      <el-table-column type="index" label="Id" width="100"> </el-table-column>
      <el-table-column prop="origin" label="Origin"></el-table-column>
      <el-table-column prop="destination" label="Destination"></el-table-column>
      <el-table-column prop="depature_date" label="Depature Date">
        <template slot-scope="scope">
          {{ scope.row.departure_date | formatDate }}
        </template>
      </el-table-column>
      <el-table-column prop="arrival_date" label="Arrival Date">
        <template slot-scope="scope">
          {{ scope.row.arrival_date | formatDate }}
        </template>
      </el-table-column>
      <el-table-column prop="departure_time" label="Depature Time">
        <template slot-scope="scope">
          {{ scope.row.departure_time | formatTime }}
        </template></el-table-column
      >
      <el-table-column prop="arrival_time" label="Arrival Time">
        <template slot-scope="scope">
          {{ scope.row.arrival_time | formatTime }}
        </template></el-table-column
      >

      <el-table-column label="Actions" width="200">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="showDialog(scope.$index, scope.row, 'edit')"
            >Edit</el-button
          >
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
            >Delete</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-dialog :title="formTitle" :visible.sync="dialogFormVisible">
      <el-form :model="formDataScheduledBus">
        <el-form-item label="Bus Name" label-width="150px">
          <el-select
            width="300px"
            v-model="formDataScheduledBus.bus_id"
            placeholder="Select bus"
          >
            <el-option
              v-for="(bus, index) in busesData"
              :key="index"
              :label="bus.name"
              :value="bus.id"
              >{{ bus.name }}
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Bus Number" label-width="150px">
          <el-input
            v-model="formDataScheduledBus.bus_number"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-row>
          <el-col :span="10">
            <el-form-item label="Origin" label-width="150px">
              <el-input
                class="origin-input"
                v-model="formDataScheduledBus.origin"
                autocomplete="off"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="10" style="margin-left: 20px">
            <el-form-item label="Destination" label-width="150px">
              <el-input
                class="destination-input"
                v-model="formDataScheduledBus.destination"
                autocomplete="off"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="Depature Center" label-width="150px">
          <el-input
            v-model="formDataScheduledBus.departure_center"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Destination Center" label-width="150px">
          <el-input
            v-model="formDataScheduledBus.arrival_center"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Scheduled Date" label-width="150px">
          <el-row>
            <el-col :span="10">
              <el-form-item prop="departure_date">
                <el-date-picker
                  v-model="formDataScheduledBus.departure_date"
                  type="date"
                  placeholder="Departure date"
                >
                </el-date-picker>
              </el-form-item>
            </el-col>
            <el-col :span="10" style="margin-left: 20px">
              <el-form-item prop="arrival_date">
                <el-date-picker
                  v-model="formDataScheduledBus.arrival_date"
                  type="date"
                  placeholder="Arrival date"
                >
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label-width="150px" label="Time">
          <el-row>
            <el-col :span="10">
              <el-form-item prop="departure_time">
                <el-time-picker
                  placeholder="Depature Time"
                  v-model="formDataScheduledBus.departure_time"
                  style="width: 100%;"
                ></el-time-picker>
              </el-form-item>
            </el-col>
            <el-col :span="10" style="margin-left: 20px">
              <el-form-item prop="arrival_time">
                <el-time-picker
                  placeholder="Arrival Time"
                  v-model="formDataScheduledBus.arrival_time"
                  style="width: 100%;"
                ></el-time-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Duration" label-width="150px">
          <span class="duration-input">
            {{ calculateDuration }}
          </span>
        </el-form-item>
        <el-row>
          <el-col :span="10">
            <el-form-item label="Seats" label-width="150px">
              <el-input
                class="seats-input"
                v-model="formDataScheduledBus.seats"
                autocomplete="off"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="10" style="margin-left: 20px">
            <el-form-item label="Bus Fare" label-width="150px">
              <el-input
                class="bus-fare-input"
                v-model="formDataScheduledBus.price"
                autocomplete="off"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">Cancel</el-button>
        <el-button
          type="primary"
          @click="formType === 'add' ? handleAdd() : handleEdit()"
          >Save</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>
<script>
import EventBus from "../EventBus";
import axios from "axios";
import moment from "moment";
export default {
  name: "ScheduledBuses",
  data() {
    return {
      userInfo: {},
      busesData: [],
      scheduledBusesData: [],
      search: "",
      dialogFormVisible: false,
      formTitle: null,
      formType: null,
      scheduledBusId: null,
      formDataScheduledBus: {
        bus_id: null,
        bus_number: null,
        origin: null,
        destination: null,
        departure_center: null,
        arrival_center: null,
        departure_time: null,
        arrival_time: null,
        duration: null,
        seats: null,
        departure_date: null,
        arrival_date: null,
        price: null,
        rating: null,
      },
    };
  },
  created() {
    this.getAllBuses();
    this.getAllScheduledBuses();
    if (this.checkIfIsLogged) {
      console.log("inside here logged");
    }
  },
  methods: {
    getAllBuses() {
      const _this = this;
      axios
        .get("/api/buses")
        .then(function(response) {
          _this.busesData = response.data.data;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    getAllScheduledBuses() {
      const _this = this;
      axios
        .get("/api/scheduled_buses")
        .then(function(response) {
          _this.scheduledBusesData = response.data.data;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    showDialog(index, row, type) {
      console.log(index, row, type);
      this.dialogFormVisible = true;
      if (type === "add") {
        this.formTitle = "Add New Scheduled Bus";
        this.formType = type;
        this.scheduledBusId = null;
      } else if (type === "edit") {
        this.formTitle = "Edit Scheduled Bus";
        this.formType = type;
        this.scheduledBusId = row.id;
        this.formDataScheduledBus.bus_id = row.bus_id;
        this.formDataScheduledBus.bus_number = row.bus_number;
        this.formDataScheduledBus.origin = row.origin;
        this.formDataScheduledBus.destination = row.destination;
        this.formDataScheduledBus.departure_center = row.departure_center;
        this.formDataScheduledBus.departure_time = row.departure_time;
        this.formDataScheduledBus.arrival_center = row.arrival_center;
        this.formDataScheduledBus.arrival_time = row.arrival_time;
        this.formDataScheduledBus.departure_date = row.departure_date;
        this.formDataScheduledBus.arrival_date = row.arrival_date;
        this.formDataScheduledBus.duration = row.duration;
        this.formDataScheduledBus.seats = row.seats;
        this.formDataScheduledBus.price = row.price;
      }
    },

    handleEdit() {
      console.log("in edit");
      if (this.scheduledBusId !== null && this.formDataScheduledBus !== null) {
        const _this = this;
        axios
          .put(
            `/api/scheduled_buses/${_this.scheduledBusId}`,
            _this.formDataScheduledBus
          )
          .then(function(response) {
            _this.dialogFormVisible = false;
            _this.getAllScheduledBuses();
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    },
    handleAdd() {
      console.log("in add");
      if (this.formDataScheduledBus !== null) {
        const _this = this;
        axios
          .post(`/api/scheduled_buses`, _this.formDataScheduledBus)
          .then(function(response) {
            _this.dialogFormVisible = false;
            _this.getAllScheduledBuses();
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    },
    handleDelete(index, row) {
      console.log(index, row);
      const _this = this;
      axios
        .delete(`/api/scheduled_buses/${row.id}`)
        .then(function(response) {
          _this.getAllScheduledBuses();
        })
        .catch(function(error) {
          console.log(error);
        });
    },
  },
  computed: {
    checkIfIsLogged() {
      console.log(localStorage);
      let token = localStorage.getItem("userInfo");
      if (token) {
        EventBus.$emit("logged", "User logged");
        this.userInfo = JSON.parse(localStorage.getItem("userInfo"));

        return true;
      } else {
        console.log("Sorry, you aren't logged in");
        this.$router.push("/");
        return false;
      }
    },
    calculateDuration() {
      console.log("calculting duration");
      if (
        this.formDataScheduledBus.departure_time !== null &&
        this.formDataScheduledBus.arrival_time !== null
      ) {
        const startTime = moment(
          this.formDataScheduledBus.departure_time,
          "HH:mm:ss a"
        );
        const endTime = moment(
          this.formDataScheduledBus.arrival_time,
          "HH:mm:ss a"
        );
        const duration = moment.duration(endTime.diff(startTime));
        const hours = parseInt(duration.asHours());
        const minutes = parseInt(duration.asMinutes()) - hours * 60;
        if (this.formDataScheduledBus.duration !== null) {
        }
        this.formDataScheduledBus.duration = `${hours}h ${minutes}m`;
        if (hours < 0) {
          return `Arrival time should be greater than Depature Time `;
        } else {
          return `${hours}h ${minutes}m`;
        }
      }
    },
  },
};
</script>
<style scoped>
.main {
  display: flex;
}
.bus-table {
  margin-top: 100px;
  margin-bottom: 10px;
  margin-left: 50px;
  margin-right: 50px;
}
.btn-add {
  left: 0;
  margin-top: 50px;
  position: absolute;
  margin-bottom: 10px;
  margin-left: 50px;
}
.origin-input {
  width: 200px;
}
.destination-input {
  width: 200px;
}
.seats-input {
  width: 200px;
}
.bus-fare-input {
  width: 200px;
}
.duration-input {
  font-size: 20px;
  font-style: Bold;
}
.search-input {
  right: 0;
  width: 250px;
  position: absolute;
  margin-top: 50px;
  margin-bottom: 10px;
  margin-right: 50px;
}
</style>
