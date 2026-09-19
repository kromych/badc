
clock_monotonic_advances.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x20
               	mov	x0, #-0x1               // =-1
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	mov	x2, #0x4240             // =16960
               	movk	x2, #0xf, lsl #16
               	cmp	w0, w2
               	b.ge	<addr>
               	ldursw	x1, [x29, #-0x28]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x28]
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	sub	x1, x29, #0x20
               	ldr	x3, [x1]
               	cmp	x2, x3
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
