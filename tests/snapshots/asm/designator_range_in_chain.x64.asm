
designator_range_in_chain.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	$0x8, %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	$0x4, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x7, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	addq	$0x4, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x8, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
