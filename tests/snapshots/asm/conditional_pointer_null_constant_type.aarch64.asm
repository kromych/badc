
conditional_pointer_null_constant_type.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x2, #0x2a               // =42
               	str	w2, [x0, #0x10]
               	mov	x2, x0
               	ldrsw	x2, [x2, #0x10]
               	cmp	x2, #0x2a
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	ldrsw	x1, [x1, #0x10]
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	ldrsw	x1, [x1, #0x10]
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x0, <addr>
               	mov	x1, x0
               	ldrsw	x1, [x1, #0x10]
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
