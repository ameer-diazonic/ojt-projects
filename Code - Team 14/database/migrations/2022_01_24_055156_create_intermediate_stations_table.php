<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateIntermediateStationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('intermediate_stations', function (Blueprint $table) {
            $table->id('inter_station_id');
            $table->unsignedBigInteger('station_id');
            $table->foreign('station_id')->references('station_id')->on('stations');

            $table->string('inter_station');
           

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('intermediate_stations');
    }
}
