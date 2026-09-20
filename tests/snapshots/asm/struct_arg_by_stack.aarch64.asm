
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
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x3, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x4, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x5, [x4]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x6, [x5]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x7, [x6]
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x0, [x1]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	ldr	x0, [x2]
               	cmp	x0, #0x16
               	b.ne	<addr>
               	ldr	x0, [x3]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	ldr	x0, [x4]
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x5]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldr	x0, [x6]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
