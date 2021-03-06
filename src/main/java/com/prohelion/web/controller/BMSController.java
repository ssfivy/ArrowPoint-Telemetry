package com.prohelion.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.prohelion.model.MeasurementData;
import com.prohelion.service.MeasurementDataService;

@Controller
@RequestMapping(value = "/")
@Transactional(readOnly = true)
public class BMSController extends AbstractController {
    
    private Integer cellDataBaseIdx = 0x602;
    
    @Autowired
    private MeasurementDataService measurementDataService;

    public BMSController() {
        
    }
    
    @RequestMapping(value = { "/bms.html" }, method = RequestMethod.GET)
    public String getBMSDashboard(Model model) {
        model.addAttribute("devices", getDevices());
        return "bms";
    }
    
    @RequestMapping(value = { "/bms.json" }, method = RequestMethod.GET, params = { "canId" })
    public @ResponseBody List<MeasurementData> getBMSCanData(@RequestParam(required = true) Integer canId)
    {
    	return measurementDataService.findLatestDataForCanId(canId);

    }
    
    @RequestMapping(value = { "/cmu.json" }, method = RequestMethod.GET)
    public @ResponseBody List<MeasurementData> getCmuData(@RequestParam(required = true) Integer cmuIdx) {
        List<MeasurementData> cmuData = new ArrayList<MeasurementData>();
        
        int basis = cellDataBaseIdx + (3 * cmuIdx);
        
        for (int i = 0; i < 2; i++) {
            cmuData.addAll(measurementDataService.findLatestDataForCanId(basis + i));
        }
        
        return cmuData;
    }
}
