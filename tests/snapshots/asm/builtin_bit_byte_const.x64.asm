
builtin_bit_byte_const.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<classify>:
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	$0xff00, %edi           # imm = 0xFF00
               	jl	<addr>
               	cmpl	$0xff00, %edi           # imm = 0xFF00
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x3412, %edi           # imm = 0x3412
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x12345678, 0x8(%rsp)  # imm = 0x12345678
               	movl	0x8(%rsp), %eax
               	bswapl	%eax
               	cmpl	$0x78563412, %eax       # imm = 0x78563412
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movw	$0x1234, (%rsp)         # imm = 0x1234
               	movzwq	(%rsp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	cmpl	$0x3412, %eax           # imm = 0x3412
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
