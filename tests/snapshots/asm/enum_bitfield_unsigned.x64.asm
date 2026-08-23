
enum_bitfield_unsigned.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	-0x8(%rbp), %eax
               	andq	$-0x8, %rax
               	orq	$0x6, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$-0x8, %rax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x4, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$-0x8, %rax
               	orq	$0x2, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %eax
               	andq	$0x7, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	andq	$-0x8, %rax
               	orq	$0x5, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %eax
               	andq	$0x7, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3c, %eax
               	movl	$0x32, %eax
               	movl	$0x28, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
