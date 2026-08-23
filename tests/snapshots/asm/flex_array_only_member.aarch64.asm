
flex_array_only_member.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x10]
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x18]
               	ldr	x1, [x0, #0x10]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x4
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
