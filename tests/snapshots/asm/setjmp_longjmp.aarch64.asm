
setjmp_longjmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x1, w1
               	str	w1, [x0, #0x200]
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x240
               	str	x19, [sp]
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x210
               	str	w0, [x17]
               	sub	x0, x29, #0x208
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.ne	<addr>
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	add	x0, x0, #0x1
               	sub	x17, x29, #0x210
               	str	w0, [x17]
               	sub	x0, x29, #0x208
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x208
               	ldrsw	x0, [x0, #0x200]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
