
conditional_pointer_null_constant_type.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x2a, %edx
               	movl	%edx, 0x10(%rax)
               	movq	%rax, %rdx
               	movslq	0x10(%rdx), %rdx
               	cmpl	$0x2a, %edx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	0x10(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x10(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
