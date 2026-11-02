
const_scalar_load_folds.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x1, #0x63               // =99
               	str	x1, [x0, #0x18]
               	mov	x0, #0x0                // =0
               	ret
