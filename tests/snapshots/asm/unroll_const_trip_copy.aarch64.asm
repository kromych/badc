
unroll_const_trip_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	str	x1, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xd                // =13
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	str	x1, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x13               // =19
               	str	x1, [x0, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x16               // =22
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x0
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	str	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	str	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	str	x1, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x20]
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x28]
               	str	x1, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x30]
               	str	x1, [x0, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x38]
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #0
               	add	x0, x0, #0x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x20]
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x28]
               	mov	x17, #0x5               // =5
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x30]
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x38]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x0
               	ldr	x1, [x1]
               	lsl	x1, x1, #3
               	add	x0, x0, x1
               	cmp	x0, #0x1c8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
