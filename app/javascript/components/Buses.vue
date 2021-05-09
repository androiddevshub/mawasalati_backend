<template>
  <div class="main">
    <el-button class="btn-add" @click="showDialog('', '', 'add')" type="primary"
      >Add Bus</el-button
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
        busesData.filter(
          (data) =>
            !search || data.name.toLowerCase().includes(search.toLowerCase())
        )
      "
      border
      style="width: 100%"
    >
      <el-table-column type="index" label="Id" width="100"> </el-table-column>
      <el-table-column prop="name" label="Name"></el-table-column>
      <el-table-column prop="bus_type" label="Type"></el-table-column>
      <el-table-column
        prop="operator_contact_first"
        label="Operator Contact First"
      ></el-table-column>
      <el-table-column
        prop="operator_contact_second"
        label="Operator Contact Second"
      ></el-table-column>

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
      <el-form :model="formDataBus">
        <el-form-item label="Name" label-width="200px">
          <el-input v-model="formDataBus.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Type" label-width="200px">
          <el-input
            v-model="formDataBus.bus_type"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Operator Contact First" label-width="200px">
          <el-input
            v-model="formDataBus.operator_contact_first"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Operator Contact Second" label-width="200px">
          <el-input
            v-model="formDataBus.operator_contact_second"
            autocomplete="off"
          ></el-input>
        </el-form-item>
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
export default {
  name: "Buses",
  data() {
    return {
      userInfo: {},
      busesData: [],
      search: "",
      dialogFormVisible: false,
      formTitle: null,
      formType: null,
      busId: null,
      formDataBus: {
        name: null,
        bus_type: null,
        operator_contact_first: null,
        operator_contact_second: null,
      },
    };
  },
  created() {
    this.getAllBuses();
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
    showDialog(index, row, type) {
      console.log(index, row, type);
      this.dialogFormVisible = true;
      if (type === "add") {
        this.formTitle = "Add New Bus";
        this.formType = type;
        this.busId = null;
        this.formDataBus.name = null;
        this.formDataBus.bus_type = null;
        this.formDataBus.operator_contact_first = null;
        this.formDataBus.operator_contact_second = null;
      } else if (type === "edit") {
        this.formTitle = "Edit Bus";
        this.formType = type;
        this.busId = row.id;
        this.formDataBus.name = row.name;
        this.formDataBus.bus_type = row.bus_type;
        this.formDataBus.operator_contact_first = row.operator_contact_first;
        this.formDataBus.operator_contact_second = row.operator_contact_second;
      }
    },

    handleEdit() {
      console.log("in edit");
      if (this.busId !== null && this.formDataBus.name !== null) {
        const _this = this;
        axios
          .put(`/api/buses/${_this.busId}`, _this.formDataBus)
          .then(function(response) {
            _this.dialogFormVisible = false;
            _this.getAllBuses();
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    },
    handleAdd() {
      console.log("in add");
      if (this.formDataBus.name !== null) {
        const _this = this;
        axios
          .post(`/api/buses`, _this.formDataBus)
          .then(function(response) {
            _this.dialogFormVisible = false;
            _this.getAllBuses();
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
        .delete(`/api/buses/${row.id}`)
        .then(function(response) {
          _this.getAllBuses();
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
.search-input {
  right: 0;
  width: 250px;
  position: absolute;
  margin-top: 50px;
  margin-bottom: 10px;
  margin-right: 50px;
}
</style>
