
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<identity>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movl	$0x2a, %eax
               	movl	$0x63, %ecx
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	leaq	-0x18(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x2a, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x63, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movl	$0x7, %edx
               	leaq	-0x20(%rbp), %rsi
               	movl	%edx, (%rsi)
               	leaq	-0x20(%rbp), %rdx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x20(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x7, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x63, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	leaq	-0x28(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movl	$0xb, %edx
               	leaq	-0x28(%rbp), %rsi
               	movl	%edx, (%rsi)
               	movl	$0x16, %edx
               	leaq	-0x28(%rbp), %rsi
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x28(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xb, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x16, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rdx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rdx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rdx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rdx)
               	popq	%rax
               	leaq	-0x38(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x38(%rbp), %rdx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x38(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x2a, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpq	$0x63, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
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
               	leaq	-0x48(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rdx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rdx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rdx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rdx)
               	popq	%rax
               	leaq	-0x48(%rbp), %rdx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x48(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x2a, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpq	$0x63, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
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
               	leaq	-0x58(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rdx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rdx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rdx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rdx)
               	popq	%rax
               	leaq	-0x58(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x58(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rdx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rdx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	leaq	-0x78(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
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
