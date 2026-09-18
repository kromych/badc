
struct_return_to_global.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0x6                // =6
               	mov	x3, #0x1                // =1
               	str	x1, [x6]
               	str	x3, [x6, #0x8]
               	mov	x4, #0xa                // =10
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	lsl	x2, x1, #4
               	add	x2, x5, x2
               	mul	x1, x1, x4
               	sxtw	x1, w1
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	x1, x0, #0x7
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x30
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x0, x1, x0
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	str	x1, [x6]
               	str	x2, [x6, #0x8]
               	ldr	x1, [x6]
               	ldr	x2, [x6, #0x8]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	cmp	x0, #0x4e
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
