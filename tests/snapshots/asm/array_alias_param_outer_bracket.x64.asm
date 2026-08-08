
array_alias_param_outer_bracket.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x60(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x60(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x60(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x60(%rbp), %rax
               	addq	$0x20, %rax
               	movl	$0xc, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x60(%rbp), %rax
               	movl	$0x15, %ecx
               	movq	%rcx, 0x40(%rax)
               	leaq	-0x60(%rbp), %rax
               	addq	$0x40, %rax
               	movl	$0x16, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x60(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%eax, %ecx
               	shlq	$0x5, %rcx
               	addq	%rsi, %rcx
               	movq	(%rcx), %rdi
               	movq	0x18(%rcx), %rcx
               	addq	%rdi, %rcx
               	addq	%rcx, %rdx
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x3, %rcx
               	jb	<addr>
               	cmpq	$0x45, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	leaq	0x20(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	addq	$0x20, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	0x20(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	0x38(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	0x58(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%eax, %ecx
               	shlq	$0x5, %rcx
               	addq	%rsi, %rcx
               	movq	(%rcx), %rdi
               	movq	0x18(%rcx), %rcx
               	addq	%rdi, %rcx
               	addq	%rcx, %rdx
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x3, %rcx
               	jb	<addr>
               	cmpq	$0x2e, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
