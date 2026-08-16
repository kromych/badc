
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
               	sub	sp, sp, #0x30
               	ldr	x16, [sp, #0x30]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x38]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x40]
               	str	x16, [sp, #0x20]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x8, x0
               	sxth	x4, w4
               	sxtb	x6, w6
               	mov	w3, w3
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	ldursw	x0, [x29, #0x90]
               	ldur	x9, [x29, #0xa0]
               	ldur	x10, [x29, #0xb0]
               	sxtw	x8, w8
               	sxtw	x1, w1
               	sxth	x4, w4
               	sxtb	x6, w6
               	adrp	x11, <page>
               	add	x11, x11, <lo12>
               	ldrsw	x11, [x11]
               	cmp	x8, x11
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldrsw	x8, [x8]
               	cmp	x1, x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	w1, w3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsh	x1, [x1]
               	cmp	x4, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x1, x5, x17
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsb	x1, [x1]
               	cmp	x6, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x1, x7, x17
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrh	w2, [x2]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x0, x1
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
               	mov	w0, w10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0xfffe             // =65534
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x7788             // =30600
               	movk	x3, #0x5566, lsl #16
               	movk	x3, #0x3344, lsl #32
               	movk	x3, #0x1122, lsl #48
               	mov	x4, #0x3                // =3
               	movk	x4, #0xf000, lsl #16
               	mov	x5, #0xfffb             // =65531
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x6, #0xfa               // =250
               	mov	x7, #0xfff9             // =65529
               	movk	x7, #0xffff, lsl #16
               	movk	x7, #0xffff, lsl #32
               	movk	x7, #0xffff, lsl #48
               	mov	x8, #0xea60             // =60000
               	movk	x8, #0x1111, lsl #16
               	movk	x8, #0x1111, lsl #32
               	mov	x9, #0x9                // =9
               	mov	x10, #0xfff6            // =65526
               	movk	x10, #0xffff, lsl #16
               	movk	x10, #0xffff, lsl #32
               	movk	x10, #0xffff, lsl #48
               	mov	x11, #0xdef0            // =57072
               	movk	x11, #0x9abc, lsl #16
               	movk	x11, #0x5678, lsl #32
               	movk	x11, #0x1234, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x12, x0
               	sub	sp, sp, #0x20
               	str	x9, [sp]
               	str	x10, [sp, #0x8]
               	str	x11, [sp, #0x10]
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	mov	x6, x7
               	mov	x7, x8
               	blr	x12
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
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
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	x0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	mov	x17, #0xea60            // =60000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0xfff6            // =65526
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
