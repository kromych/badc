
scope_exit_storage.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	mul	x4, x1, x3
               	add	x4, x4, x2
               	and	x4, x4, #0xff
               	strb	w4, [x0, x2]
               	add	x2, x2, #0x1
               	cmp	w2, #0x200
               	b.lt	<addr>
               	str	w1, [x0, #0x200]
               	mvn	x1, x1
               	str	w1, [x0, #0x204]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<intact>:
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	ldrb	w4, [x0, x2]
               	mul	x5, x1, x3
               	add	x5, x5, x2
               	and	x5, x5, #0xff
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x200
               	b.lt	<addr>
               	ldr	w2, [x0, #0x200]
               	cmp	w2, w1
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldr	w0, [x0, #0x204]
               	mvn	x1, x1
               	cmp	w0, w1
               	cset	x2, eq
               	mov	x0, x2
               	ret
               	mov	x0, #0x0                // =0
               	ret

<release>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	ldr	x0, [x0]
               	ldr	w1, [x0, #0x200]
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret

<crc_shape>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x220
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	sub	x0, x29, #0x220
               	stur	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x10
               	bl	<addr>
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	b	<addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	sub	x0, x29, #0x220
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	sub	x0, x29, #0x220
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0x220
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x220
               	stur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x2               // =2
               	b	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	b	<addr>

<goto_exits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x440
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sxtw	x23, w0
               	sub	x0, x29, #0x420
               	mov	x1, #0x82               // =130
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x3
               	b.ge	<addr>
               	sub	x21, x29, #0x210
               	add	x22, x20, #0x83
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x23, <addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x8c               // =140
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x8c               // =140
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	mov	x1, #0x82               // =130
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	b	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x85               // =133
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_exits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x800              // =2048
               	mov	x3, #0x2000             // =8192
               	mov	x1, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x1
               	mov	x4, sp
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x5, sp
               	sub	x5, x5, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x5
               	and	x7, x1, #0xff
               	strb	w7, [x5]
               	ldrb	w5, [x5]
               	str	w5, [x6]
               	tbz	w1, #0x0, <addr>
               	mov	sp, x4
               	b	<addr>
               	add	x0, x0, #0x1
               	mov	sp, x4
               	add	x1, x1, #0x1
               	cmp	w1, w3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x6, sp
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x4, sp
               	sub	x4, x4, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x4
               	and	x7, x1, #0xff
               	strb	w7, [x4, #0x7ff]
               	ldrb	w4, [x4, #0x7ff]
               	str	w4, [x5]
               	add	x0, x0, #0x1
               	mov	sp, x6
               	add	x1, x1, #0x1
               	cmp	w1, w3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x4, sp
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x5, sp
               	sub	x5, x5, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x5
               	and	x7, x1, #0xff
               	strb	w7, [x5]
               	ldrb	w5, [x5]
               	str	w5, [x6]
               	tbz	w1, #0x0, <addr>
               	mov	sp, x4
               	b	<addr>
               	add	x0, x0, #0x1
               	mov	sp, x4
               	add	x1, x1, #0x1
               	cmp	w1, w3
               	b.lt	<addr>
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<touch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x40
               	and	x0, x0, #0xff
               	strb	w0, [x1]
               	ldrb	w1, [x1]
               	sub	x0, x1, x0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_entered_by_goto>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, #0x800             // =2048
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	cbz	w20, <addr>
               	tbnz	w20, #0x0, <addr>
               	add	x0, x0, #0x1
               	add	x22, x0, #0x2
               	mov	x1, sp
               	add	x17, x21, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	mov	x0, #0x5                // =5
               	strb	w0, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w0, [x2]
               	mov	sp, x1
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x0
               	add	x20, x20, #0x1
               	cmp	w20, #0x3e8
               	b.lt	<addr>
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x440
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	eor	x0, x0, #0x2
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	sub	x21, x29, #0x210
               	add	x22, x20, #0x65
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	w0, <addr>
               	cmp	w20, #0x1
               	b.eq	<addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x6
               	b.lt	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x78               // =120
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x78               // =120
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xb                // =11
               	cbz	x0, <addr>
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x96               // =150
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x97               // =151
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x97               // =151
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1e               // =30
               	cbz	x0, <addr>
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	mov	x1, #0x96               // =150
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x98               // =152
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x98               // =152
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1f               // =31
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x96               // =150
               	bl	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x96               // =150
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	mov	x0, #0x800              // =2048
               	mov	x1, #0x2000             // =8192
               	bl	<addr>
               	mov	x17, #0x4000            // =16384
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x800              // =2048
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	cmp	w0, #0x9c3
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x440
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	b	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x96               // =150
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x98               // =152
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x98               // =152
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1f               // =31
               	b	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x96               // =150
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
