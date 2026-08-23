
setjmp_longjmp.aarch64:	file format elf64-littleaarch64

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

<trigger>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x200]
               	bl	<addr>
               	uxtb	w0, w0
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	stp	x20, x21, [sp]
               	str	x19, [sp, #0x10]
               	mov	x21, #0x0               // =0
               	sub	x17, x29, #0x210
               	str	w21, [x17]
               	sub	x20, x29, #0x208
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	add	x0, x0, #0x1
               	sub	x17, x29, #0x210
               	str	w0, [x17]
               	mov	x1, #0x7                // =7
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0x200]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
