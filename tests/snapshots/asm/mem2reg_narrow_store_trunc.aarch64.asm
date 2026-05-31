
mem2reg_narrow_store_trunc.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400294 <.text+0x74>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	mov	x17, #0x2c              // =44
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	0x400278 <.text+0x58>
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x10]
               	b	0x400284 <.text+0x64>
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x10]
               	b	0x400284 <.text+0x64>
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x12c             // =300
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
