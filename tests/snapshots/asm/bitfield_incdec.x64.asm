
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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
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
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %eax
               	movq	%rax, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	leaq	0x1(%rdx), %rsi
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	andq	$0x7fffffff, %rsi       # imm = 0x7FFFFFFF
               	orq	%rsi, %rax
               	movl	%eax, (%rcx)
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%eax, %ecx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %edx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	incq	%rdx
               	movl	%eax, %eax
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %edx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	incq	%rdx
               	movl	%eax, %eax
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %edx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	decq	%rdx
               	movl	%eax, %eax
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x1f, %rcx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %edx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	incq	%rdx
               	movl	%eax, %eax
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	movslq	%ecx, %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%eax, %ecx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %edx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	decq	%rdx
               	movl	%eax, %eax
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %eax
               	sarq	$0x1f, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
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
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %eax
               	movq	%rax, %rdx
               	sarq	$0x4, %rdx
               	andq	$0x1f, %rdx
               	shlq	$0x3b, %rdx
               	sarq	$0x3b, %rdx
               	incq	%rdx
               	andq	$-0x1f1, %rax           # imm = 0xFE0F
               	andq	$0x1f, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	sarq	$0x4, %rcx
               	andq	$0x1f, %rcx
               	shlq	$0x3b, %rcx
               	sarq	$0x3b, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movl	%eax, %ecx
               	sarq	$0x9, %rcx
               	movq	%rcx, %rdx
               	andq	$0xfffff, %rdx          # imm = 0xFFFFF
               	leaq	0x1(%rdx), %rcx
               	movl	%eax, %eax
               	andq	$-0x1ffffe01, %rax      # imm = 0xE00001FF
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	shlq	$0x9, %rcx
               	orq	%rax, %rcx
               	movl	%ecx, (%rsi)
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	%ecx, %eax
               	sarq	$0x9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0x10, %rax
               	orq	$0xf, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %edx
               	andq	$0xf, %rdx
               	incq	%rdx
               	movl	%eax, %eax
               	andq	$-0x10, %rax
               	andq	$0xf, %rdx
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x4, %rcx
               	andq	$0x1f, %rcx
               	shlq	$0x3b, %rcx
               	sarq	$0x3b, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%eax, %eax
               	sarq	$0x9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
