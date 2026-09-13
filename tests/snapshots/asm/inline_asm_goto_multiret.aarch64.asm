
inline_asm_goto_multiret.aarch64:	file format elf64-littleaarch64

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
               	b	<addr>
               	mov	x0, #0x3                // =3
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	nop
               	mov	x0, #0x5                // =5
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x8                // =8
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, #0xa
               	b.ne	<addr>
               	cmp	x0, #0x16
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0x2
               	str	x1, [x0, #0x8]
               	b	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
