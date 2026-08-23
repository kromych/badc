
branch_fuse_cmp.x64:	file format elf64-x86-64

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

<relational>:
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jle	<addr>
               	addq	$0x64, %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	addq	$0x64, %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jae	<addr>
               	incq	%rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jbe	<addr>
               	addq	$0x64, %rax
               	movq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	incq	%rax
               	movq	(%rdx), %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	addq	$0x64, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	ja	<addr>
               	addq	$0x64, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jb	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x64, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	addq	$0x64, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	(%rax), %rax
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	jmp	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
