
bitfield_incdec.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	leaq	0x1(%rdx), %rsi
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rsi       # imm = 0x7FFFFFFF
               	orq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	incq	%rdx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	incq	%rdx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	decq	%rdx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1f, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	incq	%rdx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	decq	%rdx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1f, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	sarq	$0x4, %rdx
               	andq	$0x1f, %rdx
               	shlq	$0x3b, %rdx
               	sarq	$0x3b, %rdx
               	incq	%rdx
               	andq	$-0x1f1, %rcx           # imm = 0xFE0F
               	andq	$0x1f, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0x1f, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	sarq	$0x9, %rdx
               	andq	$0xfffff, %rdx          # imm = 0xFFFFF
               	leaq	0x1(%rdx), %rsi
               	andq	$-0x1ffffe01, %rcx      # imm = 0xE00001FF
               	andq	$0xfffff, %rsi          # imm = 0xFFFFF
               	shlq	$0x9, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x10, %rcx
               	orq	$0xf, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0xf, %rdx
               	incq	%rdx
               	andq	$-0x10, %rcx
               	andq	$0xf, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0x1f, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
