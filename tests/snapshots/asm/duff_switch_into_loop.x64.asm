
duff_switch_into_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<send>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movq	%rsi, %r8
               	movslq	%edx, %rdx
               	movq	%rdx, %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x3, %rsi
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	movq	%rdx, %rcx
               	addq	%rax, %rcx
               	andq	$0x7, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
               	movq	%r8, %rdx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movsbq	(%r8), %rax
               	movb	%al, (%rdi)
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movsbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movsbq	(%r8), %rax
               	movb	%al, (%rdi)
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movsbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movsbq	(%r8), %rax
               	movb	%al, (%rdi)
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movsbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movsbq	(%r8), %rax
               	movb	%al, (%rdi)
               	jmp	<addr>
               	cmpq	$0x2, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x6, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jl	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x7, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movsbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rsi
               	decq	%rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	jg	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdi, %rcx
               	movq	%r8, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdi, %rcx
               	movq	%r8, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdi, %rcx
               	movq	%r8, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x27, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movb	%dl, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x27, %edx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x27, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	leaq	-0x28(%rbp), %rdx
               	movslq	%ecx, %rsi
               	addq	%rsi, %rdx
               	movsbq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
