
asm_goto_operand_region_paths.aarch64:	file format elf64-littleaarch64

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

<patched>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	w0, [x29, #-0x20]
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x8]
               	sxtw	x0, w0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	br	x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_goto>:
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x9                // =9
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	mov	x0, #0x9                // =9
               	strb	w0, [x1]
               	mov	x0, #0x7                // =7
               	strb	w0, [x1, #0x8]
               	mov	x16, #0x7               // =7
               	stur	x16, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x1]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	ldrb	w0, [x1]
               	ldrb	w1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x16, #0x2               // =2
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	and	x1, x0, #0xf
               	cbz	x1, <addr>
               	mov	x0, #0xff9c             // =65436
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	and	x0, x0, #0xf
               	cbz	x0, <addr>
               	mov	x0, #0xff9c             // =65436
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x10]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x18]
               	ldr	x1, [sp, #0x18]
               	mov	w0, w1
               	ldr	x16, [sp, #0x10]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x18]
               	str	x0, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x10]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x18]
               	ldr	x1, [sp, #0x18]
               	mov	w0, w1
               	ldr	x16, [sp, #0x10]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x18]
               	str	x0, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	b	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x0]
               	sxtw	x0, w0
               	str	x0, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
