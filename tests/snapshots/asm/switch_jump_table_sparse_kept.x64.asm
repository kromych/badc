
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
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movl	$0xa, %eax
               	retq
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	$0x14, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x46, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0xa, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x1e, %rdi
               	jl	<addr>
               	jmp	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0xa, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x14, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x28, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x1e, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x28, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3c, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x50, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x32, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3c, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x46, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x5a, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x50, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x5a, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	jmp	<addr>
               	imulq	$0xa, %rbx, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
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
               	addb	%al, (%rax)
