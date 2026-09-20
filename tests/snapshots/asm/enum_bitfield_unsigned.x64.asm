
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
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	andq	$-0x8, %rax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	andq	$-0x8, %rax
               	orq	$0x2, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$0x7, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	andq	$-0x8, %rax
               	orq	$0x5, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$0x7, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
