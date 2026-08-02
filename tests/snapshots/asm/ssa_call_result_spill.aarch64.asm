
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<ch>:
               	and	x1, x0, x1
               	mvn	x0, x0
               	and	x0, x0, x2
               	eor	x0, x1, x0
               	ret

<bs1>:
               	ror	x1, x0, #0xe
               	ror	x2, x0, #0x12
               	eor	x1, x1, x2
               	ror	x0, x0, #0x29
               	eor	x0, x1, x0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x22, #0x100             // =256
               	mov	x28, #0x200             // =512
               	mov	x27, #0x400             // =1024
               	mov	x26, #0x800             // =2048
               	mov	x21, #0x1000            // =4096
               	mov	x24, #0x2000            // =8192
               	mov	x23, #0x4000            // =16384
               	mov	x25, #0x8000            // =32768
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x68]
               	ldr	x16, [sp, #0x68]
               	ldr	x0, [x16]
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	str	x0, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x24
               	blr	x9
               	ldr	x16, [sp, #0x60]
               	add	x0, x16, x0
               	add	x25, x0, x25
               	ldr	x16, [sp, #0x68]
               	ldr	x0, [x16]
               	mov	x9, x0
               	mov	x0, x22
               	blr	x9
               	add	x1, x26, x25
               	add	x2, x25, x0
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	mov	x25, x23
               	mov	x23, x24
               	mov	x24, x21
               	mov	x21, x1
               	mov	x26, x27
               	mov	x27, x28
               	mov	x28, x22
               	mov	x22, x2
               	sxtw	x0, w20
               	cmp	x0, #0x4
               	b.lt	<addr>
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x22, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x25, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
