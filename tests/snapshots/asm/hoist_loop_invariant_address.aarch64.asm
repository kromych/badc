
hoist_loop_invariant_address.aarch64:	file format elf64-littleaarch64

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

<setup>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x4]
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0x8]
               	mov	x2, #0x9                // =9
               	str	w2, [x0, #0xc]
               	mov	x2, #0x10               // =16
               	str	w2, [x0, #0x10]
               	mov	x2, #0x19               // =25
               	str	w2, [x0, #0x14]
               	mov	x2, #0x24               // =36
               	str	w2, [x0, #0x18]
               	mov	x2, #0x31               // =49
               	str	w2, [x0, #0x1c]
               	mov	x2, #0x40               // =64
               	str	w2, [x0, #0x20]
               	mov	x2, #0x51               // =81
               	str	w2, [x0, #0x24]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	mov	x2, #0xca07             // =51719
               	movk	x2, #0x3b9a, lsl #16
               	str	x2, [x0, #0x8]
               	mov	x2, #0x940e             // =37902
               	movk	x2, #0x7735, lsl #16
               	str	x2, [x0, #0x10]
               	mov	x2, #0x5e15             // =24085
               	movk	x2, #0xb2d0, lsl #16
               	str	x2, [x0, #0x18]
               	mov	x2, #0x281c             // =10268
               	movk	x2, #0xee6b, lsl #16
               	str	x2, [x0, #0x20]
               	mov	x2, #0xf223             // =61987
               	movk	x2, #0x2a05, lsl #16
               	movk	x2, #0x1, lsl #32
               	str	x2, [x0, #0x28]
               	mov	x2, #0xbc2a             // =48170
               	movk	x2, #0x65a0, lsl #16
               	movk	x2, #0x1, lsl #32
               	str	x2, [x0, #0x30]
               	mov	x2, #0x8631             // =34353
               	movk	x2, #0xa13b, lsl #16
               	movk	x2, #0x1, lsl #32
               	str	x2, [x0, #0x38]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x1
               	lsl	x3, x0, #4
               	add	x3, x2, x3
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	cmp	w0, #0x18
               	b.ge	<addr>
               	lsl	x4, x0, #4
               	add	x4, x2, x4
               	b	<addr>
               	mov	x4, x1
               	str	x4, [x3, #0x8]
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x8, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x1, x3
               	cmp	w1, #0x0
               	b.le	<addr>
               	mul	x2, x1, x5
               	lsr	x2, x2, #32
               	mul	x7, x2, x4
               	sub	x1, x1, x7
               	ldrsw	x1, [x6, x1, lsl #2]
               	add	x0, x0, x1
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	sxtw	x0, w0
               	add	x8, x8, x0
               	add	x3, x3, #0x1
               	cmp	w3, #0x1f4
               	b.lt	<addr>
               	mov	x17, #0x7b0c            // =31500
               	cmp	x8, x17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x8
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x6, #0x0                // =0
               	mov	x1, x6
               	mov	x0, #0x0                // =0
               	ldr	x2, [x4, x0, lsl #3]
               	smulh	x5, x2, x3
               	add	x2, x5, x2
               	asr	x2, x2, #29
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x3
               	b.lt	<addr>
               	cmp	x1, #0x1e
               	b.eq	<addr>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x6, #0x0                // =0
               	mov	x1, x6
               	mov	x0, #0x0                // =0
               	ldr	x2, [x4, x0, lsl #3]
               	smulh	x5, x2, x3
               	add	x2, x5, x2
               	asr	x2, x2, #29
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x3
               	b.lt	<addr>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cbz	x0, <addr>
               	ldrsw	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	cmp	x1, #0x12c
               	b.eq	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cbz	x0, <addr>
               	ldrsw	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	mov	x0, x3
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3e8
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3e8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x2, x0
               	ldrsw	x3, [x1]
               	add	x2, x2, x3
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x2
               	str	w3, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x64
               	b.lt	<addr>
               	mov	x17, #0x26ac            // =9900
               	cmp	x2, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xc8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x58]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	lsl	x1, x0, #2
               	add	x1, x2, x1
               	str	s1, [x1]
               	ldr	s2, [x1]
               	fadd	s0, s0, s2
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x5c]
               	fcmp	s0, s1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x3c]
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x58]
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x58]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	lsl	x1, x0, #2
               	add	x1, x2, x1
               	str	s1, [x1]
               	ldr	s2, [x1]
               	fadd	s0, s0, s2
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fcvt	d0, s0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x3c]
               	fcvt	d1, s1
               	mov	x0, x3
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
