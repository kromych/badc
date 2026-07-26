
local_struct_array_compound_literal_runtime.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x1, #0x15               // =21
               	mov	x2, #0x33               // =51
               	sub	x0, x29, #0x48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x3, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x3, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x3, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x3, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x3, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x48
               	str	x1, [x0]
               	mov	x3, #0x1014             // =4116
               	sub	x0, x29, #0x48
               	str	x3, [x0, #0x8]
               	mov	x3, #0x200              // =512
               	sub	x0, x29, #0x48
               	str	x3, [x0, #0x10]
               	sub	x0, x29, #0x48
               	str	x2, [x0, #0x18]
               	mov	x3, #0x1032             // =4146
               	sub	x0, x29, #0x48
               	str	x3, [x0, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x48
               	ldr	x0, [x0, #0x28]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x0, [x0, #0x30]
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x48
               	ldr	x0, [x0, #0x38]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x48
               	ldr	x0, [x0, #0x40]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x3, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x3, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x78
               	str	x1, [x0]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x78
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x78
               	str	x2, [x0, #0x20]
               	sub	x0, x29, #0x78
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x78
               	ldr	x0, [x0, #0x28]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
