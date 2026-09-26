
thread_local_aggregate_initializers.aarch64:	file format elf64-littleaarch64

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

<seven>:
               	mov	x0, #0x7                // =7
               	ret

<counter>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x78
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x80
               	ldr	x1, [x1, #0x8]
               	ldrb	w1, [x1, #0x1]
               	add	x0, x0, x1
               	ret

<first>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x98
               	ldrsw	x1, [x0]
               	add	x2, x1, #0x1
               	str	w2, [x0]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x90
               	ldr	x0, [x0]
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<check>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x73              // =115
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	blr	x0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x50
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0x65              // =101
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x4]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x58
               	ldr	d0, [x0, #0x18]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x11]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0x9a
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	mov	x2, #0x0                // =0
               	mov	x0, #0x64               // =100
               	str	w0, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x30
               	str	w0, [x1]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x58
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x16
               	str	d0, [x0, #0x8]
               	mov	x0, x2
               	ldp	x29, x30, [sp], #0x10
               	ret

<thread_main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	x0, x0, #0xa
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	w0, #0x64
               	b.ne	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldrsw	x0, [x0]
               	cmp	w0, #0x64
               	b.ne	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x58
               	ldr	d0, [x0, #0x8]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
