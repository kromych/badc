
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	ldr	x4, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x8
               	ldr	x6, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	ldr	x7, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x18
               	ldr	x1, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x28
               	ldr	x5, [x2]
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x30
               	ldr	x3, [x2]
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x38
               	ldr	x2, [x2]
               	ror	x8, x0, #0xe
               	ror	x9, x0, #0x12
               	eor	x8, x8, x9
               	ror	x9, x0, #0x29
               	eor	x8, x8, x9
               	and	x9, x0, x5
               	mvn	x10, x0
               	and	x10, x10, x3
               	eor	x9, x9, x10
               	add	x8, x8, x9
               	add	x2, x8, x2
               	ror	x8, x4, #0xe
               	ror	x9, x4, #0x12
               	eor	x8, x8, x9
               	ror	x9, x4, #0x29
               	eor	x8, x8, x9
               	add	x1, x1, x2
               	add	x2, x2, x8
               	ror	x8, x1, #0xe
               	ror	x9, x1, #0x12
               	eor	x8, x8, x9
               	ror	x9, x1, #0x29
               	eor	x8, x8, x9
               	and	x9, x1, x0
               	mvn	x10, x1
               	and	x10, x10, x5
               	eor	x9, x9, x10
               	add	x8, x8, x9
               	add	x3, x8, x3
               	ror	x8, x2, #0xe
               	ror	x9, x2, #0x12
               	eor	x8, x8, x9
               	ror	x2, x2, #0x29
               	eor	x8, x8, x2
               	add	x2, x7, x3
               	add	x3, x3, x8
               	ror	x7, x2, #0xe
               	ror	x8, x2, #0x12
               	eor	x7, x7, x8
               	ror	x8, x2, #0x29
               	eor	x7, x7, x8
               	and	x8, x2, x1
               	mvn	x9, x2
               	and	x9, x9, x0
               	eor	x8, x8, x9
               	add	x7, x7, x8
               	add	x5, x7, x5
               	ror	x7, x3, #0xe
               	ror	x8, x3, #0x12
               	eor	x7, x7, x8
               	ror	x3, x3, #0x29
               	eor	x7, x7, x3
               	add	x3, x6, x5
               	add	x5, x5, x7
               	ror	x6, x3, #0xe
               	ror	x7, x3, #0x12
               	eor	x6, x6, x7
               	ror	x7, x3, #0x29
               	eor	x6, x6, x7
               	and	x2, x3, x2
               	mvn	x3, x3
               	and	x3, x3, x1
               	eor	x2, x2, x3
               	add	x2, x6, x2
               	add	x0, x2, x0
               	ror	x2, x5, #0xe
               	ror	x3, x5, #0x12
               	eor	x2, x2, x3
               	ror	x3, x5, #0x29
               	eor	x2, x2, x3
               	add	x0, x0, x2
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
