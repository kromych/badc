
des_ct_fconf_wide_imm_scratch.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x1, w1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsl	x2, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	mov	x3, #0x20               // =32
               	sub	x1, x3, x1
               	sxtw	x1, w1
               	lsr	x0, x0, x1
               	orr	x0, x2, x0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2b0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x2, x0, x17
               	stur	w2, [x29, #-0x10]
               	lsr	x2, x0, #1
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x2, x2, x17
               	stur	w2, [x29, #-0x18]
               	lsr	x2, x0, #2
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x2, x2, x17
               	stur	w2, [x29, #-0x20]
               	lsr	x0, x0, #3
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	and	x0, x0, x17
               	stur	w0, [x29, #-0x28]
               	ldur	w0, [x29, #-0x10]
               	lsl	x2, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	sub	x0, x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	stur	w0, [x29, #-0x10]
               	ldur	w0, [x29, #-0x18]
               	lsl	x2, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	sub	x0, x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	stur	w0, [x29, #-0x18]
               	ldur	w0, [x29, #-0x20]
               	lsl	x2, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	sub	x0, x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	stur	w0, [x29, #-0x20]
               	ldur	w0, [x29, #-0x28]
               	lsl	x2, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	sub	x0, x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	stur	w0, [x29, #-0x28]
               	ldur	w0, [x29, #-0x28]
               	lsl	x2, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	lsr	x0, x0, #28
               	orr	x0, x2, x0
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x10]
               	lsr	x2, x0, #4
               	lsl	x0, x0, #28
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	orr	x0, x2, x0
               	stur	w0, [x29, #-0x30]
               	sub	x0, x29, #0x8
               	ldr	w2, [x0]
               	ldr	w3, [x1]
               	eor	x2, x2, x3
               	str	w2, [x0]
               	sub	x0, x29, #0x10
               	ldr	w2, [x0]
               	add	x3, x1, #0x4
               	ldr	w3, [x3]
               	eor	x2, x2, x3
               	str	w2, [x0]
               	sub	x0, x29, #0x18
               	ldr	w2, [x0]
               	add	x3, x1, #0x8
               	ldr	w3, [x3]
               	eor	x2, x2, x3
               	str	w2, [x0]
               	sub	x0, x29, #0x20
               	ldr	w2, [x0]
               	mov	x3, #0xc                // =12
               	add	x4, x1, #0xc
               	ldr	w4, [x4]
               	eor	x2, x2, x4
               	str	w2, [x0]
               	sub	x0, x29, #0x28
               	ldr	w2, [x0]
               	add	x4, x1, #0x10
               	ldr	w4, [x4]
               	eor	x2, x2, x4
               	str	w2, [x0]
               	sub	x0, x29, #0x30
               	ldr	w2, [x0]
               	add	x1, x1, #0x14
               	ldr	w1, [x1]
               	eor	x1, x2, x1
               	str	w1, [x0]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xc69c            // =50844
               	movk	x17, #0xec7a, lsl #16
               	and	x1, x0, x17
               	mov	x17, #0x2c4d            // =11341
               	movk	x17, #0xefa7, lsl #16
               	eor	x1, x1, x17
               	mov	x17, #0xb821            // =47137
               	movk	x17, #0x500f, lsl #16
               	and	x2, x0, x17
               	mov	x17, #0xedff            // =60927
               	movk	x17, #0xaeaa, lsl #16
               	eor	x2, x2, x17
               	mov	x17, #0xa809            // =43017
               	movk	x17, #0x40ef, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x6665            // =26213
               	movk	x17, #0x3739, lsl #16
               	eor	x4, x4, x17
               	mov	x17, #0xb28             // =2856
               	movk	x17, #0xa5ec, lsl #16
               	and	x5, x0, x17
               	mov	x17, #0xb833            // =47155
               	movk	x17, #0x68d7, lsl #16
               	eor	x5, x5, x17
               	mov	x17, #0xf820            // =63520
               	movk	x17, #0x252c, lsl #16
               	and	x6, x0, x17
               	mov	x17, #0x55bb            // =21947
               	movk	x17, #0xc9c7, lsl #16
               	eor	x6, x6, x17
               	mov	x17, #0x5801            // =22529
               	movk	x17, #0x4020, lsl #16
               	and	x7, x0, x17
               	mov	x17, #0x3606            // =13830
               	movk	x17, #0x73fc, lsl #16
               	eor	x7, x7, x17
               	mov	x17, #0xf929            // =63785
               	movk	x17, #0xe220, lsl #16
               	and	x8, x0, x17
               	mov	x17, #0xa918            // =43288
               	movk	x17, #0xa2a0, lsl #16
               	eor	x8, x8, x17
               	mov	x17, #0xf9e1            // =63969
               	movk	x17, #0x44a3, lsl #16
               	and	x9, x0, x17
               	mov	x17, #0xbd90            // =48528
               	movk	x17, #0x8222, lsl #16
               	eor	x9, x9, x17
               	mov	x17, #0x104a            // =4170
               	movk	x17, #0x794f, lsl #16
               	and	x10, x0, x17
               	mov	x17, #0xac77            // =44151
               	movk	x17, #0xd6b6, lsl #16
               	eor	x10, x10, x17
               	mov	x17, #0x320b            // =12811
               	movk	x17, #0x26f, lsl #16
               	and	x11, x0, x17
               	mov	x17, #0x300c            // =12300
               	movk	x17, #0x3069, lsl #16
               	eor	x11, x11, x17
               	mov	x17, #0xb01a            // =45082
               	movk	x17, #0x7640, lsl #16
               	and	x12, x0, x17
               	mov	x17, #0xd5cc            // =54732
               	movk	x17, #0x6ce0, lsl #16
               	eor	x12, x12, x17
               	mov	x17, #0x1572            // =5490
               	movk	x17, #0x238f, lsl #16
               	and	x13, x0, x17
               	mov	x17, #0xa22d            // =41517
               	movk	x17, #0x59a9, lsl #16
               	eor	x13, x13, x17
               	mov	x17, #0xc083            // =49283
               	movk	x17, #0x7a63, lsl #16
               	and	x14, x0, x17
               	mov	x17, #0xbd4             // =3028
               	movk	x17, #0xac6d, lsl #16
               	eor	x14, x14, x17
               	mov	x17, #0xa000            // =40960
               	movk	x17, #0x11cc, lsl #16
               	and	x15, x0, x17
               	mov	x17, #0x3200            // =12800
               	movk	x17, #0x21c8, lsl #16
               	eor	x15, x15, x17
               	mov	x17, #0x69aa            // =27050
               	movk	x17, #0x202f, lsl #16
               	and	x20, x0, x17
               	mov	x17, #0x2188            // =8584
               	movk	x17, #0xa0e6, lsl #16
               	eor	x20, x20, x17
               	mov	x17, #0x3be9            // =15337
               	movk	x17, #0x51b3, lsl #16
               	and	x21, x0, x17
               	mov	x17, #0x655a            // =25946
               	movk	x17, #0xaf7d, lsl #16
               	eor	x21, x21, x17
               	mov	x17, #0xe8ae            // =59566
               	movk	x17, #0x3b0f, lsl #16
               	and	x22, x0, x17
               	mov	x17, #0x8aa3            // =35491
               	movk	x17, #0xf016, lsl #16
               	eor	x22, x22, x17
               	mov	x17, #0x8816            // =34838
               	movk	x17, #0x90bf, lsl #16
               	and	x23, x0, x17
               	mov	x17, #0x30c6            // =12486
               	movk	x17, #0x90aa, lsl #16
               	eor	x23, x23, x17
               	mov	x17, #0x4f9b            // =20379
               	movk	x17, #0x9e3, lsl #16
               	and	x24, x0, x17
               	mov	x17, #0x750a            // =29962
               	movk	x17, #0x5ab2, lsl #16
               	eor	x24, x24, x17
               	mov	x17, #0xbe88            // =48776
               	movk	x17, #0x103, lsl #16
               	and	x25, x0, x17
               	mov	x17, #0xbe65            // =48741
               	movk	x17, #0x5391, lsl #16
               	eor	x25, x25, x17
               	mov	x17, #0x8e25            // =36389
               	movk	x17, #0x49ac, lsl #16
               	and	x26, x0, x17
               	mov	x17, #0x2baf            // =11183
               	movk	x17, #0x9337, lsl #16
               	eor	x26, x26, x17
               	mov	x17, #0x313d            // =12605
               	movk	x17, #0x922c, lsl #16
               	and	x27, x0, x17
               	mov	x17, #0x210c            // =8460
               	movk	x17, #0xf288, lsl #16
               	eor	x27, x27, x17
               	mov	x17, #0x31b0            // =12720
               	movk	x17, #0x70ef, lsl #16
               	and	x28, x0, x17
               	mov	x17, #0xf5c0            // =62912
               	movk	x17, #0x920a, lsl #16
               	eor	x28, x28, x17
               	mov	x17, #0x7100            // =28928
               	movk	x17, #0x6a70, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x150]
               	ldr	x16, [sp, #0x150]
               	mov	x17, #0x12c0            // =4800
               	movk	x17, #0x63d3, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x148]
               	mov	x17, #0x9011            // =36881
               	movk	x17, #0xb97c, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x128]
               	ldr	x16, [sp, #0x128]
               	mov	x17, #0x3006            // =12294
               	movk	x17, #0x537b, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x120]
               	mov	x17, #0xc959            // =51545
               	movk	x17, #0xa320, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x100]
               	ldr	x16, [sp, #0x100]
               	mov	x17, #0xb0a5            // =45221
               	movk	x17, #0xa2ef, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xf8]
               	mov	x17, #0xab4a            // =43850
               	movk	x17, #0x6ea0, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0xd8]
               	ldr	x16, [sp, #0xd8]
               	mov	x17, #0x96a5            // =38565
               	movk	x17, #0xbc8f, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xd0]
               	mov	x17, #0xddf8            // =56824
               	movk	x17, #0x6953, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0xb0]
               	ldr	x16, [sp, #0xb0]
               	mov	x17, #0x76a5            // =30373
               	movk	x17, #0xfad1, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0xa8]
               	mov	x17, #0x3e2b            // =15915
               	movk	x17, #0xf74f, lsl #16
               	and	x16, x0, x17
               	str	x16, [sp, #0x88]
               	ldr	x16, [sp, #0x88]
               	mov	x17, #0x14a3            // =5283
               	movk	x17, #0x665a, lsl #16
               	eor	x16, x16, x17
               	str	x16, [sp, #0x80]
               	mov	x17, #0x6cad            // =27821
               	movk	x17, #0xf030, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xf0cc            // =61644
               	movk	x17, #0xf2ef, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	ldur	w17, [x29, #-0x10]
               	str	x17, [sp, #0x58]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	ldr	x16, [sp, #0x58]
               	and	x2, x16, x2
               	eor	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x4, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x5, x17
               	ldr	x16, [sp, #0x58]
               	and	x4, x16, x4
               	eor	x2, x2, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x6, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x7, x17
               	ldr	x16, [sp, #0x58]
               	and	x5, x16, x5
               	eor	x4, x4, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x8, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x9, x17
               	ldr	x16, [sp, #0x58]
               	and	x6, x16, x6
               	eor	x5, x5, x6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x10, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x11, x17
               	ldr	x16, [sp, #0x58]
               	and	x7, x16, x7
               	eor	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x13, x17
               	ldr	x16, [sp, #0x58]
               	and	x8, x16, x8
               	eor	x7, x7, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x15, x17
               	ldr	x16, [sp, #0x58]
               	and	x9, x16, x9
               	eor	x8, x8, x9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x22, x17
               	ldr	x16, [sp, #0x58]
               	and	x11, x16, x11
               	eor	x10, x10, x11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x24, x17
               	ldr	x16, [sp, #0x58]
               	and	x12, x16, x12
               	eor	x11, x11, x12
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x26, x17
               	ldr	x16, [sp, #0x58]
               	and	x13, x16, x13
               	eor	x12, x12, x13
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x28, x17
               	ldr	x16, [sp, #0x58]
               	and	x14, x16, x14
               	eor	x13, x13, x14
               	ldr	x16, [sp, #0x148]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x16, x17
               	ldr	x16, [sp, #0x120]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x16, x17
               	ldr	x16, [sp, #0x58]
               	and	x15, x16, x15
               	eor	x14, x14, x15
               	ldr	x16, [sp, #0xf8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x16, x17
               	ldr	x16, [sp, #0xd0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x16, x17
               	ldr	x16, [sp, #0x58]
               	and	x20, x16, x20
               	eor	x15, x15, x20
               	ldr	x16, [sp, #0xa8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x16, x17
               	ldr	x16, [sp, #0x80]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x16, x17
               	ldr	x16, [sp, #0x58]
               	and	x21, x16, x21
               	eor	x20, x20, x21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	ldur	w21, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	and	x2, x21, x2
               	eor	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x4, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x5, x17
               	and	x4, x21, x4
               	eor	x2, x2, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x6, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x7, x17
               	and	x5, x21, x5
               	eor	x4, x4, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x8, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x9, x17
               	and	x6, x21, x6
               	eor	x5, x5, x6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x10, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x11, x17
               	and	x7, x21, x7
               	eor	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x13, x17
               	and	x8, x21, x8
               	eor	x7, x7, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x15, x17
               	and	x9, x21, x9
               	eor	x8, x8, x9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	and	x0, x21, x0
               	eor	x0, x9, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	ldur	w9, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	and	x2, x9, x2
               	eor	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x4, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x5, x17
               	and	x4, x9, x4
               	eor	x2, x2, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x6, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x7, x17
               	and	x5, x9, x5
               	eor	x4, x4, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x8, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	and	x0, x9, x0
               	eor	x0, x5, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	ldur	w5, [x29, #-0x28]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	and	x2, x5, x2
               	eor	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x4, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	and	x0, x5, x0
               	eor	x0, x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	ldur	w2, [x29, #-0x30]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	and	x0, x2, x0
               	eor	x0, x1, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x0, x17
               	mov	x17, #0x4               // =4
               	and	x1, x1, x17
               	lsl	x1, x1, #3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	stur	w1, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x4000            // =16384
               	and	x4, x4, x17
               	lsl	x4, x4, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x4, x17
               	orr	x2, x2, x4
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x120             // =288
               	movk	x17, #0x1202, lsl #16
               	and	x4, x4, x17
               	mov	x5, #0x5                // =5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x4, x17
               	lsl	x6, x4, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	mov	x7, #0x20               // =32
               	sub	x5, x7, x5
               	sxtw	x5, w5
               	lsr	x4, x4, x5
               	orr	x4, x6, x4
               	orr	x2, x2, x4
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x100000          // =1048576
               	and	x4, x4, x17
               	lsl	x4, x4, #6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x4, x17
               	orr	x2, x2, x4
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x8000            // =32768
               	and	x4, x4, x17
               	lsl	x4, x4, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x4, x17
               	orr	x2, x2, x4
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x4000000         // =67108864
               	and	x4, x4, x17
               	lsr	x4, x4, #22
               	orr	x2, x2, x4
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	lsl	x4, x4, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x4, x17
               	orr	x2, x2, x4
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x0, x17
               	mov	x17, #0x200             // =512
               	movk	x17, #0x2000, lsl #16
               	and	x4, x4, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x4, x4, x17
               	lsl	x5, x4, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x5, x17
               	mov	x6, #0x20               // =32
               	sub	x3, x6, x3
               	sxtw	x3, w3
               	lsr	x3, x4, x3
               	orr	x3, x5, x3
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x200000          // =2097152
               	and	x3, x3, x17
               	lsr	x3, x3, #19
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x40              // =64
               	and	x3, x3, x17
               	lsl	x3, x3, #14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x10000           // =65536
               	and	x3, x3, x17
               	lsl	x3, x3, #15
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x2               // =2
               	and	x3, x3, x17
               	lsl	x3, x3, #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x1800            // =6144
               	movk	x17, #0x4080, lsl #16
               	and	x3, x3, x17
               	mov	x4, #0x11               // =17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	lsl	x5, x3, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x5, x17
               	mov	x6, #0x20               // =32
               	sub	x4, x6, x4
               	sxtw	x4, w4
               	lsr	x3, x3, x4
               	orr	x3, x5, x3
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x80000           // =524288
               	and	x3, x3, x17
               	lsr	x3, x3, #13
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x10              // =16
               	and	x3, x3, x17
               	lsl	x3, x3, #21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x1000000         // =16777216
               	and	x3, x3, x17
               	lsr	x3, x3, #10
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x8               // =8
               	movk	x17, #0x8800, lsl #16
               	and	x3, x3, x17
               	mov	x4, #0x18               // =24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	lsl	x5, x3, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x5, x5, x17
               	mov	x6, #0x20               // =32
               	sub	x4, x6, x4
               	sxtw	x4, w4
               	lsr	x3, x3, x4
               	orr	x3, x5, x3
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x0, x17
               	mov	x17, #0x480             // =1152
               	and	x3, x3, x17
               	lsr	x3, x3, #7
               	orr	x2, x2, x3
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	ldr	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x2000            // =8192
               	movk	x17, #0x44, lsl #16
               	and	x0, x0, x17
               	lsr	x0, x0, #6
               	orr	x0, x2, x0
               	str	w0, [x1]
               	ldur	w0, [x29, #-0x38]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x20, #0xa5a5            // =42405
               	movk	x20, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x21, x29, #0x8
               	ldr	w22, [x21]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	bl	<addr>
               	eor	x0, x22, x0
               	str	w0, [x21]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0x660d            // =26125
               	movk	x17, #0x19, lsl #16
               	mul	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xf35f            // =62303
               	movk	x17, #0x3c6e, lsl #16
               	add	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	b	<addr>
               	ldur	w0, [x29, #-0x8]
               	lsr	x1, x0, #8
               	eor	x1, x0, x1
               	lsr	x2, x0, #16
               	eor	x1, x1, x2
               	lsr	x0, x0, #24
               	eor	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
