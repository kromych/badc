
aligned_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	sp, sp, #0x60
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	mov	x0, sp
               	add	x0, x0, #0x10
               	mov	x1, sp
               	sub	x0, x0, x1
               	cmp	x0, #0x10
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, sp
               	add	x0, x0, #0x14
               	mov	x1, sp
               	sub	x0, x0, x1
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x20
               	add	x0, x0, #0x10
               	add	x1, sp, #0x20
               	sub	x0, x0, x1
               	cmp	x0, #0x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x40
               	add	x0, x0, #0x10
               	add	x1, sp, #0x40
               	sub	x0, x0, x1
               	cmp	x0, #0x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x20
               	mov	x1, #0x7788             // =30600
               	movk	x1, #0x5566, lsl #16
               	movk	x1, #0x3344, lsl #32
               	movk	x1, #0x1122, lsl #48
               	str	x1, [x0, #0x10]
               	add	x0, sp, #0x20
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0, #0x18]
               	add	x0, sp, #0x20
               	ldr	x0, [x0, #0x10]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x20
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
