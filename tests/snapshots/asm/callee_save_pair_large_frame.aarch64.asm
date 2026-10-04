
callee_save_pair_large_frame.aarch64:	file format elf64-littleaarch64

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

<sink>:
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	sub	x2, x0, #0x1
               	add	x1, x1, x0
               	mov	x0, x2
               	cmp	w0, #0x0
               	b.gt	<addr>
               	add	x0, x1, #0x1
               	ret

<bigframe>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x0, x21
               	add	x0, x0, x20
               	add	x0, x0, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x0, x0, #0x4
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	ldp	x29, x30, [sp], #0x10
               	ret
