
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	mov	x2, #0x1                // =1
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	x6, x1, x2
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	lsl	x1, x0, #4
               	add	x1, x4, x1
               	mul	x5, x0, x3
               	sxtw	x5, w5
               	str	x5, [x1]
               	str	x2, [x1, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	add	x2, x6, x1
               	add	x1, x0, #0x10
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x2, x2, x1
               	add	x1, x0, #0x20
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x3, x1
               	add	x1, x2, x1
               	add	x0, x0, #0x30
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x3, x1, x0
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	str	x1, [x2, #0x8]
               	add	x0, x0, x1
               	add	x0, x3, x0
               	cmp	x0, #0x4e
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
