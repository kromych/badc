
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	mov	x2, #0x4                // =4
               	str	x2, [x1, #0x8]
               	mov	x2, #0x7                // =7
               	str	x2, [x1, #0x10]
               	mov	x2, #0xa                // =10
               	str	x2, [x1, #0x18]
               	mov	x2, #0xd                // =13
               	str	x2, [x1, #0x20]
               	mov	x2, #0x10               // =16
               	str	x2, [x1, #0x28]
               	mov	x2, #0x13               // =19
               	str	x2, [x1, #0x30]
               	mov	x2, #0x16               // =22
               	str	x2, [x1, #0x38]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	ldr	x1, [x2, #0x8]
               	ldr	x3, [x2, #0x10]
               	lsl	x3, x3, #1
               	add	x1, x1, x3
               	ldr	x3, [x2, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	ldr	x3, [x2, #0x20]
               	lsl	x3, x3, #2
               	add	x1, x1, x3
               	ldr	x3, [x2, #0x28]
               	mov	x17, #0x5               // =5
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	ldr	x3, [x2, #0x30]
               	mov	x17, #0x6               // =6
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	ldr	x3, [x2, #0x38]
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	ldr	x2, [x2]
               	lsl	x2, x2, #3
               	add	x1, x1, x2
               	cmp	x1, #0x1c8
               	b.eq	<addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
