
many_args_host_stack_overflow.aarch64:	file format elf64-littleaarch64

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

<sum_eleven>:
               	sub	sp, sp, #0x30
               	ldr	x16, [sp, #0x30]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x38]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x40]
               	str	x16, [sp, #0x20]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w4, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w5, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w6, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	w7, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	ldursw	x0, [x29, #0x90]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	ldursw	x0, [x29, #0xa0]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	ldursw	x0, [x29, #0xb0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
