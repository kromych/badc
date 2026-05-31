
type_warning_silenced_by_cast.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x5               // =5
               	cmp	x15, #0x0
               	cset	x0, eq
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
