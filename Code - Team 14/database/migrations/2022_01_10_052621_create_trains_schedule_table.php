<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrainsScheduleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('trains_schedule', function (Blueprint $table) {
            $table->id('trains_schedule_id');
            $table->unsignedBigInteger('train_id');
            $table->foreign('train_id')->references('train_id')->on('trains');
            $table->unsignedBigInteger('station_id');
            $table->foreign('station_id')->references('station_id')->on('stations');
            $table->unsignedBigInteger('end_station_id');
            $table->foreign('end_station_id')->references('station_id')->on('stations');

            // $table->unsignedBigInteger('inter_station_id');
            // $table->foreign('inter_station_id')->references('id')->on('intermediate_stations');
            
            
            $table->dateTime('start_date_time');
            $table->dateTime('stop_date_time');
           
            $table->boolean('status')->default(0);
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
        Schema::dropIfExists('trains_schedule');
    }
}
