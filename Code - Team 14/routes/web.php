<?php

use app\Models\User;
use App\Models\Booking;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\StripeController;
use app\Http\Controllers\DashboardController;
use  App\Http\Controllers\backend\UserController;
use App\Http\Controllers\backend\UserController1;
use App\Http\Controllers\backend\TrainsController;
use App\Http\Controllers\backend\StationController;
use App\Http\Controllers\backend\ScheduleController;
use App\Http\Controllers\usercontroller\indexUserController;
use App\Http\Controllers\usercontroller\UserTicketController;
use App\Http\Controllers\backend\Intermediate_stationController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('home');
});
Route::get('/contact', function () {
  return view('contact');
});

Route::get('/dashboard', function () {
    // return view('dashboard');
    if(Auth::user()->hasRole('admin')){
      return view('admin.index');
  }elseif(Auth::user()->hasRole('user')){ 
    
    $id =Auth::user()->id;
    $data['user']=User::find($id);
    $data['book'] = Booking::find($id);
    $data['amount'] = 10;  
    return view('main_user.index',$data);
  }
})->middleware(['auth'])->name('dashboard');
 
// Route::group(['middleware'=>['auth']],function(){
//   Route::get('/dashboard', [DashboardController::class,'index'])->name('dashboard');
// });

// admin logout route
Route::get('/admin/logout', [AdminController::class,'logout'])->name('admin.logout');

// User Management all Routes
Route::prefix('user')->group(function(){
  Route::get('/view', [UserController1::class,'index'])->name('User.View');

  Route::get('/add', [UserController1::class,'create'])->name('User.add');
  Route::post('/store', [UserController1::class,'store'])->name('User.store');
  Route::get('/edit/{id}', [UserController1::class,'edit'])->name('User.edit');
  Route::post('/update/{id}', [UserController1::class,'update'])->name('User.update');
  Route::get('/delete/{id}', [UserController1::class,'destroy'])->name('User.delete');


});

// train management all routes

Route::prefix('train')->group(function(){
  Route::get('/view', [TrainsController::class,'index'])->name('train.View');

  Route::get('/add', [TrainsController::class,'create'])->name('train.add');
  Route::post('/store', [TrainsController::class,'store'])->name('train.store');
  Route::get('/edit/{train_id}', [TrainsController::class,'edit'])->name('train.edit');
  Route::post('/update/{train_id}', [TrainsController::class,'update'])->name('train.update');
  Route::get('/delete/{train_id}', [TrainsController::class,'destroy'])->name('train.delete');


});

Route::prefix('station')->group(function(){
  Route::get('/view', [StationController::class,'index'])->name('station.View');

  Route::get('/add', [StationController::class,'create'])->name('station.add');
  Route::post('/store', [StationController::class,'store'])->name('station.store');
  Route::get('/edit/{station_id}', [StationController::class,'edit'])->name('station.edit');
  Route::post('/update/{station_id}', [StationController::class,'update'])->name('station.update');
  Route::get('/delete/{station_id}', [StationController::class,'destroy'])->name('station.delete');


});


Route::prefix('train/schedule')->group(function(){
  Route::get('/view', [ScheduleController::class,'index'])->name('schedule.View');

  Route::get('/add', [ScheduleController::class,'create'])->name('schedule.add');
  Route::post('/store', [ScheduleController::class,'store'])->name('schedule.store');
  Route::get('/edit/{trains_schedule_id}', [ScheduleController::class,'edit'])->name('schedule.edit');
  Route::post('/update/{trains_schedule_id}', [ScheduleController::class,'update'])->name('schedule.update');
  Route::get('/delete/{trains_schedule_id}', [ScheduleController::class,'destroy'])->name('schedule.delete');


});


Route::prefix('train/schedule/interstation')->group(function(){
  Route::get('/view', [Intermediate_stationController::class,'index'])->name('interstation.View');

  Route::get('/add', [Intermediate_stationController::class,'create'])->name('interstation.add');
  Route::post('/store', [Intermediate_stationController::class,'store'])->name('interstation.store');
  Route::get('/edit/{inter_station_id}', [Intermediate_stationController::class,'edit'])->name('interstation.edit');
  Route::get('/show/{station_id}', [Intermediate_stationController::class,'show'])->name('interstation.show');
  Route::post('/update/{inter_station_id}', [Intermediate_stationController::class,'update'])->name('interstation.update');
  Route::get('/delete/{inter_station_id}', [Intermediate_stationController::class,'destroy'])->name('interstation.delete');


});


Route::prefix('train/ticket')->group(function(){
  Route::get('/view', [UserTicketController::class,'index'])->name('ticket.View');

  Route::post('/store', [UserTicketController::class,'store'])->name('ticket.store');
  Route::get('/showdetais', [UserTicketController::class,'showdetais'])->name('ticket.showdetais');
  Route::get('/book/{book_id}', [UserTicketController::class,'book'])->name('ticket.book');
  Route::get('/cancel/{book_id}', [UserTicketController::class,'cancel'])->name('ticket.Cancel');
  Route::post('/book_pay/{book_id}', [UserTicketController::class,'book_pay'])->name('ticket.pay.store');


  Route::get('/booked', [indexUserController::class,'index'])->name('ticket.booked');

  // Route::get('/add', [Intermediate_stationController::class,'create'])->name('interstation.add');
  // Route::get('/edit/{inter_station_id}', [Intermediate_stationController::class,'edit'])->name('interstation.edit');
  // Route::get('/show/{station_id}', [Intermediate_stationController::class,'show'])->name('interstation.show');
  // Route::post('/update/{inter_station_id}', [Intermediate_stationController::class,'update'])->name('interstation.update');
  // Route::get('/delete/{inter_station_id}', [Intermediate_stationController::class,'destroy'])->name('interstation.delete');


});

//payment routes


Route::get('checkout/{book_id}', [StripeController::class, 'checkout'])->name('checkout');
Route::post('checkout', [StripeController::class, 'afterpayment'])->name('checkout.credit-card');







 
require __DIR__.'/auth.php';
