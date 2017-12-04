<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="nbAccountMenu">
    <xsl:choose>
      <xsl:when test="count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)>0">
        <xsl:value-of select="12 div count(sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)" />
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>

  </xsl:variable>
  <xsl:template match="/">

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li>
          <a href="#">
            <span>
              <ix class="fa fa-dashboard"></ix>
            </span>&#160;Home
          </a>
        </li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <xsl:apply-templates select="sqroot/widgets/widgetPages/widgetPage" />
      <!-- Small boxes (Stat box) -->


    </section>


  </xsl:template>

  <xsl:template match="widgets/widgetPages/widgetPage">
    <xsl:apply-templates select="widgetSections/widgetSection" />

  </xsl:template>
  <xsl:template match="widgetSections/widgetSection">
    <div class="row">
      <xsl:apply-templates select="widgetColumns/widgetColumn" />
    </div>
  </xsl:template>
  <xsl:template match="widgetColumns/widgetColumn">
    <div class="col-lg-{@colWidth} col-xs-12">      
      <xsl:apply-templates select="widget[@type='smallBox']" />
      <xsl:apply-templates select="widget[@type='graphBox']" />
      <xsl:apply-templates select="widget[@type='chatBox']" />
      <xsl:apply-templates select="widget[@type='todoBox']" />
      <xsl:apply-templates select="widget[@type='emailBox']" />
      <xsl:apply-templates select="widget[@type='graphFrame']" />
      <xsl:apply-templates select="widget[@type='taskBox']" />
    </div>
  </xsl:template>

  <xsl:template match="widget[@type='smallBox']">
    <xsl:if test="contents/data/@dataId">
      <script>
        function runSmallBox<xsl:value-of select="contents/data/@dataId"/>() {
        getWidgetData('<xsl:value-of select="contents/data/@dataId"/>', function(data) {
        var msg = $(data).children().find("result").text();
        $('#data<xsl:value-of select="contents/data/@dataId"/>').html(msg);
        setTimeout(function () { runSmallBox<xsl:value-of select="contents/data/@dataId"/>(); }, 1000*60);
        }
        );
        }

        runSmallBox<xsl:value-of select="contents/data/@dataId"/>();
      </script>
    </xsl:if>
    <!-- small box -->
    <div class="small-box {@widgetBgColor}">
      <xsl:attribute name="style">
        <xsl:if test="@moreInfoURL='' or not(@moreInfoURL)">padding-bottom:25px;</xsl:if>
      </xsl:attribute>
      <div class="inner">
        <h3 id="data{contents/data/@dataId}">0</h3>
        <p>
          <xsl:value-of select="@widgetTitle" />
        </p>
      </div>
      <div class="icon">
        <ix class="{@widgetIcon}"></ix>
      </div>
      <xsl:if test="@moreInfoURL!=''">
        <a href="{@moreInfoURL}" class="small-box-footer">
          More info <span>
            <ix class="fa fa-arrow-circle-right"></ix>
          </span>
        </a>
      </xsl:if>
    </div>
  </xsl:template>

  <!--chatbox-->
  <xsl:template match="widget[@type='chatBox']">
    <div class="box box-success">
      <div class="box-header">
        <span>
          <ix class="fa fa-comments-o"></ix>
        </span>&#160;

        <h3 class="box-title">Chat</h3>

        <div class="box-tools pull-right" data-toggle="tooltip" title="Status">
          <div class="btn-group" data-toggle="btn-toggle">
            <button type="button" class="btn btn-default btn-sm active">
              <ix class="fa fa-square text-green"></ix>
            </button>
            <button type="button" class="btn btn-default btn-sm">
              <ix class="fa fa-square text-red"></ix>
            </button>
          </div>
        </div>
      </div>
      <div class="box-body chat" id="chat-box">
        <!-- chat item -->
        <div class="item">
          <img src="dist/img/user4-128x128.jpg" alt="user image" class="online"/>

          <p class="message">
            <a href="#" class="name">
              <small class="text-muted pull-right">
                <span>
                  <ix class="fa fa-clock-o"></ix>
                </span> 2:15
              </small>
              Mike Doe
            </a>
            I would like to meet you to discuss the latest news about
            the arrival of the new theme. They say it is going to be one the
            best themes on the market
          </p>
          <div class="attachment">
            <h4>Attachments:</h4>

            <p class="filename">
              Theme-thumbnail-image.jpg
            </p>

            <div class="pull-right">
              <button type="button" class="btn btn-primary btn-sm btn-flat">Open</button>
            </div>
          </div>
          <!-- /.attachment -->
        </div>
        <!-- /.item -->
        <!-- chat item -->
        <div class="item">
          <img src="dist/img/user3-128x128.jpg" alt="user image" class="offline"/>

          <p class="message">
            <a href="#" class="name">
              <small class="text-muted pull-right">
                <span>
                  <ix class="fa fa-clock-o"></ix>
                </span> 5:15
              </small>
              Alexander Pierce
            </a>
            I would like to meet you to discuss the latest news about
            the arrival of the new theme. They say it is going to be one the
            best themes on the market
          </p>
        </div>
        <!-- /.item -->
        <!-- chat item -->
        <div class="item">
          <img src="dist/img/user2-160x160.jpg" alt="user image" class="offline"/>

          <p class="message">
            <a href="#" class="name">
              <small class="text-muted pull-right">
                <span>
                  <ix class="fa fa-clock-o"></ix>
                </span> 5:30
              </small>
              Susan Doe
            </a>
            I would like to meet you to discuss the latest news about
            the arrival of the new theme. They say it is going to be one the
            best themes on the market
          </p>
        </div>
        <!-- /.item -->
      </div>
      <!-- /.chat -->
      <div class="box-footer">
        <div class="input-group">
          <input class="form-control" placeholder="Type message..."/>

          <div class="input-group-btn">
            <button type="button" class="btn btn-success">
              <ix class="fa fa-plus"></ix>
            </button>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!--todobox-->
  <xsl:template match="widget[@type='todoBox']">
    <div class="box box-primary">
      <div class="box-header">
        <span>
          <ix class="ion ion-clipboard"></ix>
        </span>&#160;

        <h3 class="box-title">To Do List</h3>

        <div class="box-tools pull-right">
          <ul class="pagination pagination-sm inline">
            <li>
              <a href="#">&#171;</a>
            </li>
            <li>
              <a href="#">1</a>
            </li>
            <li>
              <a href="#">2</a>
            </li>
            <li>
              <a href="#">3</a>
            </li>
            <li>
              <a href="#">&#187;</a>
            </li>
          </ul>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
        <ul class="todo-list">
          <li>
            <!-- drag handle -->
            <span class="handle">
              <ix class="fa fa-ellipsis-v"></ix>
              <ix class="fa fa-ellipsis-v"></ix>
            </span>
            <!-- checkbox -->
            <input type="checkbox" value=""/>
            <!-- todo text -->
            <span class="text">Design a nice theme</span>
            <!-- Emphasis label -->
            <small class="label label-danger">
              <span>
                <ix class="fa fa-clock-o"></ix>
              </span> 2 mins
            </small>
            <!-- General tools such as edit or delete-->
            <div class="tools">
              <ix class="fa fa-edit"></ix>
              <ix class="fa fa-trash-o"></ix>
            </div>
          </li>
          <li>
            <span class="handle">
              <ix class="fa fa-ellipsis-v"></ix>
              <ix class="fa fa-ellipsis-v"></ix>
            </span>
            <input type="checkbox" value=""/>
            <span class="text">Make the theme responsive</span>
            <small class="label label-info">
              <span>
                <ix class="fa fa-clock-o"></ix>
              </span> 4 hours
            </small>
            <div class="tools">
              <ix class="fa fa-edit"></ix>
              <ix class="fa fa-trash-o"></ix>
            </div>
          </li>
          <li>
            <span class="handle">
              <ix class="fa fa-ellipsis-v"></ix>
              <ix class="fa fa-ellipsis-v"></ix>
            </span>
            <input type="checkbox" value=""/>
            <span class="text">Let theme shine like a star</span>
            <small class="label label-warning">
              <span>
                <ix class="fa fa-clock-o"></ix>
              </span> 1 day
            </small>
            <div class="tools">
              <ix class="fa fa-edit"></ix>
              <ix class="fa fa-trash-o"></ix>
            </div>
          </li>
          <li>
            <span class="handle">
              <ix class="fa fa-ellipsis-v"></ix>
              <ix class="fa fa-ellipsis-v"></ix>
            </span>
            <input type="checkbox" value=""/>
            <span class="text">Let theme shine like a star</span>
            <small class="label label-success">
              <span>
                <ix class="fa fa-clock-o"></ix>
              </span> 3 days
            </small>
            <div class="tools">
              <ix class="fa fa-edit"></ix>
              <ix class="fa fa-trash-o"></ix>
            </div>
          </li>
          <li>
            <span class="handle">
              <ix class="fa fa-ellipsis-v"></ix>
              <ix class="fa fa-ellipsis-v"></ix>
            </span>
            <input type="checkbox" value=""/>
            <span class="text">Check your messages and notifications</span>
            <small class="label label-primary">
              <span>
                <ix class="fa fa-clock-o"></ix>
              </span> 1 week
            </small>
            <div class="tools">
              <ix class="fa fa-edit"></ix>
              <ix class="fa fa-trash-o"></ix>
            </div>
          </li>
          <li>
            <span class="handle">
              <ix class="fa fa-ellipsis-v"></ix>
              <ix class="fa fa-ellipsis-v"></ix>
            </span>
            <input type="checkbox" value=""/>
            <span class="text">Let theme shine like a star</span>
            <small class="label label-default">
              <span>
                <ix class="fa fa-clock-o"></ix>
              </span> 1 month
            </small>
            <div class="tools">
              <ix class="fa fa-edit"></ix>
              <ix class="fa fa-trash-o"></ix>
            </div>
          </li>
        </ul>
      </div>
      <!-- /.box-body -->
      <div class="box-footer clearfix no-border">
        <button type="button" class="btn btn-default pull-right">
          <span>
            <ix class="fa fa-plus"></ix>
          </span> Add item
        </button>
      </div>
    </div>
  </xsl:template>

  <!--emailbox-->
  <xsl:template match="widget[@type='emailBox']">
    <div class="box box-info">
      <div class="box-header">
        <span>
          <ix class="fa fa-envelope"></ix>
        </span>&#160;

        <h3 class="box-title">Quick Email</h3>
        <!-- tools box -->
        <div class="pull-right box-tools">
          <button type="button" class="btn btn-info btn-sm" data-widget="remove" data-toggle="tooltip"
                  title="Remove">
            <ix class="fa fa-times"></ix>
          </button>
        </div>
        <!-- /. tools -->
      </div>
      <div class="box-body">
        <form action="#" method="post">
          <div class="form-group">
            <input type="email" class="form-control" name="emailto" placeholder="Email to:"/>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" name="subject" placeholder="Subject"/>
          </div>
          <div>
            <textarea class="textarea" placeholder="Message"
                      style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">&#160;</textarea>
            <script>$('.textarea').val('');</script>
          </div>
        </form>
      </div>
      <div class="box-footer clearfix">
        <button type="button" class="pull-right btn btn-default" id="sendEmail">
          Send
          <ix class="fa fa-arrow-circle-right"></ix>
        </button>
      </div>
    </div>
  </xsl:template>

  <!--graphframe-->
  <xsl:template match="widget[@type='graphFrame']">
    <div class="box box-solid bg-teal-gradient">
      <div class="box-header">
        <span>
          <ix class="fa fa-th"></ix>
        </span>&#160;
        <h3 class="box-title">Sales Graph</h3>

        <div class="box-tools pull-right">
          <button type="button" class="btn bg-teal btn-sm" data-widget="collapse">
            <ix class="fa fa-minus"></ix>
          </button>
          <button type="button" class="btn bg-teal btn-sm" data-widget="remove">
            <ix class="fa fa-times"></ix>
          </button>
        </div>
      </div>
      <div class="box-body border-radius-none">
        <div class="chart" id="line-chart" style="height: 250px;">&#160;</div>
      </div>
      <!-- /.box-body -->
      <div class="box-footer no-border">
        <div class="row">
          <div class="col-xs-4 text-center" style="border-right: 1px solid #f4f4f4">
            <input type="text" class="knob" data-readonly="true" value="20" data-width="60" data-height="60"
                   data-fgColor="#39CCCC"/>

            <div class="knob-label">Mail-Orders</div>
          </div>
          <!-- ./col -->
          <div class="col-xs-4 text-center" style="border-right: 1px solid #f4f4f4">
            <input type="text" class="knob" data-readonly="true" value="50" data-width="60" data-height="60"
                   data-fgColor="#39CCCC"/>

            <div class="knob-label">Online</div>
          </div>
          <!-- ./col -->
          <div class="col-xs-4 text-center">
            <input type="text" class="knob" data-readonly="true" value="30" data-width="60" data-height="60"
                   data-fgColor="#39CCCC"/>

            <div class="knob-label">In-Store</div>
          </div>
          <!-- ./col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.box-footer -->
    </div>
  </xsl:template>

  <!--taskbox-->
  <xsl:template match="widget[@type='taskBox']">
    <div class="box box-solid bg-green-gradient">
      <div class="box-header">
        <span>
          <ix class="fa fa-calendar"></ix>
        </span>&#160;

        <h3 class="box-title">Calendar</h3>
        <!-- tools box -->
        <div class="pull-right box-tools">
          <!-- button with a dropdown -->
          <div class="btn-group">
            <button type="button" class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown">
              <ix class="fa fa-bars"></ix>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
              <li>
                <a href="#">Add new event</a>
              </li>
              <li>
                <a href="#">Clear events</a>
              </li>
              <li class="divider"></li>
              <li>
                <a href="#">View calendar</a>
              </li>
            </ul>
          </div>&#160;
          <button type="button" class="btn btn-success btn-sm" data-widget="collapse">
            <ix class="fa fa-minus"></ix>
          </button>&#160;
          <button type="button" class="btn btn-success btn-sm" data-widget="remove">
            <ix class="fa fa-times"></ix>
          </button>
        </div>
        <!-- /. tools -->
      </div>
      <!-- /.box-header -->
      <div class="box-body no-padding">
        <!--The calendar -->
        <div id="calendar" style="width: 100%">&#160;</div>
      </div>
      <!-- /.box-body -->
      <div class="box-footer text-black">
        <div class="row">
          <div class="col-sm-6">
            <!-- Progress bars -->
            <div class="clearfix">
              <span class="pull-left">Task #1</span>
              <small class="pull-right">90%</small>
            </div>
            <div class="progress xs">
              <div class="progress-bar progress-bar-green" style="width: 90%;">&#160;</div>
            </div>

            <div class="clearfix">
              <span class="pull-left">Task #2</span>
              <small class="pull-right">70%</small>
            </div>
            <div class="progress xs">
              <div class="progress-bar progress-bar-green" style="width: 70%;">&#160;</div>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-sm-6">
            <div class="clearfix">
              <span class="pull-left">Task #3</span>
              <small class="pull-right">60%</small>
            </div>
            <div class="progress xs">
              <div class="progress-bar progress-bar-green" style="width: 60%;">&#160;</div>
            </div>

            <div class="clearfix">
              <span class="pull-left">Task #4</span>
              <small class="pull-right">40%</small>
            </div>
            <div class="progress xs">
              <div class="progress-bar progress-bar-green" style="width: 40%;">&#160;</div>
            </div>
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
    </div>
  </xsl:template>

  <!--graphbox-->
  <xsl:template match="widget[@type='graphBox']">
    <xsl:variable name="firstTab">
      <xsl:value-of select="contents/data/@dataNo"/>
    </xsl:variable>
    
    <div class="nav-tabs-custom">
      <!-- Tabs within a box -->
      <ul class="nav nav-tabs pull-right">
        <xsl:for-each select="contents/data">
          <li>
            <xsl:if test="@dataNo=$firstTab">
              <xsl:attribute name="class">active</xsl:attribute>
            </xsl:if>
            <a href="#chart{@dataNo}" data-toggle="tab">
              <xsl:value-of select="@dataCaption" />
            </a>
          </li>
        </xsl:for-each>

        <li class="pull-left header">
          <span>
            <ix class="fa fa-inbox"></ix>
          </span>&#160;<xsl:value-of select="@widgetTitle"/>
        </li>
      </ul>
      <div class="tab-content">
        <xsl:for-each select="contents/data">
          <div class="chart tab-pane" id="chart{@dataNo}">
            <xsl:if test="@dataNo=$firstTab">
              <xsl:attribute name="class">active</xsl:attribute>
            </xsl:if>
            <canvas id="chart{@dataCaption}" style="height:250px"></canvas>
          </div>
          <xsl:if test="@dataId">
            <script>
              function runGraphBox<xsl:value-of select="@dataId"/>() {
              getWidgetData('<xsl:value-of select="@dataId"/>', function(data) {
              var ctype= $(data).children().children().find("type").text();
              var label = JSON.parse($(data).children().children().find("label").text());

              var dsstr= $(data).children().children().find("dataset").text();
              //var dsver=JSON.stringify(dsstr);
              var ds=JSON.parse(dsstr);
              
              chart='chart<xsl:value-of select="@dataCaption" />';
              drawChart(chart, ctype, label, ds);
              
              setTimeout(function () { runGraphBox<xsl:value-of select="@dataId"/>(); }, 1000*60);
              }
              );
              }

              runGraphBox<xsl:value-of select="@dataId"/>();
            </script>
          </xsl:if>
        </xsl:for-each>

      </div>
    </div>
    <!--<script>

      var ctx = document.getElementById("myChart").getContext('2d');
      var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
      labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
      datasets: [{
      label: '# of Votes',
      data: [12, 19, 3, 5, 2, 23],
      backgroundColor: [
      'rgba(255, 99, 132, 0.2)',
      'rgba(54, 162, 235, 0.2)',
      'rgba(255, 206, 86, 0.2)',
      'rgba(75, 192, 192, 0.2)',
      'rgba(153, 102, 255, 0.2)',
      'rgba(255, 159, 64, 0.2)'
      ],
      borderColor: [
      'rgba(255,99,132,1)',
      'rgba(54, 162, 235, 1)',
      'rgba(255, 206, 86, 1)',
      'rgba(75, 192, 192, 1)',
      'rgba(153, 102, 255, 1)',
      'rgba(255, 159, 64, 1)'
      ],
      borderWidth: 1
      }]
      },
      options: {
      scales: {
      yAxes: [{
      ticks: {
      beginAtZero:true
      }
      }]
      }
      }
      });


      var ctx = document.getElementById('myChart2').getContext('2d');
      var chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'bar',

      // The data for our dataset
      data: {
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [{
      label: "My First dataset",
      backgroundColor: 'rgb(255, 99, 132)',
      borderColor: 'rgb(255, 99, 132)',
      data: [0, 10, 5, 2, 20, 30, 5],
      }]
      },

      // Configuration options go here
      options: {
      scales: {
      yAxes: [{
      ticks: {
      beginAtZero:true
      }
      }]
      }
      }
      });
    </script>-->
  </xsl:template>


</xsl:stylesheet>
