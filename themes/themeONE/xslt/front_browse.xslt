<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">

    <!-- Content Header (Page header) -->
    <section class="content-header visible-phone">
      <h1>
        DASHBOARD
        <!-- <small>Control panel</small> -->
      </h1>
      <ol class="breadcrumb">
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <section class="content">
      <!-- Main content -->
      <div class="row">
        <div class="col-md-6 full-width-a">
          <div class="box box-default box-warning box-solid" style="border:none;">
            <div class="box-header with-border border-bottom-blue-a" style="background:none; border-bottom: solid 3px #dddddd;">
              <h3 class="dashboard-title">MY PENDING TASK</h3>

              <div class="box-tools pull-right ">
                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                  <ix class="fa fa-minus"></ix>
                </button>
              </div>
              <!-- /.box-tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body" style="background:#ededed; text-align:center;">
              <ul class="pending-task">
                <li>
                  <a href="">
                    INVENTORY
                  </a>
                  <ul class="pending-task-module">
                    <li>
                      <a href="">
                        <b>Product Adjustment </b> Draft (3) On Approval (0)
                      </a>
                    </li>
                    <li>
                      <a href="">
                        <b>Product Request </b> Draft  (0) On Approval (10)
                      </a>
                    </li>
                  </ul>
                </li>
                <li>
                  <a href="">
                    HRD
                  </a>
                  <ul class="pending-task-module">
                    <li>
                      <a href="">
                        <b>Recruitment Request </b> Draft (1) On Approval (0)
                      </a>
                    </li>
                    <li>
                      <a href="">
                        <b>Training</b> Draft (0) On Approval (10)
                      </a>
                    </li>
                  </ul>
                </li>
              </ul>

            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        <div class="col-md-6 full-width-a">
          <div class="row">
            <div class="col-md-12">
              <div class="box box-default box-warning box-solid" style="border:none;">
                <div class="box-header with-border" style="background:none; border-bottom: solid 3px #dddddd">
                  <h3 class="dashboard-title">MY FAVOURITES</h3>

                  <div class="box-tools pull-right ">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                      <ix class="fa fa-minus"></ix>
                    </button>
                  </div>
                  <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body" style="background:#ededed; min-height:200px;">
                  <ul class="new-doc">
                    <li>
                      <a href="index.aspx?code=DUMY" style="">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
                        <h5 class="new-doc-h5">
                          HR<br />CR
                        </h5>
                        <p class="new-doc-p">recruitment</p>
                      </a>
                    </li>
                    <li>
                      <a href="index.aspx?code=DUMY">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
                        <h5 class="new-doc-h5">
                          HR<br />CH
                        </h5>
                        <p class="new-doc-p">change status</p>
                      </a>
                    </li>
                    <li>
                      <a href="index.aspx?code=DUMY">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
                        <h5 class="new-doc-h5">
                          HR<br />TR
                        </h5>
                        <p class="new-doc-p">training request</p>
                      </a>
                    </li>
                    <div style="clear:both"></div>
                  </ul>
                </div>
                <!-- /.box-body -->
              </div>
            </div>
            <div class="col-md-12">
              <div class="box box-default box-warning box-solid" style="border:none;">
                <div class="box-header with-border" style="background:none; border-bottom: solid 3px #dddddd">
                  <h3 class="dashboard-title">MY REPORTS</h3>

                  <div class="box-tools pull-right ">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                      <ix class="fa fa-minus"></ix>
                    </button>
                  </div>
                  <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body" style="background:#ededed; min-height:200px;">
                  <ul class="new-doc">
                    <li>
                      <a href="">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/report.png" />
                        <p class="new-doc-p">report 1</p>
                      </a>
                    </li>
                    <li>
                      <a href="">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/report.png" />
                        <p class="new-doc-p">report 2</p>
                      </a>
                    </li>
                    <li>
                      <a href="">
                        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/report.png" />
                        <p class="new-doc-p">report 3</p>
                      </a>
                    </li>
                    <div style="clear:both"></div>
                  </ul>
                </div>
                <!-- /.box-body -->
              </div>
              <!-- /.box -->
            </div>
          </div>

          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
    </section>
  </xsl:template>




</xsl:stylesheet>
