
vla_large_runtime.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	lsl	x0, x0, #18
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	lsl	x0, x0, #2
               	stur	x0, [x29, #-0x20]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x28]
               	b	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, x1, lsl #2]
               	ldur	x0, [x29, #-0x28]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x38]
               	b	<addr>
               	ldur	x2, [x29, #-0x30]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x38]
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x0, x2, x0
               	stur	x0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x38]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	stur	x0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x48]
               	b	<addr>
