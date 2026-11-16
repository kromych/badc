
struct_arg_by_stack.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0xb                // =11
               	mov	x3, #0x16               // =22
               	mov	x4, #0x21               // =33
               	mov	x5, #0x2c               // =44
               	mov	x6, #0x5                // =5
               	mov	x7, #0x6                // =6
               	mov	x1, #0x7                // =7
               	adrp	x0, <page>
               	str	x1, [x0, #0x20]
               	adrp	x1, <page>
               	str	x2, [x1, #0x28]
               	adrp	x2, <page>
               	str	x3, [x2, #0x30]
               	adrp	x3, <page>
               	str	x4, [x3, #0x38]
               	adrp	x4, <page>
               	str	x5, [x4, #0x40]
               	adrp	x5, <page>
               	str	x6, [x5, #0x48]
               	adrp	x6, <page>
               	str	x7, [x6, #0x50]
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x0, [x1, #0x28]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	ldr	x0, [x2, #0x30]
               	cmp	x0, #0x16
               	b.ne	<addr>
               	ldr	x0, [x3, #0x38]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	ldr	x0, [x4, #0x40]
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x5, #0x48]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
