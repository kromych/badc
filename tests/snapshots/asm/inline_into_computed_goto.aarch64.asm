
inline_into_computed_goto.aarch64:	file format elf64-littleaarch64

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

<interp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	sub	x3, x29, #0x18
               	mov	x0, #0x0                // =0
               	adr	x2, <addr>
               	str	x2, [x3]
               	adr	x2, <addr>
               	str	x2, [x3, #0x8]
               	adr	x2, <addr>
               	str	x2, [x3, #0x10]
               	mov	x2, #0x1                // =1
               	ldrsw	x5, [x4]
               	ldr	x3, [x3, x5, lsl #3]
               	br	x3
               	add	x3, x2, #0x1
               	ldrsw	x2, [x4, x2, lsl #2]
               	ldr	x2, [x1, x2, lsl #3]
               	and	x2, x2, #0xfffffffffffffffc
               	add	x0, x0, x2
               	sub	x5, x29, #0x18
               	add	x2, x3, #0x1
               	ldrsw	x3, [x4, x3, lsl #2]
               	ldr	x3, [x5, x3, lsl #3]
               	br	x3
               	add	x0, x0, x0
               	sub	x3, x29, #0x18
               	add	x5, x2, #0x1
               	ldrsw	x2, [x4, x2, lsl #2]
               	ldr	x3, [x3, x2, lsl #3]
               	mov	x2, x5
               	br	x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x38
               	mov	x0, #0x67               // =103
               	str	x0, [x1]
               	mov	x0, #0xc9               // =201
               	str	x0, [x1, #0x8]
               	mov	x0, #0x12c              // =300
               	str	x0, [x1, #0x10]
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x384
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
