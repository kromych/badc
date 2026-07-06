
switch_jump_table_sparse_kept.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sparse>:
               	movslq	%edi, %rdi
               	cmpq	$0x32, %rdi
               	jl	<addr>
               	cmpq	$0x46, %rdi
               	jl	<addr>
               	cmpq	$0x50, %rdi
               	jl	<addr>
               	cmpq	$0x5a, %rdi
               	jl	<addr>
               	cmpq	$0x5a, %rdi
               	je	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	movl	$0xa, %eax
               	retq
               	cmpq	$0x50, %rdi
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpq	$0x46, %rdi
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpq	$0x3c, %rdi
               	jl	<addr>
               	cmpq	$0x3c, %rdi
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	cmpq	$0x32, %rdi
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpq	$0x14, %rdi
               	jl	<addr>
               	cmpq	$0x1e, %rdi
               	jl	<addr>
               	cmpq	$0x28, %rdi
               	jl	<addr>
               	cmpq	$0x28, %rdi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpq	$0x1e, %rdi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$0x14, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0xa, %rdi
               	jl	<addr>
               	cmpq	$0xa, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	imulq	$0xa, %rbx, %rdi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0xa, %rax
               	jl	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0xa, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
