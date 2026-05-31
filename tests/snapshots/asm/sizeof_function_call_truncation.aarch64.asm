
sizeof_function_call_truncation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400274 <.text+0x54>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	mov	x17, #0xff              // =255
               	and	x13, x15, x17
               	asr	x14, x15, #8
               	mov	x17, #0xff              // =255
               	and	x15, x14, x17
               	sxtw	x14, w13
               	sxtw	x13, w15
               	add	x15, x14, x13
               	sxtw	x15, w15
               	sxtw	x13, w15
               	lsl	x15, x13, #1
               	sxtw	x15, w15
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x1234            // =4660
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x8c
               	b.eq	0x4002b4 <.text+0x94>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.eq	0x4002e0 <.text+0xc0>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xff00            // =65280
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1fe
               	b.eq	0x40030c <.text+0xec>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
