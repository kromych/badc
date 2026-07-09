
unsigned_compound_assign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x1, #0x587              // =1415
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	mov	x1, #0xa                // =10
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x40
               	mov	x1, #0x14               // =20
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1e               // =30
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x40
               	mov	x1, #0x28               // =40
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x1e
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
