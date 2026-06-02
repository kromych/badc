
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	sxtw	x14, w1
               	lsr	x13, x15, x14
               	mov	x12, #0x40              // =64
               	sub	x12, x12, x14
               	sxtw	x12, w12
               	lsl	x15, x15, x12
               	orr	x0, x13, x15
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	mov	x13, x2
               	and	x14, x15, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x15, x15, x17
               	and	x15, x15, x13
               	eor	x0, x14, x15
               	ret
               	mov	x15, x0
               	ror	x14, x15, #0xe
               	ror	x13, x15, #0x12
               	eor	x14, x14, x13
               	ror	x15, x15, #0x29
               	eor	x0, x14, x15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x15, #0x100             // =256
               	stur	x15, [x29, #-0x8]
               	mov	x14, #0x200             // =512
               	stur	x14, [x29, #-0x10]
               	mov	x15, #0x400             // =1024
               	stur	x15, [x29, #-0x18]
               	mov	x14, #0x800             // =2048
               	stur	x14, [x29, #-0x20]
               	mov	x15, #0x1000            // =4096
               	stur	x15, [x29, #-0x28]
               	mov	x14, #0x2000            // =8192
               	stur	x14, [x29, #-0x30]
               	mov	x15, #0x4000            // =16384
               	stur	x15, [x29, #-0x38]
               	mov	x14, #0x8000            // =32768
               	stur	x14, [x29, #-0x40]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x48]
               	b	<addr>
               	ldursw	x15, [x29, #-0x48]
               	cmp	x15, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x48
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	ldur	x15, [x29, #-0x28]
               	ror	x13, x15, #0xe
               	ror	x14, x15, #0x12
               	eor	x13, x13, x14
               	ror	x15, x15, #0x29
               	eor	x13, x13, x15
               	ldur	x15, [x29, #-0x28]
               	ldur	x14, [x29, #-0x30]
               	ldur	x12, [x29, #-0x38]
               	and	x14, x15, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x15, x15, x17
               	and	x15, x15, x12
               	eor	x14, x14, x15
               	add	x13, x13, x14
               	ldur	x14, [x29, #-0x40]
               	add	x13, x13, x14
               	stur	x13, [x29, #-0x50]
               	ldur	x14, [x29, #-0x8]
               	ror	x13, x14, #0xe
               	ror	x15, x14, #0x12
               	eor	x13, x13, x15
               	ror	x14, x14, #0x29
               	eor	x13, x13, x14
               	stur	x13, [x29, #-0x58]
               	ldur	x14, [x29, #-0x38]
               	stur	x14, [x29, #-0x40]
               	ldur	x13, [x29, #-0x30]
               	stur	x13, [x29, #-0x38]
               	ldur	x14, [x29, #-0x28]
               	stur	x14, [x29, #-0x30]
               	ldur	x13, [x29, #-0x20]
               	ldur	x14, [x29, #-0x50]
               	add	x13, x13, x14
               	stur	x13, [x29, #-0x28]
               	ldur	x15, [x29, #-0x18]
               	stur	x15, [x29, #-0x20]
               	ldur	x13, [x29, #-0x10]
               	stur	x13, [x29, #-0x18]
               	ldur	x15, [x29, #-0x8]
               	stur	x15, [x29, #-0x10]
               	ldur	x13, [x29, #-0x58]
               	add	x14, x14, x13
               	stur	x14, [x29, #-0x8]
               	b	<addr>
               	ldur	x14, [x29, #-0x8]
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x14, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x40]
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x14, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
