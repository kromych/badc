
aligned_member.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xd0
               	sub	x0, x29, #0xd0
               	add	x1, x0, #0x10
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x1, x0, #0x14
               	sub	x0, x1, x0
               	cmp	x0, #0x14
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb0
               	add	x1, x0, #0x10
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x90
               	add	x2, x1, #0x10
               	sub	x1, x2, x1
               	cmp	x1, #0x10
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7788             // =30600
               	movk	x1, #0x5566, lsl #16
               	movk	x1, #0x3344, lsl #32
               	movk	x1, #0x1122, lsl #48
               	str	x1, [x0, #0x10]
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	str	x2, [x0, #0x18]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
