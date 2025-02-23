Class {
	#name : #DataFrameStatsTest,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : #'DataFrame-Tests-Core'
}

{ #category : #running }
DataFrameStatsTest >> setUp [

	super setUp.

	df := DataFrame withRows:
		      #( #( 7.1 3.5 1.4 0.2 ) #( 4.9 3 1.4 0.2 ) #( 4.7 3.2 1.3 0.2 ) #( 7 3.2 4.7 1.4 ) #( 6.4 3.2 4.5 1.5 ) #( 6.9 3.1 4.9 1.5 ) #( 6.3 3.3 6 2.5 )
		         #( 5.8 2.7 5.1 1.9 ) #( 7.1 3 5.9 2.1 ) ).

	df columnNames: #( sepalLength sepalWidth petalLength petalWidth )
]

{ #category : #tests }
DataFrameStatsTest >> testAverage [

	| expected actual |

	expected := { 6.244444 . 3.133333 . 3.911111 . 1.277778 } asDataSeries.
	expected name: #average.
	expected keys: df columnNames.

	actual := df average.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DataFrameStatsTest >> testAverageWithNils [

	| expected actual |
	df := DataFrame withRows: #( #( 1 1 ) #( 2 nil ) #( nil 3 ) #( 4 4 ) ).
	df columnNames: #( dogs cats ).

	expected := {
		            (7 / 3).
		            (8 / 3) } asDataSeries.
	expected name: #average.
	expected keys: df columnNames.

	actual := df average.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DataFrameStatsTest >> testCorrelationMatrix [

	| expectedCorrelationMatrix actualCorrelationMatrix |
	expectedCorrelationMatrix := DataFrame withRows:
		                             #( #( 1 0.311398 0.538922 0.454601 ) #( 0.311398 1 -0.321281 -0.308023 ) #( 0.538922 -0.321281 1 0.982956 )
		                                #( 0.454601 -0.308023 0.982956 1 ) ).
	expectedCorrelationMatrix columnNames: #( sepalLength sepalWidth petalLength petalWidth ).
	expectedCorrelationMatrix rowNames: #( sepalLength sepalWidth petalLength petalWidth ).
	actualCorrelationMatrix := df correlationMatrix.
	self assert: actualCorrelationMatrix rowNames equals: expectedCorrelationMatrix rowNames.
	self assert: actualCorrelationMatrix columnNames equals: expectedCorrelationMatrix columnNames.

	1 to: actualCorrelationMatrix numberOfColumns do: [ :j |
		1 to: actualCorrelationMatrix numberOfRows do: [ :i | self assert: (actualCorrelationMatrix at: i at: j) closeTo: (expectedCorrelationMatrix at: i at: j) ] ]
]

{ #category : #tests }
DataFrameStatsTest >> testCorrelationMatrixWithNils [

	| expectedCorrelationMatrix actualCorrelationMatrix |
	df := DataFrame withRows: #( #( 1 1 ) #( 2 nil ) #( nil 3 ) #( 4 4 ) ).
	df columnNames: #( dogs cats ).

	expectedCorrelationMatrix := DataFrame withRows: #( #( 1 0.4174555390689118 ) #( 0.4174555390689118 1 ) ).
	expectedCorrelationMatrix columnNames: #( dogs cats ).
	expectedCorrelationMatrix rowNames: #( dogs cats ).

	actualCorrelationMatrix := df correlationMatrix.

	self assert: actualCorrelationMatrix rowNames equals: expectedCorrelationMatrix rowNames.
	self assert: actualCorrelationMatrix columnNames equals: expectedCorrelationMatrix columnNames.

	1 to: actualCorrelationMatrix numberOfColumns do: [ :j |
		1 to: actualCorrelationMatrix numberOfRows do: [ :i | self assert: (actualCorrelationMatrix at: i at: j) closeTo: (expectedCorrelationMatrix at: i at: j) ] ]
]

{ #category : #tests }
DataFrameStatsTest >> testFirstQuartile [

	| expected actual |

	expected := { 5.8 . 3 . 1.4 . 0.2 } asDataSeries.
	expected name: #firstQuartile.
	expected keys: df columnNames.

	actual := df firstQuartile.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameStatsTest >> testInterquartileRange [

	| expected actual |

	expected := { 1.2 . 0.2 . 3.7 . 1.7 } asDataSeries.
	expected name: #interquartileRange.
	expected keys: df columnNames.

	actual := df interquartileRange.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DataFrameStatsTest >> testMax [

	| expected actual |

	expected := { 7.1 . 3.5 . 6 . 2.5 } asDataSeries.
	expected name: #max.
	expected keys: df columnNames.

	actual := df max.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameStatsTest >> testMedian [

	| expected actual |

	expected := { 6.4 . 3.2 . 4.7 . 1.5 } asDataSeries.
	expected name: #median.
	expected keys: df columnNames.

	actual := df median.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameStatsTest >> testMin [

	| expected actual |

	expected := { 4.7 . 2.7 . 1.3 . 0.2 } asDataSeries.
	expected name: #min.
	expected keys: df columnNames.

	actual := df min.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameStatsTest >> testMode [

	| expected actual |

	expected := { 7.1 . 3.2 . 1.4 . 0.2 } asDataSeries.
	expected name: #mode.
	expected keys: df columnNames.

	actual := df mode.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameStatsTest >> testRange [

	| expected actual |

	expected := { 2.4 . 0.8 . 4.7 . 2.3 } asDataSeries.
	expected name: #range.
	expected keys: df columnNames.

	actual := df range.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DataFrameStatsTest >> testStdev [

	| expected actual |

	expected := { 0.927512 . 0.223607 . 1.971956 . 0.877180 } asDataSeries.

	expected name: #stdev.
	expected keys: df columnNames.

	actual := df stdev.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DataFrameStatsTest >> testThirdQuartile [

	| expected actual |

	expected := { 7 . 3.2 . 5.1 . 1.9 } asDataSeries.
	expected name: #thirdQuartile.
	expected keys: df columnNames.

	actual := df thirdQuartile.
	self assert: actual equals: expected
]

{ #category : #tests }
DataFrameStatsTest >> testVariance [

	| expected actual |

	expected := { 0.860278 . 0.050000 . 3.888611 . 0.769444 } asDataSeries.
	expected name: #variance.
	expected keys: df columnNames.

	actual := df variance.
	self assert: actual closeTo: expected
]
