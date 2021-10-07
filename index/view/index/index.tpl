{include file="../header.tpl"}
    <div class="content-wrapper">
        <div class="row gutters">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                <div class="field-wrapper">
                    <div class="field-wrapper">
                        <select class="select-single" title="项目分类" data-live-search="true" name="project_id" id="project_id">
                            <option value="0">全部项目</option>
                            {foreach from=$project_classification item=vo}
                                <option value="{$vo.id}">{$vo.title}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>        
        </div>
        <div class="row gutters">
            <div class="col-xl-6 col-lg-4 col-md-4 col-sm-6 col-12">
                <div class="stats-tile">
                    <div class="sale-icon">
                        <i class="icon-shopping-bag1"></i>
                    </div>
                    <div class="sale-details">
                        <h2 id="loophole_num">{$loophole_num}</h2>
                        <p>漏洞量</p>
                    </div>
                    <div class="sale-graph">
                        <div id="sparklineLine2"></div>
                    </div>
                </div>
            </div>
            <div class="col-xl-6 col-lg-4 col-md-4 col-sm-12 col-12">
                <div class="stats-tile">
                    <div class="sale-icon">
                        <i class="icon-check-circle"></i>
                    </div>
                    <div class="sale-details">
                        <h2 id="repair_num">{$repair_num}</h2>
                        <p>修复量</p>
                    </div>
                    <div class="sale-graph">
                        <div id="sparklineLine3"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row gutters">  
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                <div class="card h-350">
                    <div class="card-header">
                        <div class="card-title">安全人员提交漏洞统计图</div>
                    </div>
                    <div class="card-body">
                        <div id="byUser"></div>
                    </div>
                </div>
            </div>
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                <div class="card h-350">
                    <div class="card-header">
                        <div class="card-title">Top10漏洞统计图</div>
                    </div>
                    <div class="card-body">
                        <div id="byTop"></div>
                    </div>
                </div>
            </div> 
        </div>  
        <!-- <div class="row gutters">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 cool-12">

                <div class="card">
                    <div class="card-body">
                        <div class="row gutters">                                           
                            <div class="col-xl-3 col-lg-3 col-md-4 col-sm-4 col-12">
                                <div class="reports-summary">
                                    <div class="reports-summary-block">
                                        <h5>提交漏洞数</h5>
                                        <h6>本月总漏洞数</h6>
                                    </div>
                                    <div class="reports-summary-block">
                                        <h5>35 个</h5>
                                        <h6>提交漏洞数</h6>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-9 col-lg-9 col-md-8 col-sm-8 col-12">
                                <div class="row gutters">
                                    <div class="col-12">
                                        <div class="graph-day-selection mt-2" role="group">
                                            <button type="button" class="btn active">今天</button>
                                            <button type="button" class="btn">昨天</button>
                                            <button type="button" class="btn">7 天</button>
                                            <button type="button" class="btn">15 天</button>
                                            <button type="button" class="btn">30 天</button>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div id="salesGraph" class="chart-height-xl"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div> -->
    </div>
    <script src="./public/index/vendor/apex/apexcharts.min.js"></script>
    <!-- <script src="./public/index/vendor/apex/custom/home/salesGraph.js"></script> -->
    <script>
        var byUser,byTop;
        // 安全人员提交漏洞统计图
        var byUser_options = {
            chart: {
                height: 310,
                type: 'donut',
            },
            labels: {$new_user_labels},
            series: {$new_user_series},
            legend: {
                position: 'bottom',
            },
            dataLabels: {
                enabled: false
            },
            stroke: {
                width: 8,
                colors: ['#ffffff'],
            },
            tooltip: {
                y: {
                    formatter: function(val) {
                        return  val+"个"
                    }
                }
            },
        }
        var byUser = new ApexCharts(
            document.querySelector("#byUser"),
            byUser_options
        );
        byUser.render();

        // Top10漏洞统计图
        var byTop_options = {
            chart: {
                height: 310,
                type: 'donut',
            },
            labels: {$new_top_labels},
            series: {$new_top_series},
            legend: {
                position: 'bottom',
            },
            dataLabels: {
                enabled: false
            },
            stroke: {
                width: 8,
                colors: ['#ffffff'],
            },
            tooltip: {
                y: {
                    formatter: function(val) {
                        return  val+"个"
                    }
                }
            },
        }
        var byTop = new ApexCharts(
            document.querySelector("#byTop"),
            byTop_options
        );
        byTop.render();

        $("#project_id").change(function(){
            var selected = $(this).children('option:selected').val();
            $.post("{$menu['home']}",{
                project_id:selected, 
            },function(data){
                $("#loophole_num").html(data.loophole_num)
                $("#repair_num").html(data.repair_num)
                byUser_options['labels'] = data.new_user_labels
                byUser_options['series'] = data.new_user_series
                byUser.updateOptions(byUser_options)
                byTop_options['labels'] = data.new_top_labels
                byTop_options['series'] = data.new_top_series
                byTop.updateOptions(byTop_options)
            },"json")
        });
    </script>
{include file="../footer.tpl"}