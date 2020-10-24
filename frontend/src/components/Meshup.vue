<template>
  <div class="meshup">
    <el-row type="flex" justify="center">
      <el-col :span="10">
        <el-input
          id="search"
          size="small"
          v-model="searchInput"
          placeholder="City name"
          prefix-icon="el-icon-search"
          clearable
          @keyup.enter.native="search"
        ></el-input>
      </el-col>
    </el-row>

    <el-row type="flex" justify="center" v-if="visable">
      <el-col>
        <h2>{{ cityName }}</h2>
      </el-col>
    </el-row>

    <el-row type="flex" :gutter="20" justify="center" v-if="visable">
      <el-col span="600">
        <el-card class="box-card">
          <h3>Weather</h3>
          <el-link
            href="https://openweathermap.org"
            type="info"
            target="_blank"
          >From openweathermap.org</el-link>
          <el-table
            :data="weatherData"
            stripe
            style="width: 100%"
            align="center"
            height="100"
            v-loading="loading"
          >
            <el-table-column prop="weather" label="Weather" width="180"></el-table-column>
            <el-table-column prop="real" label="Real Temperature" width="180"></el-table-column>
            <el-table-column prop="feel" label="Feels Like" width="180"></el-table-column>
          </el-table>
        </el-card>
      </el-col>

      <el-col span="600">
        <el-card class="box-card">
          <h3>AQI</h3>
          <el-link href="https://aqicn.org" type="info" target="_blank">From aqicn.org</el-link>
          <el-table
            :data="aqiData"
            stripe
            style="width: 100%"
            align="center"
            height="100"
            v-loading="loading"
          >
            <el-table-column prop="aqi" label="AQI" width="180"></el-table-column>
            <el-table-column prop="idx" label="IDX" width="180"></el-table-column>
            <el-table-column prop="pollution" label="Main pollution" width="180"></el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-row type="flex" :gutter="20" justify="center" v-if="visable">
      <el-col span="400">
        <el-card class="box-card">
          <h3>On Wikipedia</h3>
          <el-link href="https://en.wikipedia.org" type="info" target="_blank">From en.wikipedia.org</el-link>
          <el-table
            :data="wikiData"
            stripe
            style="width: 100%"
            align="center"
            height="600"
            v-loading="loading"
          >
            <el-table-column prop="index" label="Index" width="60"></el-table-column>
            <el-table-column prop="title" label="Title" width="240"></el-table-column>
            <el-table-column prop="word" label="Word Count" width="100"></el-table-column>
          </el-table>
        </el-card>
      </el-col>

      <el-col span="800">
        <el-card class="box-card">
          <h3>Related News</h3>
          <el-link href="https://newsapi.org" type="info" target="_blank">From newsapi.org</el-link>
          <el-table
            :data="newsData"
            stripe
            style="width: 100%"
            align="center"
            height="600"
            v-loading="loading"
          >
            <el-table-column prop="index" label="Index" width="60"></el-table-column>
            <el-table-column prop="date" label="Date" width="200"></el-table-column>
            <el-table-column prop="source" label="Source" width="180"></el-table-column>
            <el-table-column prop="description" label="Description" width="300"></el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script lang="ts">
// @ts-nocheck
import { Component, Prop, Vue } from 'vue-property-decorator';
import { MeshupApi } from '../api/api';
import { XmlParser } from '../utils/xml-parser';

@Component
export default class Meshup extends Vue {
  private searchInput: string = '';
  private cityName: string = '';

  private visable: boolean = false;
  private loading: boolean = true;

  private weatherData: any[] = [];
  private wikiData: any[] = [];
  private aqiData: any[] = [];
  private newsData: any[] = [];

  private api = new MeshupApi();

  constructor() {
    super();
    this.noticeUser();
  }

  private noticeUser() {
    this.$alert(
      'All the data comes from the Internet.\n Make sure it can be accessed from your country.',
      'Notice',
      {
        confirmButtonText: 'I can access the Internet without any censorship',
      },
    );
  }

  private search() {
    this.loading = true;
    const city = this.searchInput;
    this.handleMeshup(city);
    this.visable = true;
    this.clearData();
  }

  private clearData() {
    this.weatherData = [];
    this.wikiData = [];
    this.aqiData = [];
    this.newsData = [];
    this.searchInput = '';
  }

  private handleMeshup(city: string) {
    this.api
      .meshup(city)
      .then((response) => {
        const xmlParser = new XmlParser();
        const meshupObj = JSON.parse(xmlParser.parse(response.data)).meshup;

        console.log(meshupObj);

        // hanle weather here
        this.weatherData.push({
          weather: meshupObj.weather.weather._text,
          real: meshupObj.weather.temp.real._text,
          feel: meshupObj.weather.temp.feel._text,
        });

        // hanle aqi here
        this.aqiData.push({
          aqi: meshupObj.aqi.aqi._text,
          idx: meshupObj.aqi.idx._text,
          pollution: meshupObj.aqi.pollution._text,
        });

        // hanle wiki here
        meshupObj.wiki.pages.forEach((page, index) => {
          this.wikiData.push({
            index,
            title: page.title._text,
            word: page.word._text,
          });
        });

        // hanle news here
        meshupObj.news.articles.forEach((article, index) => {
          this.newsData.push({
            index,
            date: article.date._text,
            source: article.source._text,
            description: article.description._text,
          });
        });

        // stop loading
        this.loading = false;

        this.cityName = city.toUpperCase();
      })
      .catch((err) => {
        this.$notify.error({
          title: 'Error',
          message: 'Failed to query, check your input and try again',
        });
        console.log(err);
        this.clearData();
        this.visable = false;
        this.loading = true;
      });
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.el-row {
  margin-bottom: 20px;
  &:last-child {
    margin-bottom: 0;
  }
}
.el-col {
  border-radius: 4px;
}
</style>
