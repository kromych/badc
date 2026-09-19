
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
               	mov	x4, #0x0                // =0
               	str	w4, [x0]
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x4]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x8]
               	mov	x1, #0x9                // =9
               	str	w1, [x0, #0xc]
               	mov	x1, #0x10               // =16
               	str	w1, [x0, #0x10]
               	mov	x1, #0x19               // =25
               	str	w1, [x0, #0x14]
               	mov	x1, #0x24               // =36
               	str	w1, [x0, #0x18]
               	mov	x1, #0x31               // =49
               	str	w1, [x0, #0x1c]
               	mov	x1, #0x40               // =64
               	str	w1, [x0, #0x20]
               	mov	x1, #0x51               // =81
               	str	w1, [x0, #0x24]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x4, [x0]
               	mov	x1, #0xca07             // =51719
               	movk	x1, #0x3b9a, lsl #16
               	str	x1, [x0, #0x8]
               	mov	x1, #0x940e             // =37902
               	movk	x1, #0x7735, lsl #16
               	str	x1, [x0, #0x10]
               	mov	x1, #0x5e15             // =24085
               	movk	x1, #0xb2d0, lsl #16
               	str	x1, [x0, #0x18]
               	mov	x1, #0x281c             // =10268
               	movk	x1, #0xee6b, lsl #16
               	str	x1, [x0, #0x20]
               	mov	x1, #0xf223             // =61987
               	movk	x1, #0x2a05, lsl #16
               	movk	x1, #0x1, lsl #32
               	str	x1, [x0, #0x28]
               	mov	x1, #0xbc2a             // =48170
               	movk	x1, #0x65a0, lsl #16
               	movk	x1, #0x1, lsl #32
               	str	x1, [x0, #0x30]
               	mov	x1, #0x8631             // =34353
               	movk	x1, #0xa13b, lsl #16
               	movk	x1, #0x1, lsl #32
               	str	x1, [x0, #0x38]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x4
               	cmp	w0, #0x18
               	b.ge	<addr>
               	lsl	x5, x0, #4
               	add	x3, x2, x5
               	add	x1, x0, #0x1
               	str	w1, [x3]
               	cmp	w1, #0x18
               	b.ge	<addr>
               	lsl	x5, x1, #4
               	add	x5, x2, x5
               	b	<addr>
               	mov	x5, x4
               	str	x5, [x3, #0x8]
               	mov	x0, x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x7, x20
               	cmp	w20, #0x1f4
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	cmp	w0, #0x0
               	b.le	<addr>
               	mul	x3, x0, x5
               	lsr	x3, x3, #32
               	mul	x6, x3, x4
               	sub	x0, x0, x6
               	ldrsw	x0, [x2, x0, lsl #2]
               	add	x1, x1, x0
               	mov	x0, x3
               	cmp	w0, #0x0
               	b.gt	<addr>
               	sxtw	x0, w1
               	add	x7, x7, x0
               	add	x20, x20, #0x1
               	cmp	w20, #0x1f4
               	b.lt	<addr>
               	mov	x17, #0x7b0c            // =31500
               	cmp	x7, x17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x7
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x6, #0x0                // =0
               	mov	x1, x6
               	cmp	w6, #0x3
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.gt	<addr>
               	ldr	x3, [x2, x0, lsl #3]
               	smulh	x5, x3, x4
               	add	x3, x5, x3
               	asr	x3, x3, #29
               	lsr	x5, x3, #63
               	add	x3, x3, x5
               	add	x1, x1, x3
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
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x6, #0x0                // =0
               	mov	x1, x6
               	cmp	w6, #0x3
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.gt	<addr>
               	ldr	x3, [x2, x0, lsl #3]
               	smulh	x5, x3, x4
               	add	x3, x5, x3
               	asr	x3, x3, #29
               	lsr	x5, x3, #63
               	add	x3, x3, x5
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x3
               	b.lt	<addr>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x3e8
               	b.ge	<addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x2, x0
               	cmp	w0, #0x64
               	b.ge	<addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x2, #0x0                // =0
               	mov	x4, #0x4000             // =16384
               	movk	x4, #0x3f80, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x17, #0x0               // =0
               	fmov	s0, w17
               	cmp	w0, #0x10
               	b.ge	<addr>
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	fmov	s16, w4
               	str	s16, [x3]
               	ldr	s1, [x3]
               	fadd	s0, s0, s1
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x4000             // =16384
               	movk	x0, #0x4180, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x3c]
               	mov	x0, #0x4000             // =16384
               	movk	x0, #0x3f80, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x0                // =0
               	mov	x4, #0x4000             // =16384
               	movk	x4, #0x3f80, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x17, #0x0               // =0
               	fmov	s0, w17
               	cmp	w0, #0x10
               	b.ge	<addr>
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	fmov	s16, w4
               	str	s16, [x3]
               	ldr	s1, [x3]
               	fadd	s0, s0, s1
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fcvt	d0, s0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x3c]
               	fcvt	d1, s1
               	mov	x0, x5
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
