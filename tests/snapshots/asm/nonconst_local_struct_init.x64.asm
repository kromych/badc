
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<identity>:
               	movslq	%edi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movl	$0x2a, %edx
               	movl	$0x63, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	leaq	-0x18(%rbp), %rcx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movl	$0x7, %ecx
               	leaq	-0x20(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movl	$0xb, %ecx
               	leaq	-0x28(%rbp), %rsi
               	movl	%ecx, (%rsi)
               	movl	$0x16, %esi
               	leaq	-0x28(%rbp), %rcx
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xb, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x16, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x38(%rbp), %rcx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x38(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x48(%rbp), %rcx
               	movl	%edx, (%rcx)
               	leaq	-0x48(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x48(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x58(%rbp), %rcx
               	movl	%edx, (%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x58(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x58(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
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
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
