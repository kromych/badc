
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
               	lsl	x2, x0, #18
               	lsl	x0, x2, #2
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	mov	sp, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x1                // =1
               	str	w3, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	x0, x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	ldrsw	x4, [x1, x0, lsl #2]
               	add	x3, x3, x4
               	add	x0, x0, #0x1
               	cmp	x0, x2
               	b.lt	<addr>
               	cmp	x3, x2
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
