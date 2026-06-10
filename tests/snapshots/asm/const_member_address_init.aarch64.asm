
const_member_address_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldr	x1, [x0, #0x20]
               	add	x2, x0, #0x10
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x38]
               	add	x2, x0, #0x28
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x38]
               	add	x0, x0, #0x28
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
