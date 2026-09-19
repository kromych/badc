
indirect_call_ten_scalar_args.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x0]
               	add	x1, x0, #0x1
               	add	x2, x0, #0x2
               	add	x3, x0, #0x3
               	add	x4, x0, #0x4
               	add	x5, x0, #0x5
               	add	x6, x0, #0x6
               	add	x7, x0, #0x7
               	add	x8, x0, #0x8
               	add	x9, x0, #0x9
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	lsl	x1, x7, #3
               	add	x0, x0, x1
               	mov	x17, #0x9               // =9
               	mul	x1, x8, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x9, x17
               	add	x0, x0, x1
               	cmp	x0, #0x181
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
