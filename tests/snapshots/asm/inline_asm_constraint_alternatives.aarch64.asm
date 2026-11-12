
inline_asm_constraint_alternatives.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x14              // =20
               	mov	x17, #0x5               // =5
               	add	x0, x16, x17
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x3               // =3
               	mov	x17, #0x4               // =4
               	add	x0, x16, x17
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x16, #0x1               // =1
               	add	x0, x16, #0x7
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0xa                // =10
               	mov	x16, #0x20              // =32
               	add	x0, x0, x16
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2a               // =42
               	ret
