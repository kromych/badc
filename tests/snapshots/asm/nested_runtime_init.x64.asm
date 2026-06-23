
nested_runtime_init.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x14, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%r11
               	movq	(%rdx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rdx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%r11
               	movq	(%rdx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rdx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	movq	%rcx, %rax
               	shlq	$0x1, %rax
               	leaq	-0x28(%rbp), %rdx
               	movl	%eax, (%rdx)
               	movq	%rcx, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	leaq	-0x28(%rbp), %rdx
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%r11
               	movq	(%rdx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rdx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x38(%rbp), %rax
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	shlq	$0x1, %rax
               	leaq	-0x38(%rbp), %rdx
               	movl	%eax, 0x4(%rdx)
               	movq	%rcx, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	leaq	-0x38(%rbp), %rdx
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	addq	$0x5, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%r11
               	movq	(%rdx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rdx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rdx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rdx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rdx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x48(%rbp), %rax
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	incq	%rax
               	leaq	-0x48(%rbp), %rdx
               	movl	%eax, 0x4(%rdx)
               	movq	%rcx, %rax
               	addq	$0x2, %rax
               	leaq	-0x48(%rbp), %rdx
               	movl	%eax, 0x8(%rdx)
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movq	%rcx, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
