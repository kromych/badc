
inline_stack_passed_params.aarch64:	file format elf64-littleaarch64

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

<relay_out_of_line>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxth	x4, w4
               	sxtb	x6, w6
               	and	x5, x5, #0xff
               	ldrsw	x8, [x29, #0x10]
               	ldr	x9, [x29, #0x18]
               	ldr	x10, [x29, #0x20]
               	adrp	x11, <page>
               	ldrsw	x11, [x11, #0xc]
               	cmp	w0, w11
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	add	x2, x0, #0x14
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x20]
               	cmp	w3, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	ldrsh	x0, [x0, #0x24]
               	cmp	w4, w0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x26]
               	cmp	w5, w0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	ldrsb	x0, [x0, #0x27]
               	cmp	w6, w0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	and	x0, x7, #0xffff
               	adrp	x1, <page>
               	ldrh	w1, [x1, #0x28]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x2c]
               	cmp	w8, w0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x9, x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x38]
               	cmp	w10, w0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	w0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #-0x2               // =-2
               	mov	x2, #0x7788             // =30600
               	movk	x2, #0x5566, lsl #16
               	movk	x2, #0x3344, lsl #32
               	movk	x2, #0x1122, lsl #48
               	mov	x3, #0x3                // =3
               	movk	x3, #0xf000, lsl #16
               	mov	x4, #-0x5               // =-5
               	mov	x5, #0xfa               // =250
               	mov	x6, #-0x7               // =-7
               	mov	x7, #0xea60             // =60000
               	movk	x7, #0x1111, lsl #16
               	movk	x7, #0x1111, lsl #32
               	adrp	x8, <page>
               	ldr	x9, [x8, #0x40]
               	mov	x16, #0x9               // =9
               	str	x16, [sp]
               	mov	x16, #-0xa              // =-10
               	str	x16, [sp, #0x8]
               	mov	x16, #0xdef0            // =57072
               	movk	x16, #0x9abc, lsl #16
               	movk	x16, #0x5678, lsl #32
               	movk	x16, #0x1234, lsl #48
               	str	x16, [sp, #0x10]
               	blr	x9
               	cbz	w0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x10]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x20]
               	mov	x17, #0x3               // =3
               	movk	x17, #0xf000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	ldrsh	x0, [x0, #0x24]
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x26]
               	cmp	w0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	ldrsb	x0, [x0, #0x27]
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	adrp	x0, <page>
               	ldrh	w0, [x0, #0x28]
               	mov	x17, #0xea60            // =60000
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x2c]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x17, #-0xa              // =-10
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x38]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
