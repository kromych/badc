
xsi_interfaces_reach_the_c_library.aarch64:	file format elf64-littleaarch64

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

<visit>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x2
               	mov	x20, x3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ldrsw	x1, [x20]
               	cmp	w1, #0x0
               	b.le	<addr>
               	ldrsw	x1, [x20]
               	add	x22, x0, x1
               	ldrsw	x1, [x20, #0x4]
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	w21, #0x5
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldrsw	x1, [x20, #0x4]
               	cmp	w1, #0x0
               	cset	x1, eq
               	str	w1, [x2]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0x2f               // =47
               	bl	<addr>
               	add	x1, x0, #0x1
               	b	<addr>

<files>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1b0
               	str	x20, [sp]
               	sub	x0, x29, #0x1a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x180
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x180
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	mov	x1, #0x60               // =96
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x180
               	bl	<addr>
               	sub	x0, x29, #0xe0
               	mov	x1, #0x60               // =96
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x180
               	bl	<addr>
               	sub	x0, x29, #0x140
               	mov	x1, #0x1180             // =4480
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #-0x64              // =-100
               	sub	x1, x29, #0xe0
               	mov	x2, #0x1180             // =4480
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x70]
               	and	x0, x0, #0xf000
               	mov	x17, #0x1000            // =4096
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0x1a0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x180
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.lt	<addr>
               	sub	x1, x29, #0x1a0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	sub	x0, x29, #0x180
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	mov	x3, #0x9                // =9
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	bl	<addr>
               	sub	x0, x29, #0x180
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret

<numbers>:
               	str	d8, [sp, #-0x90]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldrh	w16, [x1, #0x4]
               	strh	w16, [x0, #0x4]
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldrh	w16, [x1, #0x4]
               	strh	w16, [x0, #0x4]
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldrh	w16, [x1, #0xc]
               	strh	w16, [x0, #0xc]
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	movi	d0, #0000000000000000
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	fmov	d0, d1
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret
               	fmov	d0, #1.00000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x98]
               	fsub	d0, d0, d1
               	fabs	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xa0]
               	fcmp	d0, d1
               	b.gt	<addr>
               	fmov	d0, #1.00000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xa8]
               	fadd	d0, d0, d1
               	fabs	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xa0]
               	fcmp	d0, d1
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	fmov	d0, #1.00000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xb0]
               	fadd	d0, d0, d1
               	fabs	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xa0]
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x40
               	b.ne	<addr>
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	fmov	d8, d0
               	movi	d0, #0000000000000000
               	fcmp	d8, d0
               	b.mi	<addr>
               	fmov	d0, #1.00000000
               	fcmp	d8, d0
               	b.ge	<addr>
               	bl	<addr>
               	fcmp	d8, d0
               	b.ne	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	cmp	x20, x0
               	b.ne	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret
               	sub	x0, x29, #0x50
               	bl	<addr>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x40
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	cbz	x0, <addr>
               	bl	<addr>
               	sub	x1, x29, #0x40
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x90
               	ret

<strings_and_process>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x0, x29, #0x18
               	str	xzr, [x0]
               	sub	x1, x29, #0x10
               	str	wzr, [x1]
               	strb	wzr, [x1, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2c               // =44
               	mov	x3, #0x8                // =8
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x18
               	add	x2, x0, #0x3
               	cmp	x1, x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x1, x0
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x17, #-0x14             // =-20
               	cmp	w20, w17
               	b.lt	<addr>
               	cmp	w20, #0x14
               	b.gt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	bl	<addr>
               	bl	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x4]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<signals>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x22               // =34
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
