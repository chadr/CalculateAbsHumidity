CalculateAbsHumidity <- function (relative.humidity, temp, fahrenheit = FALSE, percent = FALSE) {
  # Computes absolute humidity from relative humidity and temperature.
  #  Based on the August-Roche-Magnus approximation.
  #  Considered valid when: 0 < temperature < 60 degrees celsius
  #                         1% < relative humidity < 100%
  #                         0 < dewpoint < 50 degrees celsius
  #
  # Args:
  #   relative.humidity: The relative humidity value to be converted.
  #   temp: Temperature associated with given relative humidity value in fahrenheit or celsius.
  #   fahrenheit: Is the given temperature in fahrenheit or celsius? Default is celsius.
  #   percent: Is the given relative humidity in percent or decimal form? Default is decimal.
  #            For example: Decimal 0.10, Percent 10
  #
  # Returns:
  #   The absolute humidity in cubic grams of water.
  #
  # Todo: Check input for validity bounds outlined above.
  # 
  # Reference: http://en.wikipedia.org/wiki/Clausius%E2%80%93Clapeyron_relation#Meteorology_and_climatology
  
  # Saturated vapor pressure in millibars
  kSVP <- 6.112
  # Molecular weight of water in g/mol
  kMolecularWeight <- 18.01528
  # Alduchov-Eskeridge coefficients
  kA <- 17.625
  kB <- 243.05

  if (percent) {
    relative.humidity <- (relative.humidity / 100)
  }
  
  if (fahrenheit) {
    temp.celsius <- (temp - 32) / 1.8000
  } else {
    temp.celsius <- temp
  }

  temp.kelvin <- temp.celsius + 273.15  
  	
  pressure <- kSVP * exp((kA * temp.celsius) / (temp.celsius + kB)) * relative.humidity
  mols.water.vapor <- pressure / (temp.kelvin * 0.08314)
  cubic.grams.water <- mols.water.vapor * kMolecularWeight

  return(cubic.grams.water)
}