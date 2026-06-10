
duff_switch_into_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<send>:
               	movq	%rsi, %r8
               	movslq	%edx, %rdx
               	movq	%rdx, %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	movl	$0x8, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	$0x4, %rax
               	jl	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %rcx
               	movq	%r8, %rdx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movzbq	(%r8), %rax
               	movb	%al, (%rdi)
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movzbq	(%r8), %rax
               	movb	%al, (%rdi)
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movzbq	(%r8), %rax
               	movb	%al, (%rdi)
               	movq	%rcx, %rdi
               	incq	%rdi
               	movq	%rdx, %r8
               	incq	%r8
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movq	%rdi, %rcx
               	incq	%rcx
               	movq	%r8, %rdx
               	incq	%rdx
               	movzbq	(%r8), %rax
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
               	cmpq	$0x0, %rax
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
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rsi
               	decq	%rsi
               	movslq	%esi, %rax
               	cmpq	$0x0, %rax
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
               	subq	$0x70, %rsp
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
               	andq	$0xff, %rdx
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
               	movzbq	(%rax), %rax
               	leaq	-0x28(%rbp), %rdx
               	movslq	%ecx, %rsi
               	addq	%rsi, %rdx
               	movzbq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
