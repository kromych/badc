
switch_jump_table_sparse_kept.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	imulq	$0xa, %rcx, %rax
               	cmpl	$0x32, %eax
               	jl	<addr>
               	cmpl	$0x46, %eax
               	jl	<addr>
               	cmpl	$0x50, %eax
               	jl	<addr>
               	cmpl	$0x5a, %eax
               	jl	<addr>
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movabsq	$-0x1, %rax
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	cmpl	$0x50, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	cmpl	$0x46, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	cmpl	$0x3c, %eax
               	jl	<addr>
               	cmpl	$0x3c, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	cmpl	$0x32, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	cmpl	$0x14, %eax
               	jl	<addr>
               	cmpl	$0x1e, %eax
               	jl	<addr>
               	cmpl	$0x28, %eax
               	jl	<addr>
               	cmpl	$0x28, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0x14, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0xa, %eax
               	jl	<addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	cmpl	$0xa, %ecx
               	jl	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
