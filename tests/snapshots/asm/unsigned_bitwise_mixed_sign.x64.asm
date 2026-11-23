
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movb	$-0x56, -0x20(%rbp)
               	movw	$0xffaa, -0x18(%rbp)    # imm = 0xFFAA
               	movl	$0xffffffaa, -0x10(%rbp) # imm = 0xFFFFFFAA
               	movl	$0xffffffaa, -0x8(%rbp) # imm = 0xFFFFFFAA
               	movsbq	-0x20(%rbp), %rcx
               	movswq	-0x18(%rbp), %rax
               	movl	-0x10(%rbp), %esi
               	movl	-0x8(%rbp), %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	cmpl	$-0x56, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rax, %rdx
               	andq	%rcx, %rdx
               	cmpl	$-0x56, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$-0x56, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	cmpl	$0x55, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	orq	%rsi, %rax
               	cmpl	$-0x56, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	cmpl	$-0x56, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorq	$0xffaa, %rcx           # imm = 0xFFAA
               	cmpl	$0xffff0000, %ecx       # imm = 0xFFFF0000
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
