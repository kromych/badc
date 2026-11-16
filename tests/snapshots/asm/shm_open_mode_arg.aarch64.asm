
shm_open_mode_arg.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	bl	<addr>
               	mov	x2, x0
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	mov	x1, #0xc2               // =194
               	mov	x2, #0x180              // =384
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x1, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	bl	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldur	w0, [x29, #-0x70]
               	and	x0, x0, #0x1ff
               	mov	x1, #0x3                // =3
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x180
               	csel	x21, x1, x2, ne
               	b	<addr>
