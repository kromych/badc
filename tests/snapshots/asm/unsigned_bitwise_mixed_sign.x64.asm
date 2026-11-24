
unsigned_bitwise_mixed_sign.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x28, %rsp
               	movb	$-0x56, (%rsp)
               	movw	$0xffaa, 0x8(%rsp)      # imm = 0xFFAA
               	movl	$0xffffffaa, 0x10(%rsp) # imm = 0xFFFFFFAA
               	movl	$0xffffffaa, 0x18(%rsp) # imm = 0xFFFFFFAA
               	movsbq	(%rsp), %rcx
               	movswq	0x8(%rsp), %rax
               	movl	0x10(%rsp), %esi
               	movl	0x18(%rsp), %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	cmpl	$-0x56, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rax, %rdx
               	andq	%rcx, %rdx
               	cmpl	$-0x56, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpl	$-0x56, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	cmpl	$0x55, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	orq	%rsi, %rax
               	cmpl	$-0x56, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpl	$-0x56, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	xorq	$0xffaa, %rcx           # imm = 0xFFAA
               	cmpl	$0xffff0000, %ecx       # imm = 0xFFFF0000
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
