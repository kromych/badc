
predefined_constants.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	b	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	b	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	b	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	b	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	b	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
