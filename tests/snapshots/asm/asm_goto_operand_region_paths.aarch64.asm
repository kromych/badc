
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
               	adr	x0, <addr>
               	mov	x16, #0x3               // =3
               	br	x0
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret

<vla_goto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x9                // =9
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	mov	x1, #0x9                // =9
               	strb	w1, [x0]
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x8]
               	mov	x16, #0x7               // =7
               	cbnz	w16, <addr>
               	ldrb	w0, [x0]
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	ldrb	w0, [x0, #0x8]
               	add	x0, x1, x0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x2               // =2
               	cbnz	w16, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	cbnz	w16, <addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	cbnz	w16, <addr>
               	mov	x16, #0x1               // =1
               	cbnz	w16, <addr>
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	and	x1, x0, #0xf
               	cbz	w1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0]
               	sxtw	x0, w0
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	w0, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	xzr, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	mov	x16, #0x0               // =0
               	cbnz	w16, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x16, #0x6               // =6
               	mov	w0, w16
               	sxtw	x1, w0
               	cbnz	w1, <addr>
               	cmp	w0, #0x8
               	b.ne	<addr>
               	mov	x16, #0x0               // =0
               	mov	w0, w16
               	sxtw	x1, w0
               	cbnz	w1, <addr>
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x2
               	b	<addr>
               	add	x0, x0, #0x2
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x0, x1, x0
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x0, x1, x0
               	b	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
