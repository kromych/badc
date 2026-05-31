
thread_local_per_thread.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003a0 <.text+0xb0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x15, x0
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x10
               	ldrsw	x14, [x15]
               	cmp	x14, #0x0
               	b.eq	0x400344 <.text+0x54>
               	mov	x0, #0xbad1             // =47825
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x14, TPIDR_EL0
               	add	x14, x14, #0x10
               	mov	x0, #0x63               // =99
               	str	w0, [x14]
               	mrs	x13, TPIDR_EL0
               	add	x13, x13, #0x10
               	ldrsw	x0, [x13]
               	cmp	x0, #0x63
               	b.eq	0x400380 <.text+0x90>
               	mov	x13, #0xbad2            // =47826
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x13, [x0]
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x10
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	mov	x20, #0x0               // =0
               	mov	x21, #0x2               // =2
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400688 <dlopen>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400694 <dlsym>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x117
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x400694 <dlsym>
               	mov	x23, x0
               	sub	x25, x29, #0x20
               	adrp	x19, 0x400000
               	add	x19, x19, #0x308
               	mov	x24, x19
               	mov	x9, x21
               	str	x20, [sp, #-0x10]!
               	str	x24, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	ldur	x22, [x29, #-0x20]
               	sub	x26, x29, #0x28
               	mov	x9, x23
               	str	x26, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x63
               	b.eq	0x4004cc <.text+0x1dc>
               	mov	x26, #0x1               // =1
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x26, [x0]
               	cmp	x26, #0x1
               	b.eq	0x400510 <.text+0x220>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
