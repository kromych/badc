
const_time_des_round_wide_imm.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<des_round>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x3, x1
               	mov	w0, w0
               	and	w1, w0, #0x11111111
               	lsr	x2, x0, #1
               	and	w2, w2, #0x11111111
               	lsr	x4, x0, #2
               	and	w4, w4, #0x11111111
               	lsr	x0, x0, #3
               	and	w0, w0, #0x11111111
               	lsl	x5, x1, #4
               	sub	x1, x5, x1
               	lsl	x5, x2, #4
               	sub	x2, x5, x2
               	lsl	x5, x4, #4
               	sub	x4, x5, x4
               	lsl	x5, x0, #4
               	sub	x0, x5, x0
               	mov	w5, w0
               	lsl	x0, x5, #4
               	lsr	x6, x5, #28
               	orr	x0, x0, x6
               	mov	w1, w1
               	lsr	x6, x1, #4
               	lsl	x7, x1, #28
               	orr	x6, x6, x7
               	ldr	w7, [x3]
               	eor	x0, x0, x7
               	ldr	w7, [x3, #0x4]
               	eor	x1, x1, x7
               	ldr	w7, [x3, #0x8]
               	eor	x2, x2, x7
               	ldr	w7, [x3, #0xc]
               	eor	x4, x4, x7
               	ldr	w7, [x3, #0x10]
               	eor	x5, x5, x7
               	ldr	w3, [x3, #0x14]
               	eor	x3, x6, x3
               	mov	x17, #0xc69c            // =50844
               	movk	x17, #0xec7a, lsl #16
               	and	x6, x0, x17
               	mov	x17, #0x2c4d            // =11341
               	movk	x17, #0xefa7, lsl #16
               	eor	x6, x6, x17
               	mov	x17, #0xb821            // =47137
               	movk	x17, #0x500f, lsl #16
               	and	x7, x0, x17
               	mov	x17, #0xedff            // =60927
               	movk	x17, #0xaeaa, lsl #16
               	eor	x7, x7, x17
               	mov	x17, #0xa809            // =43017
               	movk	x17, #0x40ef, lsl #16
               	and	x8, x0, x17
               	mov	x17, #0x6665            // =26213
               	movk	x17, #0x3739, lsl #16
               	eor	x8, x8, x17
               	mov	x17, #0xb28             // =2856
               	movk	x17, #0xa5ec, lsl #16
               	and	x9, x0, x17
               	mov	x17, #0xb833            // =47155
               	movk	x17, #0x68d7, lsl #16
               	eor	x9, x9, x17
               	mov	x17, #0xf820            // =63520
               	movk	x17, #0x252c, lsl #16
               	and	x10, x0, x17
               	mov	x17, #0x55bb            // =21947
               	movk	x17, #0xc9c7, lsl #16
               	eor	x10, x10, x17
               	mov	x17, #0x5801            // =22529
               	movk	x17, #0x4020, lsl #16
               	and	x11, x0, x17
               	mov	x17, #0x3606            // =13830
               	movk	x17, #0x73fc, lsl #16
               	eor	x11, x11, x17
               	mov	x17, #0xf929            // =63785
               	movk	x17, #0xe220, lsl #16
               	and	x12, x0, x17
               	mov	x17, #0xa918            // =43288
               	movk	x17, #0xa2a0, lsl #16
               	eor	x12, x12, x17
               	mov	x17, #0xf9e1            // =63969
               	movk	x17, #0x44a3, lsl #16
               	and	x13, x0, x17
               	mov	x17, #0xbd90            // =48528
               	movk	x17, #0x8222, lsl #16
               	eor	x13, x13, x17
               	mov	x17, #0x104a            // =4170
               	movk	x17, #0x794f, lsl #16
               	and	x14, x0, x17
               	mov	x17, #0xac77            // =44151
               	movk	x17, #0xd6b6, lsl #16
               	eor	x14, x14, x17
               	mov	x17, #0x320b            // =12811
               	movk	x17, #0x26f, lsl #16
               	and	x15, x0, x17
               	mov	x17, #0x300c            // =12300
               	movk	x17, #0x3069, lsl #16
               	eor	x15, x15, x17
               	mov	x17, #0xb01a            // =45082
               	movk	x17, #0x7640, lsl #16
               	and	x20, x0, x17
               	mov	x17, #0xd5cc            // =54732
               	movk	x17, #0x6ce0, lsl #16
               	eor	x20, x20, x17
               	mov	x17, #0x1572            // =5490
               	movk	x17, #0x238f, lsl #16
               	and	x21, x0, x17
               	mov	x17, #0xa22d            // =41517
               	movk	x17, #0x59a9, lsl #16
               	eor	x21, x21, x17
               	mov	x17, #0xc083            // =49283
               	movk	x17, #0x7a63, lsl #16
               	and	x22, x0, x17
               	mov	x17, #0xbd4             // =3028
               	movk	x17, #0xac6d, lsl #16
               	eor	x22, x22, x17
               	mov	x17, #0xa000            // =40960
               	movk	x17, #0x11cc, lsl #16
               	and	x23, x0, x17
               	mov	x17, #0x3200            // =12800
               	movk	x17, #0x21c8, lsl #16
               	eor	x23, x23, x17
               	mov	x17, #0x69aa            // =27050
               	movk	x17, #0x202f, lsl #16
               	and	x24, x0, x17
               	mov	x17, #0x2188            // =8584
               	movk	x17, #0xa0e6, lsl #16
               	eor	x24, x24, x17
               	mov	x17, #0x3be9            // =15337
               	movk	x17, #0x51b3, lsl #16
               	and	x25, x0, x17
               	mov	x17, #0x655a            // =25946
               	movk	x17, #0xaf7d, lsl #16
               	eor	x25, x25, x17
               	mov	x17, #0xe8ae            // =59566
               	movk	x17, #0x3b0f, lsl #16
               	and	x26, x0, x17
               	mov	x17, #0x8aa3            // =35491
               	movk	x17, #0xf016, lsl #16
               	eor	x26, x26, x17
               	mov	x17, #0x8816            // =34838
               	movk	x17, #0x90bf, lsl #16
               	and	x27, x0, x17
               	mov	x17, #0x30c6            // =12486
               	movk	x17, #0x90aa, lsl #16
               	eor	x27, x27, x17
               	mov	x17, #0x4f9b            // =20379
               	movk	x17, #0x9e3, lsl #16
               	and	x28, x0, x17
               	mov	x17, #0x750a            // =29962
               	movk	x17, #0x5ab2, lsl #16
               	eor	x28, x28, x17
               	mov	x17, #0xbe88            // =48776
               	movk	x17, #0x103, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0xa8]
               	ldr	x16, [sp, #0xa8]
               	mov	x17, #0xbe65            // =48741
               	movk	x17, #0x5391, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xa8]
               	mov	x17, #0x8e25            // =36389
               	movk	x17, #0x49ac, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0xa0]
               	ldr	x16, [sp, #0xa0]
               	mov	x17, #0x2baf            // =11183
               	movk	x17, #0x9337, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xa0]
               	mov	x17, #0x313d            // =12605
               	movk	x17, #0x922c, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x98]
               	ldr	x16, [sp, #0x98]
               	mov	x17, #0x210c            // =8460
               	movk	x17, #0xf288, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x98]
               	mov	x17, #0x31b0            // =12720
               	movk	x17, #0x70ef, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x90]
               	ldr	x16, [sp, #0x90]
               	mov	x17, #0xf5c0            // =62912
               	movk	x17, #0x920a, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x90]
               	mov	x17, #0x7100            // =28928
               	movk	x17, #0x6a70, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x88]
               	ldr	x16, [sp, #0x88]
               	mov	x17, #0x12c0            // =4800
               	movk	x17, #0x63d3, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x88]
               	mov	x17, #0x9011            // =36881
               	movk	x17, #0xb97c, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x80]
               	ldr	x16, [sp, #0x80]
               	mov	x17, #0x3006            // =12294
               	movk	x17, #0x537b, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x80]
               	mov	x17, #0xc959            // =51545
               	movk	x17, #0xa320, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x78]
               	ldr	x16, [sp, #0x78]
               	mov	x17, #0xb0a5            // =45221
               	movk	x17, #0xa2ef, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x78]
               	mov	x17, #0xab4a            // =43850
               	movk	x17, #0x6ea0, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x70]
               	ldr	x16, [sp, #0x70]
               	mov	x17, #0x96a5            // =38565
               	movk	x17, #0xbc8f, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x70]
               	mov	x17, #0xddf8            // =56824
               	movk	x17, #0x6953, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x68]
               	ldr	x16, [sp, #0x68]
               	mov	x17, #0x76a5            // =30373
               	movk	x17, #0xfad1, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x68]
               	mov	x17, #0x3e2b            // =15915
               	movk	x17, #0xf74f, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x60]
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x14a3            // =5283
               	movk	x17, #0x665a, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x60]
               	mov	x17, #0x6cad            // =27821
               	movk	x17, #0xf030, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xf0cc            // =61644
               	movk	x17, #0xf2ef, lsl #16
               	eor	x0, x0, x17
               	and	x7, x1, x7
               	eor	x6, x6, x7
               	and	x7, x1, x9
               	eor	x7, x8, x7
               	and	x8, x1, x11
               	eor	x8, x10, x8
               	and	x9, x1, x13
               	eor	x9, x12, x9
               	and	x10, x1, x15
               	eor	x10, x14, x10
               	and	x11, x1, x21
               	eor	x11, x20, x11
               	and	x12, x1, x23
               	eor	x12, x22, x12
               	and	x13, x1, x26
               	eor	x13, x25, x13
               	and	x14, x1, x28
               	eor	x14, x27, x14
               	ldr	x17, [sp, #0xa0]
               	and	x15, x1, x17
               	ldr	x16, [sp, #0xa8]
               	eor	x15, x16, x15
               	ldr	x17, [sp, #0x90]
               	and	x20, x1, x17
               	ldr	x16, [sp, #0x98]
               	eor	x20, x16, x20
               	ldr	x17, [sp, #0x80]
               	and	x21, x1, x17
               	ldr	x16, [sp, #0x88]
               	eor	x21, x16, x21
               	ldr	x17, [sp, #0x70]
               	and	x22, x1, x17
               	ldr	x16, [sp, #0x78]
               	eor	x22, x16, x22
               	ldr	x17, [sp, #0x60]
               	and	x1, x1, x17
               	ldr	x16, [sp, #0x68]
               	eor	x1, x16, x1
               	and	x7, x2, x7
               	eor	x6, x6, x7
               	and	x7, x2, x9
               	eor	x7, x8, x7
               	and	x8, x2, x11
               	eor	x8, x10, x8
               	and	x9, x2, x24
               	eor	x9, x12, x9
               	and	x10, x2, x14
               	eor	x10, x13, x10
               	and	x11, x2, x20
               	eor	x11, x15, x11
               	and	x12, x2, x22
               	eor	x12, x21, x12
               	and	x0, x2, x0
               	eor	x0, x1, x0
               	and	x1, x4, x7
               	eor	x1, x6, x1
               	and	x2, x4, x9
               	eor	x2, x8, x2
               	and	x6, x4, x11
               	eor	x6, x10, x6
               	and	x0, x4, x0
               	eor	x0, x12, x0
               	and	x2, x5, x2
               	eor	x1, x1, x2
               	and	x0, x5, x0
               	eor	x0, x6, x0
               	and	x0, x3, x0
               	eor	x0, x1, x0
               	and	x1, x0, #0x4
               	lsl	x1, x1, #3
               	and	x2, x0, #0x4000
               	lsl	x2, x2, #4
               	orr	x2, x1, x2
               	mov	x17, #0x120             // =288
               	movk	x17, #0x1202, lsl #16
               	and	x1, x0, x17
               	lsl	x3, x1, #5
               	lsr	x1, x1, #27
               	orr	x1, x3, x1
               	orr	x1, x2, x1
               	and	x2, x0, #0x100000
               	lsl	x2, x2, #6
               	orr	x1, x1, x2
               	and	x2, x0, #0x8000
               	lsl	x2, x2, #9
               	orr	x1, x1, x2
               	and	x2, x0, #0x4000000
               	lsr	x2, x2, #22
               	orr	x1, x1, x2
               	and	x2, x0, #0x1
               	lsl	x2, x2, #11
               	orr	x2, x1, x2
               	mov	x17, #0x200             // =512
               	movk	x17, #0x2000, lsl #16
               	and	x1, x0, x17
               	lsl	x3, x1, #12
               	lsr	x1, x1, #20
               	orr	x1, x3, x1
               	orr	x1, x2, x1
               	and	x2, x0, #0x200000
               	lsr	x2, x2, #19
               	orr	x1, x1, x2
               	and	x2, x0, #0x40
               	lsl	x2, x2, #14
               	orr	x1, x1, x2
               	and	x2, x0, #0x10000
               	lsl	x2, x2, #15
               	orr	x1, x1, x2
               	and	x2, x0, #0x2
               	lsl	x2, x2, #16
               	orr	x2, x1, x2
               	mov	x17, #0x1800            // =6144
               	movk	x17, #0x4080, lsl #16
               	and	x1, x0, x17
               	lsl	x3, x1, #17
               	lsr	x1, x1, #15
               	orr	x1, x3, x1
               	orr	x1, x2, x1
               	and	x2, x0, #0x80000
               	lsr	x2, x2, #13
               	orr	x1, x1, x2
               	and	x2, x0, #0x10
               	lsl	x2, x2, #21
               	orr	x1, x1, x2
               	and	x2, x0, #0x1000000
               	lsr	x2, x2, #10
               	orr	x2, x1, x2
               	mov	x17, #0x8               // =8
               	movk	x17, #0x8800, lsl #16
               	and	x1, x0, x17
               	lsl	x3, x1, #24
               	lsr	x1, x1, #8
               	orr	x1, x3, x1
               	orr	x1, x2, x1
               	mov	x17, #0x480             // =1152
               	and	x2, x0, x17
               	lsr	x2, x2, #7
               	orr	x1, x1, x2
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
               	mov	x20, x0
               	mov	x0, #0x1ac0             // =6848
               	movk	x0, #0xd2f5, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0xcf1f             // =53023
               	movk	x0, #0x3849, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0xd1f2             // =53746
               	movk	x0, #0xbabb, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x8a9              // =2217
               	movk	x0, #0xe41, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0xb9f4             // =47604
               	movk	x0, #0xb7b0, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x9cc3             // =40131
               	movk	x0, #0x2353, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x9b46             // =39750
               	movk	x0, #0xa72e, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0xb9ed             // =47597
               	movk	x0, #0x7580, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0xd268             // =53864
               	movk	x0, #0xa631, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x12a7             // =4775
               	movk	x0, #0x12f4, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x6fda             // =28634
               	movk	x0, #0x4491, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x7d71             // =32113
               	movk	x0, #0x96ac, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x581c             // =22556
               	movk	x0, #0xdd35, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
               	mov	x0, #0x94cb             // =38091
               	movk	x0, #0x53fb, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	eor	x20, x20, x0
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
               	and	x0, x0, #0xff
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
