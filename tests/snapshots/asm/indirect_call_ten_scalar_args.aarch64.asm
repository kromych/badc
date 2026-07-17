
indirect_call_ten_scalar_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x28]
               	str	x16, [sp, #0x10]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	ldur	x1, [x29, #0x90]
               	mov	x17, #0x9               // =9
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xa0]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xa0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x20, [x1]
               	add	x1, x20, #0x1
               	add	x2, x20, #0x2
               	add	x3, x20, #0x3
               	add	x4, x20, #0x4
               	add	x5, x20, #0x5
               	add	x6, x20, #0x6
               	add	x7, x20, #0x7
               	add	x8, x20, #0x8
               	add	x9, x20, #0x9
               	mov	x10, x0
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	mov	x0, x20
               	blr	x10
               	add	sp, sp, #0x10
               	mov	x21, x0
               	cmp	x21, #0x181
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	add	x1, x20, #0x1
               	add	x2, x20, #0x2
               	add	x3, x20, #0x3
               	add	x4, x20, #0x4
               	add	x5, x20, #0x5
               	add	x6, x20, #0x6
               	add	x7, x20, #0x7
               	add	x0, x20, #0x8
               	add	x8, x20, #0x9
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	str	x8, [sp, #0x8]
               	mov	x0, x20
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	x21, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
