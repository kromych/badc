
const_time_des_round_wide_imm.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x2, x1
               	mov	w0, w0
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x1, x0, x17
               	lsr	x3, x0, #1
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x3, x3, x17
               	lsr	x4, x0, #2
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x4, x4, x17
               	lsr	x0, x0, #3
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x5, x0, x17
               	mov	w0, w1
               	lsl	x1, x0, #4
               	mov	w1, w1
               	sub	x0, x1, x0
               	mov	w1, w0
               	mov	w0, w3
               	lsl	x3, x0, #4
               	mov	w3, w3
               	sub	x0, x3, x0
               	mov	w3, w0
               	mov	w0, w4
               	lsl	x4, x0, #4
               	mov	w4, w4
               	sub	x0, x4, x0
               	mov	w4, w0
               	mov	w0, w5
               	lsl	x5, x0, #4
               	mov	w5, w5
               	sub	x0, x5, x0
               	mov	w0, w0
               	mov	w5, w0
               	lsl	x0, x5, #4
               	mov	w0, w0
               	lsr	x6, x5, #28
               	orr	x0, x0, x6
               	mov	w1, w1
               	lsr	x6, x1, #4
               	lsl	x7, x1, #28
               	mov	w7, w7
               	orr	x6, x6, x7
               	mov	w0, w0
               	ldr	w7, [x2]
               	eor	x0, x0, x7
               	mov	w0, w0
               	ldr	w7, [x2, #0x4]
               	eor	x1, x1, x7
               	mov	w1, w1
               	mov	w3, w3
               	ldr	w7, [x2, #0x8]
               	eor	x3, x3, x7
               	mov	w3, w3
               	mov	w4, w4
               	ldr	w7, [x2, #0xc]
               	eor	x4, x4, x7
               	mov	w4, w4
               	ldr	w7, [x2, #0x10]
               	eor	x5, x5, x7
               	mov	w5, w5
               	mov	w6, w6
               	ldr	w2, [x2, #0x14]
               	eor	x2, x6, x2
               	mov	w16, w2
               	str	x16, [sp, #0x60]
               	mov	x17, #0xc69c            // =50844
               	movk	x17, #0xec7a, lsl #16
               	and	x2, x0, x17
               	mov	x17, #0x2c4d            // =11341
               	movk	x17, #0xefa7, lsl #16
               	eor	x2, x2, x17
               	mov	x17, #0xb821            // =47137
               	movk	x17, #0x500f, lsl #16
               	and	x6, x0, x17
               	mov	x17, #0xedff            // =60927
               	movk	x17, #0xaeaa, lsl #16
               	eor	x6, x6, x17
               	mov	x17, #0xa809            // =43017
               	movk	x17, #0x40ef, lsl #16
               	and	x7, x0, x17
               	mov	x17, #0x6665            // =26213
               	movk	x17, #0x3739, lsl #16
               	eor	x7, x7, x17
               	mov	x17, #0xb28             // =2856
               	movk	x17, #0xa5ec, lsl #16
               	and	x8, x0, x17
               	mov	x17, #0xb833            // =47155
               	movk	x17, #0x68d7, lsl #16
               	eor	x8, x8, x17
               	mov	x17, #0xf820            // =63520
               	movk	x17, #0x252c, lsl #16
               	and	x9, x0, x17
               	mov	x17, #0x55bb            // =21947
               	movk	x17, #0xc9c7, lsl #16
               	eor	x9, x9, x17
               	mov	x17, #0x5801            // =22529
               	movk	x17, #0x4020, lsl #16
               	and	x10, x0, x17
               	mov	x17, #0x3606            // =13830
               	movk	x17, #0x73fc, lsl #16
               	eor	x10, x10, x17
               	mov	x17, #0xf929            // =63785
               	movk	x17, #0xe220, lsl #16
               	and	x11, x0, x17
               	mov	x17, #0xa918            // =43288
               	movk	x17, #0xa2a0, lsl #16
               	eor	x11, x11, x17
               	mov	x17, #0xf9e1            // =63969
               	movk	x17, #0x44a3, lsl #16
               	and	x12, x0, x17
               	mov	x17, #0xbd90            // =48528
               	movk	x17, #0x8222, lsl #16
               	eor	x12, x12, x17
               	mov	x17, #0x104a            // =4170
               	movk	x17, #0x794f, lsl #16
               	and	x13, x0, x17
               	mov	x17, #0xac77            // =44151
               	movk	x17, #0xd6b6, lsl #16
               	eor	x13, x13, x17
               	mov	x17, #0x320b            // =12811
               	movk	x17, #0x26f, lsl #16
               	and	x14, x0, x17
               	mov	x17, #0x300c            // =12300
               	movk	x17, #0x3069, lsl #16
               	eor	x14, x14, x17
               	mov	x17, #0xb01a            // =45082
               	movk	x17, #0x7640, lsl #16
               	and	x15, x0, x17
               	mov	x17, #0xd5cc            // =54732
               	movk	x17, #0x6ce0, lsl #16
               	eor	x15, x15, x17
               	mov	x17, #0x1572            // =5490
               	movk	x17, #0x238f, lsl #16
               	and	x20, x0, x17
               	mov	x17, #0xa22d            // =41517
               	movk	x17, #0x59a9, lsl #16
               	eor	x20, x20, x17
               	mov	x17, #0xc083            // =49283
               	movk	x17, #0x7a63, lsl #16
               	and	x21, x0, x17
               	mov	x17, #0xbd4             // =3028
               	movk	x17, #0xac6d, lsl #16
               	eor	x21, x21, x17
               	mov	x17, #0xa000            // =40960
               	movk	x17, #0x11cc, lsl #16
               	and	x22, x0, x17
               	mov	x17, #0x3200            // =12800
               	movk	x17, #0x21c8, lsl #16
               	eor	x22, x22, x17
               	mov	x17, #0x69aa            // =27050
               	movk	x17, #0x202f, lsl #16
               	and	x23, x0, x17
               	mov	x17, #0x2188            // =8584
               	movk	x17, #0xa0e6, lsl #16
               	eor	x23, x23, x17
               	mov	x17, #0x3be9            // =15337
               	movk	x17, #0x51b3, lsl #16
               	and	x24, x0, x17
               	mov	x17, #0x655a            // =25946
               	movk	x17, #0xaf7d, lsl #16
               	eor	x24, x24, x17
               	mov	x17, #0xe8ae            // =59566
               	movk	x17, #0x3b0f, lsl #16
               	and	x25, x0, x17
               	mov	x17, #0x8aa3            // =35491
               	movk	x17, #0xf016, lsl #16
               	eor	x25, x25, x17
               	mov	x17, #0x8816            // =34838
               	movk	x17, #0x90bf, lsl #16
               	and	x26, x0, x17
               	mov	x17, #0x30c6            // =12486
               	movk	x17, #0x90aa, lsl #16
               	eor	x26, x26, x17
               	mov	x17, #0x4f9b            // =20379
               	movk	x17, #0x9e3, lsl #16
               	and	x27, x0, x17
               	mov	x17, #0x750a            // =29962
               	movk	x17, #0x5ab2, lsl #16
               	eor	x27, x27, x17
               	mov	x17, #0xbe88            // =48776
               	movk	x17, #0x103, lsl #16
               	and	x28, x0, x17
               	mov	x17, #0xbe65            // =48741
               	movk	x17, #0x5391, lsl #16
               	eor	x28, x28, x17
               	mov	x17, #0x8e25            // =36389
               	movk	x17, #0x49ac, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0xa8]
               	ldr	x16, [sp, #0xa8]
               	mov	x17, #0x2baf            // =11183
               	movk	x17, #0x9337, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xa8]
               	mov	x17, #0x313d            // =12605
               	movk	x17, #0x922c, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0xa0]
               	ldr	x16, [sp, #0xa0]
               	mov	x17, #0x210c            // =8460
               	movk	x17, #0xf288, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xa0]
               	mov	x17, #0x31b0            // =12720
               	movk	x17, #0x70ef, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x98]
               	ldr	x16, [sp, #0x98]
               	mov	x17, #0xf5c0            // =62912
               	movk	x17, #0x920a, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x98]
               	mov	x17, #0x7100            // =28928
               	movk	x17, #0x6a70, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x90]
               	ldr	x16, [sp, #0x90]
               	mov	x17, #0x12c0            // =4800
               	movk	x17, #0x63d3, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x90]
               	mov	x17, #0x9011            // =36881
               	movk	x17, #0xb97c, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x88]
               	ldr	x16, [sp, #0x88]
               	mov	x17, #0x3006            // =12294
               	movk	x17, #0x537b, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x88]
               	mov	x17, #0xc959            // =51545
               	movk	x17, #0xa320, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x80]
               	ldr	x16, [sp, #0x80]
               	mov	x17, #0xb0a5            // =45221
               	movk	x17, #0xa2ef, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x80]
               	mov	x17, #0xab4a            // =43850
               	movk	x17, #0x6ea0, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x78]
               	ldr	x16, [sp, #0x78]
               	mov	x17, #0x96a5            // =38565
               	movk	x17, #0xbc8f, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x78]
               	mov	x17, #0xddf8            // =56824
               	movk	x17, #0x6953, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x70]
               	ldr	x16, [sp, #0x70]
               	mov	x17, #0x76a5            // =30373
               	movk	x17, #0xfad1, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x70]
               	mov	x17, #0x3e2b            // =15915
               	movk	x17, #0xf74f, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x68]
               	ldr	x16, [sp, #0x68]
               	mov	x17, #0x14a3            // =5283
               	movk	x17, #0x665a, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x68]
               	mov	x17, #0x6cad            // =27821
               	movk	x17, #0xf030, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xf0cc            // =61644
               	movk	x17, #0xf2ef, lsl #16
               	eor	x0, x0, x17
               	mov	w2, w2
               	mov	w6, w6
               	and	x6, x1, x6
               	eor	x2, x2, x6
               	mov	w6, w7
               	mov	w7, w8
               	and	x7, x1, x7
               	eor	x6, x6, x7
               	mov	w7, w9
               	mov	w8, w10
               	and	x8, x1, x8
               	eor	x7, x7, x8
               	mov	w8, w11
               	mov	w9, w12
               	and	x9, x1, x9
               	eor	x8, x8, x9
               	mov	w9, w13
               	mov	w10, w14
               	and	x10, x1, x10
               	eor	x9, x9, x10
               	mov	w10, w15
               	mov	w11, w20
               	and	x11, x1, x11
               	eor	x10, x10, x11
               	mov	w11, w21
               	mov	w12, w22
               	and	x12, x1, x12
               	eor	x11, x11, x12
               	mov	w22, w23
               	mov	w12, w24
               	mov	w13, w25
               	and	x13, x1, x13
               	eor	x12, x12, x13
               	mov	w13, w26
               	mov	w14, w27
               	and	x14, x1, x14
               	eor	x13, x13, x14
               	mov	w14, w28
               	ldr	x16, [sp, #0xa8]
               	mov	w15, w16
               	and	x15, x1, x15
               	eor	x14, x14, x15
               	ldr	x16, [sp, #0xa0]
               	mov	w15, w16
               	ldr	x16, [sp, #0x98]
               	mov	w20, w16
               	and	x20, x1, x20
               	eor	x15, x15, x20
               	ldr	x16, [sp, #0x90]
               	mov	w20, w16
               	ldr	x16, [sp, #0x88]
               	mov	w21, w16
               	and	x21, x1, x21
               	eor	x20, x20, x21
               	ldr	x16, [sp, #0x80]
               	mov	w21, w16
               	ldr	x16, [sp, #0x78]
               	mov	w23, w16
               	and	x23, x1, x23
               	eor	x21, x21, x23
               	ldr	x16, [sp, #0x70]
               	mov	w23, w16
               	ldr	x16, [sp, #0x68]
               	mov	w24, w16
               	and	x1, x1, x24
               	eor	x1, x23, x1
               	mov	w23, w0
               	mov	w0, w2
               	mov	w2, w6
               	and	x2, x3, x2
               	eor	x0, x0, x2
               	mov	w2, w7
               	mov	w6, w8
               	and	x6, x3, x6
               	eor	x2, x2, x6
               	mov	w6, w9
               	mov	w7, w10
               	and	x7, x3, x7
               	eor	x6, x6, x7
               	mov	w7, w11
               	mov	w8, w22
               	and	x8, x3, x8
               	eor	x7, x7, x8
               	mov	w8, w12
               	mov	w9, w13
               	and	x9, x3, x9
               	eor	x8, x8, x9
               	mov	w9, w14
               	mov	w10, w15
               	and	x10, x3, x10
               	eor	x9, x9, x10
               	mov	w10, w20
               	mov	w11, w21
               	and	x11, x3, x11
               	eor	x10, x10, x11
               	mov	w1, w1
               	mov	w11, w23
               	and	x3, x3, x11
               	eor	x1, x1, x3
               	mov	w0, w0
               	mov	w2, w2
               	and	x2, x4, x2
               	eor	x0, x0, x2
               	mov	w2, w6
               	mov	w3, w7
               	and	x3, x4, x3
               	eor	x2, x2, x3
               	mov	w3, w8
               	mov	w6, w9
               	and	x6, x4, x6
               	eor	x3, x3, x6
               	mov	w6, w10
               	mov	w1, w1
               	and	x1, x4, x1
               	eor	x1, x6, x1
               	mov	w0, w0
               	mov	w2, w2
               	and	x2, x5, x2
               	eor	x0, x0, x2
               	mov	w2, w3
               	mov	w1, w1
               	and	x1, x5, x1
               	eor	x1, x2, x1
               	mov	w0, w0
               	mov	w1, w1
               	ldr	x16, [sp, #0x60]
               	and	x1, x16, x1
               	eor	x0, x0, x1
               	mov	w1, w0
               	mov	x17, #0x4               // =4
               	and	x2, x1, x17
               	lsl	x2, x2, #3
               	mov	w2, w2
               	mov	w2, w2
               	mov	x17, #0x4000            // =16384
               	and	x3, x1, x17
               	lsl	x3, x3, #4
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x120             // =288
               	movk	x17, #0x1202, lsl #16
               	and	x1, x1, x17
               	mov	w1, w1
               	lsl	x3, x1, #5
               	mov	w3, w3
               	lsr	x1, x1, #27
               	orr	x1, x3, x1
               	mov	w1, w1
               	orr	x1, x2, x1
               	mov	w2, w1
               	mov	w1, w0
               	mov	x17, #0x100000          // =1048576
               	and	x3, x1, x17
               	lsl	x3, x3, #6
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x8000            // =32768
               	and	x3, x1, x17
               	lsl	x3, x3, #9
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x4000000         // =67108864
               	and	x3, x1, x17
               	lsr	x3, x3, #22
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x1               // =1
               	and	x3, x1, x17
               	lsl	x3, x3, #11
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x200             // =512
               	movk	x17, #0x2000, lsl #16
               	and	x1, x1, x17
               	mov	w1, w1
               	lsl	x3, x1, #12
               	mov	w3, w3
               	lsr	x1, x1, #20
               	orr	x1, x3, x1
               	mov	w1, w1
               	orr	x1, x2, x1
               	mov	w2, w1
               	mov	w1, w0
               	mov	x17, #0x200000          // =2097152
               	and	x3, x1, x17
               	lsr	x3, x3, #19
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x40              // =64
               	and	x3, x1, x17
               	lsl	x3, x3, #14
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x10000           // =65536
               	and	x3, x1, x17
               	lsl	x3, x3, #15
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x2               // =2
               	and	x3, x1, x17
               	lsl	x3, x3, #16
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x1800            // =6144
               	movk	x17, #0x4080, lsl #16
               	and	x1, x1, x17
               	mov	w1, w1
               	lsl	x3, x1, #17
               	mov	w3, w3
               	lsr	x1, x1, #15
               	orr	x1, x3, x1
               	mov	w1, w1
               	orr	x1, x2, x1
               	mov	w2, w1
               	mov	w1, w0
               	mov	x17, #0x80000           // =524288
               	and	x3, x1, x17
               	lsr	x3, x3, #13
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x10              // =16
               	and	x3, x1, x17
               	lsl	x3, x3, #21
               	mov	w3, w3
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x1000000         // =16777216
               	and	x3, x1, x17
               	lsr	x3, x3, #10
               	orr	x2, x2, x3
               	mov	w2, w2
               	mov	x17, #0x8               // =8
               	movk	x17, #0x8800, lsl #16
               	and	x1, x1, x17
               	mov	w1, w1
               	lsl	x3, x1, #24
               	mov	w3, w3
               	lsr	x1, x1, #8
               	orr	x1, x3, x1
               	mov	w1, w1
               	orr	x1, x2, x1
               	mov	w1, w1
               	mov	w0, w0
               	mov	x17, #0x480             // =1152
               	and	x2, x0, x17
               	lsr	x2, x2, #7
               	orr	x1, x1, x2
               	mov	w1, w1
               	mov	x17, #0x2000            // =8192
               	movk	x17, #0x44, lsl #16
               	and	x0, x0, x17
               	lsr	x0, x0, #6
               	orr	x0, x1, x0
               	mov	w0, w0
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	mov	w20, w0
               	mov	x0, #0x1ac0             // =6848
               	movk	x0, #0xd2f5, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0xcf1f             // =53023
               	movk	x0, #0x3849, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0xd1f2             // =53746
               	movk	x0, #0xbabb, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x8a9              // =2217
               	movk	x0, #0xe41, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0xb9f4             // =47604
               	movk	x0, #0xb7b0, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x9cc3             // =40131
               	movk	x0, #0x2353, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x9b46             // =39750
               	movk	x0, #0xa72e, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0xb9ed             // =47597
               	movk	x0, #0x7580, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0xd268             // =53864
               	movk	x0, #0xa631, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x12a7             // =4775
               	movk	x0, #0x12f4, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x6fda             // =28634
               	movk	x0, #0x4491, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x7d71             // =32113
               	movk	x0, #0x96ac, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x581c             // =22556
               	movk	x0, #0xdd35, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x94cb             // =38091
               	movk	x0, #0x53fb, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w20, w0
               	mov	x0, #0x63ae             // =25518
               	movk	x0, #0x4551, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x0, x20, x0
               	mov	w0, w0
               	lsr	x1, x0, #8
               	eor	x1, x0, x1
               	lsr	x2, x0, #16
               	eor	x1, x1, x2
               	lsr	x0, x0, #24
               	eor	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
