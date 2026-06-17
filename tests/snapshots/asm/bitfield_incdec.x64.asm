
bitfield_incdec.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	movq	%rdx, %rsi
               	incq	%rsi
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	andq	$0x7fffffff, %rsi       # imm = 0x7FFFFFFF
               	orq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1f, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
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
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1f, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	sarq	$0x9, %rdx
               	andq	$0xfffff, %rdx          # imm = 0xFFFFF
               	movq	%rdx, %rsi
               	incq	%rsi
               	andq	$-0x1ffffe01, %rcx      # imm = 0xE00001FF
               	andq	$0xfffff, %rsi          # imm = 0xFFFFF
               	shlq	$0x9, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x10, %rcx
               	movl	$0xf, %edx
               	orq	%rdx, %rcx
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0x1f, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
