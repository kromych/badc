
ipproto_case_labels.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	cmpq	$0x32, %rdi
               	jl	<addr>
               	cmpq	$0x3a, %rdi
               	jl	<addr>
               	cmpq	$0x84, %rdi
               	jl	<addr>
               	cmpq	$0x84, %rdi
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x6, %eax
               	retq
               	cmpq	$0x3a, %rdi
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	cmpq	$0x33, %rdi
               	jl	<addr>
               	cmpq	$0x33, %rdi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpq	$0x32, %rdi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$0x6, %rdi
               	jl	<addr>
               	cmpq	$0x11, %rdi
               	jl	<addr>
               	cmpq	$0x11, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x6, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x11, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x32, %edi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x33, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x84, %edi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x3a, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0xc8, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
