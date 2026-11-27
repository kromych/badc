
struct_conditional_reads_its_arm.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<pick>:
               	cmp	w1, #0x0
               	mov	x16, #0x9               // =9
               	mov	x17, #0x8               // =8
               	csel	x0, x16, x17, ne
               	ret

<sum>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	tbz	w0, #0x0, <addr>
               	ldr	x1, [x3, x0, lsl #3]
               	orr	x1, x1, #0x1
               	b	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	b	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x0, #0x8                // =8
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0xa2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
