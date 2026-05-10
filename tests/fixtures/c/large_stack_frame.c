#include <stdlib.h>

// Function with more than 511 local variables -- the threshold
// where the AArch64 backend used to silently miscompile the
// prologue's `sub sp, sp, #N*8`. Single-instruction `SUB
// (immediate)` only carries a 12-bit value, so 512+ locals
// (>= 4096 bytes) need either the shifted-12 encoding or a
// two-instruction split. Without that fix, the operand
// overflowed into the shift bits and the prologue trapped with
// SIGILL on first call.
//
// sqlite3's `do_meta_command` (about 1500 locals across its
// many dot-command branches) is the in-the-wild trigger; this
// fixture reproduces the scenario in 30 lines.

int big(int x) {
    // 600 distinct ints -- comfortably past the 511 single-sub
    // limit, well below the 24-bit two-sub limit. Each must be
    // addressable so the compiler can't fold the slots away.
    int a000, a001, a002, a003, a004, a005, a006, a007, a008, a009;
    int a010, a011, a012, a013, a014, a015, a016, a017, a018, a019;
    int a020, a021, a022, a023, a024, a025, a026, a027, a028, a029;
    int a030, a031, a032, a033, a034, a035, a036, a037, a038, a039;
    int a040, a041, a042, a043, a044, a045, a046, a047, a048, a049;
    int a050, a051, a052, a053, a054, a055, a056, a057, a058, a059;
    int a060, a061, a062, a063, a064, a065, a066, a067, a068, a069;
    int a070, a071, a072, a073, a074, a075, a076, a077, a078, a079;
    int a080, a081, a082, a083, a084, a085, a086, a087, a088, a089;
    int a090, a091, a092, a093, a094, a095, a096, a097, a098, a099;
    int a100, a101, a102, a103, a104, a105, a106, a107, a108, a109;
    int a110, a111, a112, a113, a114, a115, a116, a117, a118, a119;
    int a120, a121, a122, a123, a124, a125, a126, a127, a128, a129;
    int a130, a131, a132, a133, a134, a135, a136, a137, a138, a139;
    int a140, a141, a142, a143, a144, a145, a146, a147, a148, a149;
    int a150, a151, a152, a153, a154, a155, a156, a157, a158, a159;
    int a160, a161, a162, a163, a164, a165, a166, a167, a168, a169;
    int a170, a171, a172, a173, a174, a175, a176, a177, a178, a179;
    int a180, a181, a182, a183, a184, a185, a186, a187, a188, a189;
    int a190, a191, a192, a193, a194, a195, a196, a197, a198, a199;
    int a200, a201, a202, a203, a204, a205, a206, a207, a208, a209;
    int a210, a211, a212, a213, a214, a215, a216, a217, a218, a219;
    int a220, a221, a222, a223, a224, a225, a226, a227, a228, a229;
    int a230, a231, a232, a233, a234, a235, a236, a237, a238, a239;
    int a240, a241, a242, a243, a244, a245, a246, a247, a248, a249;
    int a250, a251, a252, a253, a254, a255, a256, a257, a258, a259;
    int a260, a261, a262, a263, a264, a265, a266, a267, a268, a269;
    int a270, a271, a272, a273, a274, a275, a276, a277, a278, a279;
    int a280, a281, a282, a283, a284, a285, a286, a287, a288, a289;
    int a290, a291, a292, a293, a294, a295, a296, a297, a298, a299;
    int a300, a301, a302, a303, a304, a305, a306, a307, a308, a309;
    int a310, a311, a312, a313, a314, a315, a316, a317, a318, a319;
    int a320, a321, a322, a323, a324, a325, a326, a327, a328, a329;
    int a330, a331, a332, a333, a334, a335, a336, a337, a338, a339;
    int a340, a341, a342, a343, a344, a345, a346, a347, a348, a349;
    int a350, a351, a352, a353, a354, a355, a356, a357, a358, a359;
    int a360, a361, a362, a363, a364, a365, a366, a367, a368, a369;
    int a370, a371, a372, a373, a374, a375, a376, a377, a378, a379;
    int a380, a381, a382, a383, a384, a385, a386, a387, a388, a389;
    int a390, a391, a392, a393, a394, a395, a396, a397, a398, a399;
    int a400, a401, a402, a403, a404, a405, a406, a407, a408, a409;
    int a410, a411, a412, a413, a414, a415, a416, a417, a418, a419;
    int a420, a421, a422, a423, a424, a425, a426, a427, a428, a429;
    int a430, a431, a432, a433, a434, a435, a436, a437, a438, a439;
    int a440, a441, a442, a443, a444, a445, a446, a447, a448, a449;
    int a450, a451, a452, a453, a454, a455, a456, a457, a458, a459;
    int a460, a461, a462, a463, a464, a465, a466, a467, a468, a469;
    int a470, a471, a472, a473, a474, a475, a476, a477, a478, a479;
    int a480, a481, a482, a483, a484, a485, a486, a487, a488, a489;
    int a490, a491, a492, a493, a494, a495, a496, a497, a498, a499;
    int a500, a501, a502, a503, a504, a505, a506, a507, a508, a509;
    int a510, a511, a512, a513, a514, a515, a516, a517, a518, a519;
    int a520, a521, a522, a523, a524, a525, a526, a527, a528, a529;
    int a530, a531, a532, a533, a534, a535, a536, a537, a538, a539;
    int a540, a541, a542, a543, a544, a545, a546, a547, a548, a549;
    int a550, a551, a552, a553, a554, a555, a556, a557, a558, a559;
    int a560, a561, a562, a563, a564, a565, a566, a567, a568, a569;
    int a570, a571, a572, a573, a574, a575, a576, a577, a578, a579;
    int a580, a581, a582, a583, a584, a585, a586, a587, a588, a589;
    int a590, a591, a592, a593, a594, a595, a596, a597, a598, a599;

    // Touch the first, middle, and last slot so none get folded
    // away as dead. The chain ends at `a599` so the prologue had
    // to allocate the full 600-slot frame.
    a000 = x;
    a300 = a000 + 1;
    a599 = a300 + 1;
    return a599;
}

int main() {
    int v = big(40);
    return v;  // 42
}
