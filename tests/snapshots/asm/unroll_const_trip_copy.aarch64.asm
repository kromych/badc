
unroll_const_trip_copy.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x10]
               	mov	x1, #0xa                // =10
               	str	x1, [x0, #0x18]
               	mov	x1, #0xd                // =13
               	str	x1, [x0, #0x20]
               	mov	x1, #0x10               // =16
               	str	x1, [x0, #0x28]
               	mov	x1, #0x13               // =19
               	str	x1, [x0, #0x30]
               	mov	x1, #0x16               // =22
               	str	x1, [x0, #0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [sp], #0x10
               	ldr	x0, [x1, #0x8]
               	ldr	x2, [x1, #0x10]
               	lsl	x2, x2, #1
               	add	x0, x0, x2
               	ldr	x2, [x1, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldr	x2, [x1, #0x20]
               	lsl	x2, x2, #2
               	add	x0, x0, x2
               	ldr	x2, [x1, #0x28]
               	mov	x17, #0x5               // =5
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldr	x2, [x1, #0x30]
               	mov	x17, #0x6               // =6
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldr	x2, [x1, #0x38]
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldr	x1, [x1]
               	lsl	x1, x1, #3
               	add	x0, x0, x1
               	cmp	x0, #0x1c8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
