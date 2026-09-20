
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x200]
               	bl	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x210
               	sub	x17, x29, #0x210
               	str	wzr, [x17]
               	sub	x0, x29, #0x208
               	bl	<addr>
               	cbnz	w0, <addr>
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	add	x0, x0, #0x1
               	sub	x17, x29, #0x210
               	str	w0, [x17]
               	sub	x0, x29, #0x208
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x208
               	ldrsw	x0, [x0, #0x200]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
