
builtin_bit_byte_const.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xff00, %eax           # imm = 0xFF00
               	jb	<addr>
               	cmpl	$0xff00, %eax           # imm = 0xFF00
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x3412, %eax           # imm = 0x3412
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	bswapl	%eax
               	cmpl	$0x78563412, %eax       # imm = 0x78563412
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	movw	%ax, -0x10(%rbp)
               	movzwq	-0x10(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	xorq	$0x3412, %rax           # imm = 0x3412
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
