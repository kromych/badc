
divmod_preserves_rdx.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x64               // =100
               	mov	x1, #0x32               // =50
               	mov	x2, #0x19               // =25
               	mov	x3, #0xc                // =12
               	mov	x4, #0x7                // =7
               	sdiv	x5, x0, x4
               	sdiv	x6, x1, x4
               	sdiv	x7, x2, x4
               	sdiv	x4, x3, x4
               	add	x5, x5, x6
               	add	x5, x5, x7
               	add	x4, x5, x4
               	add	x0, x4, x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	sxtw	x20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, #0xd4
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
