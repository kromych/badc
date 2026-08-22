
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
               	cmpq	$0x2a, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x10(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
