
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<build_one>:
               	movq	%rsi, %r8
               	movslq	%r8d, %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rcx,%rcx,2), %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%rdi,%rcx,2)
               	incq	%rax
               	movslq	%eax, %rcx
               	cmpq	%r8, %rcx
               	jl	<addr>
               	leaq	-0x1(%r8), %rax
               	movslq	%eax, %rax
               	movswq	(%rdi,%rax,2), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movswq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movswq	0xe(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x63, %ecx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x28(%rbp), %rax
               	movswq	0xe(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
