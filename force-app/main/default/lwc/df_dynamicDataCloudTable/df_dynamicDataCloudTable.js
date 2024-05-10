import { LightningElement, api } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
//import d3js from '@salesforce/resourceUrl/d3minified'


const dataset = [
    {date : new Date( '2023-01-01'), value: 200},
    {date : new Date( '2023-02-01'), value: 250},
    {date : new Date( '2023-03-01'), value: 180},
    {date : new Date( '2023-04-01'), value: 300},
    {date : new Date( '2023-05-01'), value: 60},
    {date : new Date( '2023-06-01'), value: 450},
    {date : new Date( '2023-07-01'), value: 280},
    {date : new Date( '2023-08-01'), value: 600},
    {date : new Date( '2023-09-01'), value: 780},
    {date : new Date( '2023-10-01'), value: 320},
    {date : new Date( '2023-11-01'), value: 400},
    {date : new Date( '2023-12-01'), value: 200}
];

export default class Df_dynamicDataCloudTable extends LightningElement {

    datacloudtable = null;

    margin = null;
    width = null;
    height = null;

    

    renderedCallback(){

        //Set dimensions and margins for the chart (1)
        this.margin = { top: 70, right: 30, bottom: 40, left: 80 };
        this.width = 1200 - this.margin.left - this.margin.right;
        this.height = 500 - this.margin.top - this.margin.bottom;

        Promise.all([loadScript(this,d3js)])
            .then(()=>{

                // const x = d3.scaleTime()
                //     .range([0, this.width]);
                
                // const y = d3.scaleLinear()
                //     .domain([0,100])
                //     .range([this.height, this.margin.top]);
                
                
                // console.log('[this.template.querySelector("div.datacloudtable")]:'+this.template.querySelector('div.datacloudtable'));

                // this.datacloudtable = d3.select(this.template.querySelector('div.datacloudtable'))
                //     .append('svg')
                //         .attr('width', this.width)
                //         .attr('height', this.height)
                //     .append('g')
                //         .attr('transform', `translate(0,${this.height - this.margin.bottom})`)
                //         .call(d3.axisBottom(x));
                //     //alert('[this.datacloudtable 3]:'+this.datacloudtable);
                
                // this.datacloudtable.append('g')
                //     .attr('transform', `translate(${this.margin.left},0)`)
                //     .call(d3.axisLeft(y));
                    

                // //Set up the x and y scales (2)
                // const x = d3.scaleTime()
                //     .range([0, this.width]);

                // const y = d3.scaleLinear()
                //     .range([this.height, 0]);

                //     this.datacloudtable =  d3.select(
                //         this.template.querySelector('div.datacloudtable'))
                //             .create('svg');
                // //Create the SVG element and append it to the chart container (3)
                // this.datacloudtable
                //         .attr('width', this.width + this.margin.left + this.margin.right)
                //         .attr('height', this.height + this.margin.top + this.margin.bottom)
                //         .append('g')
                //             .att('transform', `translate(${this.margin.left},${this.margin.top})`);
                
                

                // //define the x and y domains
                // x.domain(d3.extent(dataset, d => d.date));
                // y.domain([0, d3.max(dataset, d => d.value)]);

                // //add the x-axis
                // this.datacloudtable.append('g')
                //     .attr('transform', `translate(0, ${this.height})`)
                //     .call(d3.axisBottom(x)
                //         .ticks(d3.timeMonth.every(1))
                //         .tickFormat(d3.timeFormat('%b %Y')));

                // // add the y-axis
                // this.datacloudtable.append('g')
                //     .call(d3.axisLeft(y));

                // const line = d3.line()
                //     .x( d => x(d.date))
                //     .y( d => y(d.value));

                // this.datacloudtable.append('path')
                //     .datum(dataset)
                //     .attr('fill', 'none')
                //     .attr('stroke', 'steelblue')
                //     .attr('stroke-width', 1)
                //     .attr('d', line);

                // this.datacloudtable.redraw();

            });
    }

    


}