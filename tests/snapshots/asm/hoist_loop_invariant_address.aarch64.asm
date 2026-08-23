
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
               	add	x0, x0, #0x0
               	mov	x5, #0x0                // =0
               	str	w5, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	str	w1, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	str	w1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x19               // =25
               	str	w1, [x0, #0x14]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x24               // =36
               	str	w1, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x31               // =49
               	str	w1, [x0, #0x1c]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	str	w1, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x51               // =81
               	str	w1, [x0, #0x24]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	str	x5, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xca07             // =51719
               	movk	x1, #0x3b9a, lsl #16
               	str	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x940e             // =37902
               	movk	x1, #0x7735, lsl #16
               	str	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5e15             // =24085
               	movk	x1, #0xb2d0, lsl #16
               	str	x1, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x281c             // =10268
               	movk	x1, #0xee6b, lsl #16
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xf223             // =61987
               	movk	x1, #0x2a05, lsl #16
               	movk	x1, #0x1, lsl #32
               	str	x1, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xbc2a             // =48170
               	movk	x1, #0x65a0, lsl #16
               	movk	x1, #0x1, lsl #32
               	str	x1, [x0, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8631             // =34353
               	movk	x1, #0xa13b, lsl #16
               	movk	x1, #0x1, lsl #32
               	str	x1, [x0, #0x38]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x5
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x6, x2, #4
               	add	x4, x3, x6
               	add	x1, x2, #0x1
               	str	w1, [x4]
               	cmp	w1, #0x18
               	b.ge	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	lsl	x1, x1, #4
               	add	x1, x3, x1
               	str	x1, [x4, #0x8]
               	b	<addr>
               	mov	x1, x5
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	mov	x4, #0xa                // =10
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x7, x20
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	b	<addr>
               	sxtw	x3, w0
               	mul	x0, x3, x5
               	asr	x0, x0, #34
               	lsr	x6, x0, #63
               	add	x0, x0, x6
               	mul	x6, x0, x4
               	sub	x3, x3, x6
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x1, x1, x3
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
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	mov	x5, #0x7                // =7
               	mov	x6, #0xc6c0             // =50880
               	movk	x6, #0x2d, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x8, #0x0                // =0
               	mov	x1, x8
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cmp	x0, #0x4
               	b.gt	<addr>
               	and	x3, x0, x5
               	sxtw	x3, w3
               	ldr	x3, [x2, x3, lsl #3]
               	smulh	x7, x3, x4
               	add	x3, x7, x3
               	asr	x3, x3, #29
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	x0, x6
               	b.lt	<addr>
               	add	x8, x8, #0x1
               	cmp	w8, #0x3
               	b.lt	<addr>
               	cmp	x1, #0x1e
               	b.eq	<addr>
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	mov	x5, #0x7                // =7
               	mov	x6, #0xc6c0             // =50880
               	movk	x6, #0x2d, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x8, #0x0                // =0
               	mov	x1, x8
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cmp	x0, #0x4
               	b.gt	<addr>
               	and	x3, x0, x5
               	sxtw	x3, w3
               	ldr	x3, [x2, x3, lsl #3]
               	smulh	x7, x3, x4
               	add	x3, x7, x3
               	asr	x3, x3, #29
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	x0, x6
               	b.lt	<addr>
               	add	x8, x8, #0x1
               	cmp	w8, #0x3
               	b.lt	<addr>
               	mov	x0, x9
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>
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
               	b	<addr>
               	ldrsw	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	mov	x0, x3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
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
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3e8
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, x0
               	b	<addr>
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
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xc8
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x5, #0x4000             // =16384
               	movk	x5, #0x3f80, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x3, x2, #2
               	add	x4, x1, x3
               	fmov	s16, w5
               	str	s16, [x4]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	ldr	s1, [x4]
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x4000             // =16384
               	movk	x0, #0x4180, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x3c]
               	mov	x0, #0x4000             // =16384
               	movk	x0, #0x3f80, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x5, #0x4000             // =16384
               	movk	x5, #0x3f80, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x3, x2, #2
               	add	x4, x1, x3
               	fmov	s16, w5
               	str	s16, [x4]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	ldr	s1, [x4]
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x3c]
               	fcvt	d1, s1
               	mov	x0, x6
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
