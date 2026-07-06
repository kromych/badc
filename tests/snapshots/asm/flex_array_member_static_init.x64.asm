
flex_array_member_static_init.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rdx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x18(%rdx), %rsi
               	addq	%rcx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	-0x8(%rbp), %rdi
               	addq	%rcx, %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	addq	$0x4, %rsi
               	addq	%rcx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x6, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x28, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1e, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
