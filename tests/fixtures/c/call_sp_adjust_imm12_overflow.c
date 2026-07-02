/* Call-site SP adjustments must cover an outgoing-argument area past
   the 12-bit add/sub immediate: 261 by-value 16-byte structs leave 257
   on the AAPCS64 stack (257 * 16 = 4112 bytes), and the indirect call
   pushes 260 scalar arguments at the 16-byte stride (4160 bytes).
   Both calls run direct and through a function pointer. */
struct pair {
    long a;
    long b;
};

static struct pair g[261];

static long sum_pairs(
    struct pair p0, struct pair p1, struct pair p2, struct pair p3, struct pair p4, struct pair p5,
    struct pair p6, struct pair p7, struct pair p8, struct pair p9, struct pair p10, struct pair p11,
    struct pair p12, struct pair p13, struct pair p14, struct pair p15, struct pair p16, struct pair p17,
    struct pair p18, struct pair p19, struct pair p20, struct pair p21, struct pair p22, struct pair p23,
    struct pair p24, struct pair p25, struct pair p26, struct pair p27, struct pair p28, struct pair p29,
    struct pair p30, struct pair p31, struct pair p32, struct pair p33, struct pair p34, struct pair p35,
    struct pair p36, struct pair p37, struct pair p38, struct pair p39, struct pair p40, struct pair p41,
    struct pair p42, struct pair p43, struct pair p44, struct pair p45, struct pair p46, struct pair p47,
    struct pair p48, struct pair p49, struct pair p50, struct pair p51, struct pair p52, struct pair p53,
    struct pair p54, struct pair p55, struct pair p56, struct pair p57, struct pair p58, struct pair p59,
    struct pair p60, struct pair p61, struct pair p62, struct pair p63, struct pair p64, struct pair p65,
    struct pair p66, struct pair p67, struct pair p68, struct pair p69, struct pair p70, struct pair p71,
    struct pair p72, struct pair p73, struct pair p74, struct pair p75, struct pair p76, struct pair p77,
    struct pair p78, struct pair p79, struct pair p80, struct pair p81, struct pair p82, struct pair p83,
    struct pair p84, struct pair p85, struct pair p86, struct pair p87, struct pair p88, struct pair p89,
    struct pair p90, struct pair p91, struct pair p92, struct pair p93, struct pair p94, struct pair p95,
    struct pair p96, struct pair p97, struct pair p98, struct pair p99, struct pair p100, struct pair p101,
    struct pair p102, struct pair p103, struct pair p104, struct pair p105, struct pair p106, struct pair p107,
    struct pair p108, struct pair p109, struct pair p110, struct pair p111, struct pair p112, struct pair p113,
    struct pair p114, struct pair p115, struct pair p116, struct pair p117, struct pair p118, struct pair p119,
    struct pair p120, struct pair p121, struct pair p122, struct pair p123, struct pair p124, struct pair p125,
    struct pair p126, struct pair p127, struct pair p128, struct pair p129, struct pair p130, struct pair p131,
    struct pair p132, struct pair p133, struct pair p134, struct pair p135, struct pair p136, struct pair p137,
    struct pair p138, struct pair p139, struct pair p140, struct pair p141, struct pair p142, struct pair p143,
    struct pair p144, struct pair p145, struct pair p146, struct pair p147, struct pair p148, struct pair p149,
    struct pair p150, struct pair p151, struct pair p152, struct pair p153, struct pair p154, struct pair p155,
    struct pair p156, struct pair p157, struct pair p158, struct pair p159, struct pair p160, struct pair p161,
    struct pair p162, struct pair p163, struct pair p164, struct pair p165, struct pair p166, struct pair p167,
    struct pair p168, struct pair p169, struct pair p170, struct pair p171, struct pair p172, struct pair p173,
    struct pair p174, struct pair p175, struct pair p176, struct pair p177, struct pair p178, struct pair p179,
    struct pair p180, struct pair p181, struct pair p182, struct pair p183, struct pair p184, struct pair p185,
    struct pair p186, struct pair p187, struct pair p188, struct pair p189, struct pair p190, struct pair p191,
    struct pair p192, struct pair p193, struct pair p194, struct pair p195, struct pair p196, struct pair p197,
    struct pair p198, struct pair p199, struct pair p200, struct pair p201, struct pair p202, struct pair p203,
    struct pair p204, struct pair p205, struct pair p206, struct pair p207, struct pair p208, struct pair p209,
    struct pair p210, struct pair p211, struct pair p212, struct pair p213, struct pair p214, struct pair p215,
    struct pair p216, struct pair p217, struct pair p218, struct pair p219, struct pair p220, struct pair p221,
    struct pair p222, struct pair p223, struct pair p224, struct pair p225, struct pair p226, struct pair p227,
    struct pair p228, struct pair p229, struct pair p230, struct pair p231, struct pair p232, struct pair p233,
    struct pair p234, struct pair p235, struct pair p236, struct pair p237, struct pair p238, struct pair p239,
    struct pair p240, struct pair p241, struct pair p242, struct pair p243, struct pair p244, struct pair p245,
    struct pair p246, struct pair p247, struct pair p248, struct pair p249, struct pair p250, struct pair p251,
    struct pair p252, struct pair p253, struct pair p254, struct pair p255, struct pair p256, struct pair p257,
    struct pair p258, struct pair p259, struct pair p260)
{
    long s = 0;
    s += p0.a + p0.b; s += p1.a + p1.b; s += p2.a + p2.b; s += p3.a + p3.b;
    s += p4.a + p4.b; s += p5.a + p5.b; s += p6.a + p6.b; s += p7.a + p7.b;
    s += p8.a + p8.b; s += p9.a + p9.b; s += p10.a + p10.b; s += p11.a + p11.b;
    s += p12.a + p12.b; s += p13.a + p13.b; s += p14.a + p14.b; s += p15.a + p15.b;
    s += p16.a + p16.b; s += p17.a + p17.b; s += p18.a + p18.b; s += p19.a + p19.b;
    s += p20.a + p20.b; s += p21.a + p21.b; s += p22.a + p22.b; s += p23.a + p23.b;
    s += p24.a + p24.b; s += p25.a + p25.b; s += p26.a + p26.b; s += p27.a + p27.b;
    s += p28.a + p28.b; s += p29.a + p29.b; s += p30.a + p30.b; s += p31.a + p31.b;
    s += p32.a + p32.b; s += p33.a + p33.b; s += p34.a + p34.b; s += p35.a + p35.b;
    s += p36.a + p36.b; s += p37.a + p37.b; s += p38.a + p38.b; s += p39.a + p39.b;
    s += p40.a + p40.b; s += p41.a + p41.b; s += p42.a + p42.b; s += p43.a + p43.b;
    s += p44.a + p44.b; s += p45.a + p45.b; s += p46.a + p46.b; s += p47.a + p47.b;
    s += p48.a + p48.b; s += p49.a + p49.b; s += p50.a + p50.b; s += p51.a + p51.b;
    s += p52.a + p52.b; s += p53.a + p53.b; s += p54.a + p54.b; s += p55.a + p55.b;
    s += p56.a + p56.b; s += p57.a + p57.b; s += p58.a + p58.b; s += p59.a + p59.b;
    s += p60.a + p60.b; s += p61.a + p61.b; s += p62.a + p62.b; s += p63.a + p63.b;
    s += p64.a + p64.b; s += p65.a + p65.b; s += p66.a + p66.b; s += p67.a + p67.b;
    s += p68.a + p68.b; s += p69.a + p69.b; s += p70.a + p70.b; s += p71.a + p71.b;
    s += p72.a + p72.b; s += p73.a + p73.b; s += p74.a + p74.b; s += p75.a + p75.b;
    s += p76.a + p76.b; s += p77.a + p77.b; s += p78.a + p78.b; s += p79.a + p79.b;
    s += p80.a + p80.b; s += p81.a + p81.b; s += p82.a + p82.b; s += p83.a + p83.b;
    s += p84.a + p84.b; s += p85.a + p85.b; s += p86.a + p86.b; s += p87.a + p87.b;
    s += p88.a + p88.b; s += p89.a + p89.b; s += p90.a + p90.b; s += p91.a + p91.b;
    s += p92.a + p92.b; s += p93.a + p93.b; s += p94.a + p94.b; s += p95.a + p95.b;
    s += p96.a + p96.b; s += p97.a + p97.b; s += p98.a + p98.b; s += p99.a + p99.b;
    s += p100.a + p100.b; s += p101.a + p101.b; s += p102.a + p102.b; s += p103.a + p103.b;
    s += p104.a + p104.b; s += p105.a + p105.b; s += p106.a + p106.b; s += p107.a + p107.b;
    s += p108.a + p108.b; s += p109.a + p109.b; s += p110.a + p110.b; s += p111.a + p111.b;
    s += p112.a + p112.b; s += p113.a + p113.b; s += p114.a + p114.b; s += p115.a + p115.b;
    s += p116.a + p116.b; s += p117.a + p117.b; s += p118.a + p118.b; s += p119.a + p119.b;
    s += p120.a + p120.b; s += p121.a + p121.b; s += p122.a + p122.b; s += p123.a + p123.b;
    s += p124.a + p124.b; s += p125.a + p125.b; s += p126.a + p126.b; s += p127.a + p127.b;
    s += p128.a + p128.b; s += p129.a + p129.b; s += p130.a + p130.b; s += p131.a + p131.b;
    s += p132.a + p132.b; s += p133.a + p133.b; s += p134.a + p134.b; s += p135.a + p135.b;
    s += p136.a + p136.b; s += p137.a + p137.b; s += p138.a + p138.b; s += p139.a + p139.b;
    s += p140.a + p140.b; s += p141.a + p141.b; s += p142.a + p142.b; s += p143.a + p143.b;
    s += p144.a + p144.b; s += p145.a + p145.b; s += p146.a + p146.b; s += p147.a + p147.b;
    s += p148.a + p148.b; s += p149.a + p149.b; s += p150.a + p150.b; s += p151.a + p151.b;
    s += p152.a + p152.b; s += p153.a + p153.b; s += p154.a + p154.b; s += p155.a + p155.b;
    s += p156.a + p156.b; s += p157.a + p157.b; s += p158.a + p158.b; s += p159.a + p159.b;
    s += p160.a + p160.b; s += p161.a + p161.b; s += p162.a + p162.b; s += p163.a + p163.b;
    s += p164.a + p164.b; s += p165.a + p165.b; s += p166.a + p166.b; s += p167.a + p167.b;
    s += p168.a + p168.b; s += p169.a + p169.b; s += p170.a + p170.b; s += p171.a + p171.b;
    s += p172.a + p172.b; s += p173.a + p173.b; s += p174.a + p174.b; s += p175.a + p175.b;
    s += p176.a + p176.b; s += p177.a + p177.b; s += p178.a + p178.b; s += p179.a + p179.b;
    s += p180.a + p180.b; s += p181.a + p181.b; s += p182.a + p182.b; s += p183.a + p183.b;
    s += p184.a + p184.b; s += p185.a + p185.b; s += p186.a + p186.b; s += p187.a + p187.b;
    s += p188.a + p188.b; s += p189.a + p189.b; s += p190.a + p190.b; s += p191.a + p191.b;
    s += p192.a + p192.b; s += p193.a + p193.b; s += p194.a + p194.b; s += p195.a + p195.b;
    s += p196.a + p196.b; s += p197.a + p197.b; s += p198.a + p198.b; s += p199.a + p199.b;
    s += p200.a + p200.b; s += p201.a + p201.b; s += p202.a + p202.b; s += p203.a + p203.b;
    s += p204.a + p204.b; s += p205.a + p205.b; s += p206.a + p206.b; s += p207.a + p207.b;
    s += p208.a + p208.b; s += p209.a + p209.b; s += p210.a + p210.b; s += p211.a + p211.b;
    s += p212.a + p212.b; s += p213.a + p213.b; s += p214.a + p214.b; s += p215.a + p215.b;
    s += p216.a + p216.b; s += p217.a + p217.b; s += p218.a + p218.b; s += p219.a + p219.b;
    s += p220.a + p220.b; s += p221.a + p221.b; s += p222.a + p222.b; s += p223.a + p223.b;
    s += p224.a + p224.b; s += p225.a + p225.b; s += p226.a + p226.b; s += p227.a + p227.b;
    s += p228.a + p228.b; s += p229.a + p229.b; s += p230.a + p230.b; s += p231.a + p231.b;
    s += p232.a + p232.b; s += p233.a + p233.b; s += p234.a + p234.b; s += p235.a + p235.b;
    s += p236.a + p236.b; s += p237.a + p237.b; s += p238.a + p238.b; s += p239.a + p239.b;
    s += p240.a + p240.b; s += p241.a + p241.b; s += p242.a + p242.b; s += p243.a + p243.b;
    s += p244.a + p244.b; s += p245.a + p245.b; s += p246.a + p246.b; s += p247.a + p247.b;
    s += p248.a + p248.b; s += p249.a + p249.b; s += p250.a + p250.b; s += p251.a + p251.b;
    s += p252.a + p252.b; s += p253.a + p253.b; s += p254.a + p254.b; s += p255.a + p255.b;
    s += p256.a + p256.b; s += p257.a + p257.b; s += p258.a + p258.b; s += p259.a + p259.b;
    s += p260.a + p260.b;
    return s;
}

static long sum_longs(
    long v1, long v2, long v3, long v4, long v5, long v6, long v7, long v8,
    long v9, long v10, long v11, long v12, long v13, long v14, long v15, long v16,
    long v17, long v18, long v19, long v20, long v21, long v22, long v23, long v24,
    long v25, long v26, long v27, long v28, long v29, long v30, long v31, long v32,
    long v33, long v34, long v35, long v36, long v37, long v38, long v39, long v40,
    long v41, long v42, long v43, long v44, long v45, long v46, long v47, long v48,
    long v49, long v50, long v51, long v52, long v53, long v54, long v55, long v56,
    long v57, long v58, long v59, long v60, long v61, long v62, long v63, long v64,
    long v65, long v66, long v67, long v68, long v69, long v70, long v71, long v72,
    long v73, long v74, long v75, long v76, long v77, long v78, long v79, long v80,
    long v81, long v82, long v83, long v84, long v85, long v86, long v87, long v88,
    long v89, long v90, long v91, long v92, long v93, long v94, long v95, long v96,
    long v97, long v98, long v99, long v100, long v101, long v102, long v103, long v104,
    long v105, long v106, long v107, long v108, long v109, long v110, long v111, long v112,
    long v113, long v114, long v115, long v116, long v117, long v118, long v119, long v120,
    long v121, long v122, long v123, long v124, long v125, long v126, long v127, long v128,
    long v129, long v130, long v131, long v132, long v133, long v134, long v135, long v136,
    long v137, long v138, long v139, long v140, long v141, long v142, long v143, long v144,
    long v145, long v146, long v147, long v148, long v149, long v150, long v151, long v152,
    long v153, long v154, long v155, long v156, long v157, long v158, long v159, long v160,
    long v161, long v162, long v163, long v164, long v165, long v166, long v167, long v168,
    long v169, long v170, long v171, long v172, long v173, long v174, long v175, long v176,
    long v177, long v178, long v179, long v180, long v181, long v182, long v183, long v184,
    long v185, long v186, long v187, long v188, long v189, long v190, long v191, long v192,
    long v193, long v194, long v195, long v196, long v197, long v198, long v199, long v200,
    long v201, long v202, long v203, long v204, long v205, long v206, long v207, long v208,
    long v209, long v210, long v211, long v212, long v213, long v214, long v215, long v216,
    long v217, long v218, long v219, long v220, long v221, long v222, long v223, long v224,
    long v225, long v226, long v227, long v228, long v229, long v230, long v231, long v232,
    long v233, long v234, long v235, long v236, long v237, long v238, long v239, long v240,
    long v241, long v242, long v243, long v244, long v245, long v246, long v247, long v248,
    long v249, long v250, long v251, long v252, long v253, long v254, long v255, long v256,
    long v257, long v258, long v259, long v260)
{
    long s = 0;
    s += v1; s += v2; s += v3; s += v4; s += v5; s += v6; s += v7; s += v8;
    s += v9; s += v10; s += v11; s += v12; s += v13; s += v14; s += v15; s += v16;
    s += v17; s += v18; s += v19; s += v20; s += v21; s += v22; s += v23; s += v24;
    s += v25; s += v26; s += v27; s += v28; s += v29; s += v30; s += v31; s += v32;
    s += v33; s += v34; s += v35; s += v36; s += v37; s += v38; s += v39; s += v40;
    s += v41; s += v42; s += v43; s += v44; s += v45; s += v46; s += v47; s += v48;
    s += v49; s += v50; s += v51; s += v52; s += v53; s += v54; s += v55; s += v56;
    s += v57; s += v58; s += v59; s += v60; s += v61; s += v62; s += v63; s += v64;
    s += v65; s += v66; s += v67; s += v68; s += v69; s += v70; s += v71; s += v72;
    s += v73; s += v74; s += v75; s += v76; s += v77; s += v78; s += v79; s += v80;
    s += v81; s += v82; s += v83; s += v84; s += v85; s += v86; s += v87; s += v88;
    s += v89; s += v90; s += v91; s += v92; s += v93; s += v94; s += v95; s += v96;
    s += v97; s += v98; s += v99; s += v100; s += v101; s += v102; s += v103; s += v104;
    s += v105; s += v106; s += v107; s += v108; s += v109; s += v110; s += v111; s += v112;
    s += v113; s += v114; s += v115; s += v116; s += v117; s += v118; s += v119; s += v120;
    s += v121; s += v122; s += v123; s += v124; s += v125; s += v126; s += v127; s += v128;
    s += v129; s += v130; s += v131; s += v132; s += v133; s += v134; s += v135; s += v136;
    s += v137; s += v138; s += v139; s += v140; s += v141; s += v142; s += v143; s += v144;
    s += v145; s += v146; s += v147; s += v148; s += v149; s += v150; s += v151; s += v152;
    s += v153; s += v154; s += v155; s += v156; s += v157; s += v158; s += v159; s += v160;
    s += v161; s += v162; s += v163; s += v164; s += v165; s += v166; s += v167; s += v168;
    s += v169; s += v170; s += v171; s += v172; s += v173; s += v174; s += v175; s += v176;
    s += v177; s += v178; s += v179; s += v180; s += v181; s += v182; s += v183; s += v184;
    s += v185; s += v186; s += v187; s += v188; s += v189; s += v190; s += v191; s += v192;
    s += v193; s += v194; s += v195; s += v196; s += v197; s += v198; s += v199; s += v200;
    s += v201; s += v202; s += v203; s += v204; s += v205; s += v206; s += v207; s += v208;
    s += v209; s += v210; s += v211; s += v212; s += v213; s += v214; s += v215; s += v216;
    s += v217; s += v218; s += v219; s += v220; s += v221; s += v222; s += v223; s += v224;
    s += v225; s += v226; s += v227; s += v228; s += v229; s += v230; s += v231; s += v232;
    s += v233; s += v234; s += v235; s += v236; s += v237; s += v238; s += v239; s += v240;
    s += v241; s += v242; s += v243; s += v244; s += v245; s += v246; s += v247; s += v248;
    s += v249; s += v250; s += v251; s += v252; s += v253; s += v254; s += v255; s += v256;
    s += v257; s += v258; s += v259; s += v260;
    return s;
}

int main(void) {
    long (*fp)(
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long, long, long, long, long,
        long, long, long, long, long, long, long, long) = sum_longs;
    long (*sfp)(
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair, struct pair,
        struct pair, struct pair, struct pair, struct pair, struct pair) = sum_pairs;
    long i;
    for (i = 0; i < 261; i++) {
        g[i].a = i;
        g[i].b = 2 * i;
    }
    if (sum_pairs(
            g[0], g[1], g[2], g[3], g[4], g[5], g[6], g[7], g[8], g[9],
            g[10], g[11], g[12], g[13], g[14], g[15], g[16], g[17], g[18], g[19],
            g[20], g[21], g[22], g[23], g[24], g[25], g[26], g[27], g[28], g[29],
            g[30], g[31], g[32], g[33], g[34], g[35], g[36], g[37], g[38], g[39],
            g[40], g[41], g[42], g[43], g[44], g[45], g[46], g[47], g[48], g[49],
            g[50], g[51], g[52], g[53], g[54], g[55], g[56], g[57], g[58], g[59],
            g[60], g[61], g[62], g[63], g[64], g[65], g[66], g[67], g[68], g[69],
            g[70], g[71], g[72], g[73], g[74], g[75], g[76], g[77], g[78], g[79],
            g[80], g[81], g[82], g[83], g[84], g[85], g[86], g[87], g[88], g[89],
            g[90], g[91], g[92], g[93], g[94], g[95], g[96], g[97], g[98], g[99],
            g[100], g[101], g[102], g[103], g[104], g[105], g[106], g[107], g[108], g[109],
            g[110], g[111], g[112], g[113], g[114], g[115], g[116], g[117], g[118], g[119],
            g[120], g[121], g[122], g[123], g[124], g[125], g[126], g[127], g[128], g[129],
            g[130], g[131], g[132], g[133], g[134], g[135], g[136], g[137], g[138], g[139],
            g[140], g[141], g[142], g[143], g[144], g[145], g[146], g[147], g[148], g[149],
            g[150], g[151], g[152], g[153], g[154], g[155], g[156], g[157], g[158], g[159],
            g[160], g[161], g[162], g[163], g[164], g[165], g[166], g[167], g[168], g[169],
            g[170], g[171], g[172], g[173], g[174], g[175], g[176], g[177], g[178], g[179],
            g[180], g[181], g[182], g[183], g[184], g[185], g[186], g[187], g[188], g[189],
            g[190], g[191], g[192], g[193], g[194], g[195], g[196], g[197], g[198], g[199],
            g[200], g[201], g[202], g[203], g[204], g[205], g[206], g[207], g[208], g[209],
            g[210], g[211], g[212], g[213], g[214], g[215], g[216], g[217], g[218], g[219],
            g[220], g[221], g[222], g[223], g[224], g[225], g[226], g[227], g[228], g[229],
            g[230], g[231], g[232], g[233], g[234], g[235], g[236], g[237], g[238], g[239],
            g[240], g[241], g[242], g[243], g[244], g[245], g[246], g[247], g[248], g[249],
            g[250], g[251], g[252], g[253], g[254], g[255], g[256], g[257], g[258], g[259],
            g[260])
        != 101790) {
        return 1;
    }
    if (fp(
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
            17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
            33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
            65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
            81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
            97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112,
            113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128,
            129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144,
            145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160,
            161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176,
            177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192,
            193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
            209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224,
            225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240,
            241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256,
            257, 258, 259, 260)
        != 33930) {
        return 2;
    }
    if (sfp(
            g[0], g[1], g[2], g[3], g[4], g[5], g[6], g[7], g[8], g[9],
            g[10], g[11], g[12], g[13], g[14], g[15], g[16], g[17], g[18], g[19],
            g[20], g[21], g[22], g[23], g[24], g[25], g[26], g[27], g[28], g[29],
            g[30], g[31], g[32], g[33], g[34], g[35], g[36], g[37], g[38], g[39],
            g[40], g[41], g[42], g[43], g[44], g[45], g[46], g[47], g[48], g[49],
            g[50], g[51], g[52], g[53], g[54], g[55], g[56], g[57], g[58], g[59],
            g[60], g[61], g[62], g[63], g[64], g[65], g[66], g[67], g[68], g[69],
            g[70], g[71], g[72], g[73], g[74], g[75], g[76], g[77], g[78], g[79],
            g[80], g[81], g[82], g[83], g[84], g[85], g[86], g[87], g[88], g[89],
            g[90], g[91], g[92], g[93], g[94], g[95], g[96], g[97], g[98], g[99],
            g[100], g[101], g[102], g[103], g[104], g[105], g[106], g[107], g[108], g[109],
            g[110], g[111], g[112], g[113], g[114], g[115], g[116], g[117], g[118], g[119],
            g[120], g[121], g[122], g[123], g[124], g[125], g[126], g[127], g[128], g[129],
            g[130], g[131], g[132], g[133], g[134], g[135], g[136], g[137], g[138], g[139],
            g[140], g[141], g[142], g[143], g[144], g[145], g[146], g[147], g[148], g[149],
            g[150], g[151], g[152], g[153], g[154], g[155], g[156], g[157], g[158], g[159],
            g[160], g[161], g[162], g[163], g[164], g[165], g[166], g[167], g[168], g[169],
            g[170], g[171], g[172], g[173], g[174], g[175], g[176], g[177], g[178], g[179],
            g[180], g[181], g[182], g[183], g[184], g[185], g[186], g[187], g[188], g[189],
            g[190], g[191], g[192], g[193], g[194], g[195], g[196], g[197], g[198], g[199],
            g[200], g[201], g[202], g[203], g[204], g[205], g[206], g[207], g[208], g[209],
            g[210], g[211], g[212], g[213], g[214], g[215], g[216], g[217], g[218], g[219],
            g[220], g[221], g[222], g[223], g[224], g[225], g[226], g[227], g[228], g[229],
            g[230], g[231], g[232], g[233], g[234], g[235], g[236], g[237], g[238], g[239],
            g[240], g[241], g[242], g[243], g[244], g[245], g[246], g[247], g[248], g[249],
            g[250], g[251], g[252], g[253], g[254], g[255], g[256], g[257], g[258], g[259],
            g[260])
        != 101790) {
        return 3;
    }
    return 0;
}
