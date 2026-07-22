
switch_jump_table_sparse_kept.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	imulq	$0xa, %rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x32, %rax
               	jl	<addr>
               	cmpq	$0x46, %rax
               	jl	<addr>
               	cmpq	$0x50, %rax
               	jl	<addr>
               	cmpq	$0x5a, %rax
               	jl	<addr>
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movabsq	$-0x1, %rax
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	cmpq	$0x50, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	cmpq	$0x46, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	cmpq	$0x3c, %rax
               	jl	<addr>
               	cmpq	$0x3c, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	cmpq	$0x32, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	cmpq	$0x14, %rax
               	jl	<addr>
               	cmpq	$0x1e, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	cmpq	$0x1e, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpq	$0x14, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0xa, %rax
               	jl	<addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0xa, %rdx
               	jl	<addr>
               	movabsq	$-0x1, %rax
               	movabsq	$-0x1, %rax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
