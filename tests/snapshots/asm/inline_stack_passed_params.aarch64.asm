
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
               	add	x11, x11, <lo12>
               	ldrsw	x11, [x11]
               	cmp	w0, w11
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x14
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cmp	w3, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	cmp	w4, w0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	w5, w0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	cmp	w6, w0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	and	x0, x7, #0xffff
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w8, w0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x9, x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cmp	w10, w0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	w0, <addr>
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
               	mov	x8, #0x9                // =9
               	mov	x9, #-0xa               // =-10
               	mov	x10, #0xdef0            // =57072
               	movk	x10, #0x9abc, lsl #16
               	movk	x10, #0x5678, lsl #32
               	movk	x10, #0x1234, lsl #48
               	adrp	x11, <page>
               	add	x11, x11, <lo12>
               	ldr	x11, [x11]
               	sub	sp, sp, #0x20
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	str	x10, [sp, #0x10]
               	blr	x11
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x3               // =3
               	movk	x17, #0xf000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	w0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	mov	x17, #0xea60            // =60000
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #-0xa              // =-10
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
