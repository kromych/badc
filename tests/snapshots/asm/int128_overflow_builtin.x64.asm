
int128_overflow_builtin.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<chk>:
               	popq	%r10
               	subq	$0x60, %rsp
               	movq	0x60(%rsp), %rax
               	movq	%rax, 0x50(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%rcx, %rdx
               	movq	%r8, %rsi
               	movq	%r9, %r8
               	movslq	%edi, %rdi
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%r8, %rax
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	xorq	%rdx, %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4f0, %rsp            # imm = 0x4F0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rcx, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x420(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movl	$0x1, %edx
               	leaq	-0x30(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, %rsi
               	shlq	$0x3f, %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x430(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, %rsi
               	shlq	$0x3f, %rsi
               	leaq	-0x60(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	cmpq	$0x1, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%rcx), %rdi
               	subq	$0x0, %rsi
               	subq	%rax, %rsi
               	leaq	-0x70(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x440(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x420(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	-0x80(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x450(%rbp), %rax
               	leaq	(%rdi,%rdx), %r8
               	cmpq	%rdi, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	leaq	(%rsi,%rcx), %rdi
               	addq	%r9, %rdi
               	cmpq	%rsi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rsi, %rdi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%r9, %rsi
               	orq	%rbx, %rsi
               	addq	$0x0, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%r8, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x450(%rbp), %rax
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	movq	%rsi, %rdi
               	movq	%rcx, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rcx
               	xorq	%rdx, %rdx
               	leaq	-0x90(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x450(%rbp), %rax
               	leaq	(%rsi,%rdx), %rdi
               	cmpq	%rsi, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	leaq	(%rcx,%rdx), %rsi
               	addq	%r8, %rsi
               	cmpq	%rcx, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rcx, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%r8, %rcx
               	orq	%r9, %rcx
               	addq	$0x0, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x450(%rbp), %rsi
               	movabsq	$-0x1, %rax
               	movl	$0x4, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %rdi
               	movq	%rax, %r9
               	movq	%rax, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0xa0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movl	$0x1, %edx
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x450(%rbp), %rcx
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%rax, %rdi
               	subq	%rax, %rdi
               	movq	%rdi, %r9
               	subq	%rsi, %r9
               	cmpq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	andq	%rsi, %rax
               	orq	%rdi, %rax
               	xorq	%rsi, %rsi
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	subq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	leaq	-0x450(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	movl	$0x7, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0xc0(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xf0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x450(%rbp), %r14
               	movq	%rcx, %rax
               	xorq	%rcx, %rax
               	movq	%rdx, %rsi
               	xorq	%rcx, %rsi
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	$0x0, %rax
               	subq	$0x0, %rsi
               	subq	%rdi, %rsi
               	movq	%rcx, %rdi
               	xorq	%rcx, %rdi
               	movq	%rdx, %r8
               	xorq	%rcx, %r8
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %rdi
               	subq	$0x0, %r8
               	subq	%r9, %r8
               	movq	%rax, %r15
               	imulq	%rdi, %r15
               	movl	%eax, %r9d
               	movq	%rax, %rbx
               	shrq	$0x20, %rbx
               	movl	%edi, %r12d
               	movq	%rdi, %r13
               	shrq	$0x20, %r13
               	movq	%r9, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbx, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r8, %rax
               	imulq	%rsi, %rdi
               	movq	%rax, %r10
               	movq	0x58(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	0x58(%rsp), %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	addq	%rax, %rdi
               	cmpq	%rax, %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%r8, %r8
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rax, %r10
               	andq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	%r8d, %eax
               	shrq	$0x20, %r8
               	movq	%r9, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	%rbx, %rax
               	addq	0x40(%rsp), %rax
               	movl	%eax, %r10d
               	movq	%r10, 0x40(%rsp)
               	shrq	$0x20, %rax
               	imulq	%r8, %r9
               	addq	0x40(%rsp), %r9
               	shrq	$0x20, %r9
               	imulq	%rbx, %r8
               	addq	%r8, %rax
               	addq	%rax, %r9
               	movl	%esi, %eax
               	shrq	$0x20, %rsi
               	movq	%rax, %r8
               	imulq	%r12, %r8
               	shrq	$0x20, %r8
               	movq	%rsi, %rbx
               	imulq	%r12, %rbx
               	addq	%rbx, %r8
               	movl	%r8d, %ebx
               	shrq	$0x20, %r8
               	imulq	%r13, %rax
               	addq	%rbx, %rax
               	shrq	$0x20, %rax
               	imulq	%r13, %rsi
               	addq	%r8, %rsi
               	addq	%rsi, %rax
               	testq	%r9, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	orq	%r10, %rsi
               	orq	%rsi, %rax
               	orq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	orq	0x50(%rsp), %r8
               	xorq	%rax, %rax
               	movq	%r15, %rsi
               	xorq	%rax, %rsi
               	xorq	%rdi, %rax
               	testq	%rsi, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %rsi
               	subq	$0x0, %rax
               	subq	%r9, %rax
               	movq	%r15, %r9
               	xorq	%rcx, %r9
               	xorq	%rcx, %rdi
               	orq	%r9, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	andq	$0x0, %rdi
               	orq	%r8, %rdi
               	movq	%rsi, (%r14)
               	movq	%rax, 0x8(%r14)
               	leaq	-0x450(%rbp), %rsi
               	movl	$0xa, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	leaq	-0x100(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rsi
               	shlq	$0x3f, %rsi
               	leaq	-0x110(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x120(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x450(%rbp), %r13
               	movq	%rdx, %rax
               	xorq	%rdx, %rax
               	xorq	%rdx, %rsi
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	$0x0, %rax
               	subq	$0x0, %rsi
               	subq	%rdi, %rsi
               	xorq	%rdx, %rcx
               	movq	%rdx, %rdi
               	xorq	%rdx, %rdi
               	testq	%rcx, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	$0x0, %rcx
               	subq	$0x0, %rdi
               	subq	%r8, %rdi
               	movq	%rax, %r14
               	imulq	%rcx, %r14
               	movl	%eax, %r8d
               	movq	%rax, %r9
               	shrq	$0x20, %r9
               	movl	%ecx, %ebx
               	movq	%rcx, %r12
               	shrq	$0x20, %r12
               	movq	%r8, %r15
               	imulq	%rbx, %r15
               	shrq	$0x20, %r15
               	movq	%r9, %r10
               	imulq	%rbx, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r15, %r10
               	movq	0x58(%rsp), %r15
               	addq	%r10, %r15
               	movl	%r15d, %r10d
               	movq	%r10, 0x58(%rsp)
               	shrq	$0x20, %r15
               	movq	%r8, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r15, %r10
               	movq	0x50(%rsp), %r15
               	addq	%r10, %r15
               	addq	0x58(%rsp), %r15
               	imulq	%rdi, %rax
               	imulq	%rsi, %rcx
               	addq	%r15, %rax
               	cmpq	%r15, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	addq	%rax, %rcx
               	cmpq	%rax, %rcx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rdi, %rdi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rax, %r10
               	andq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	%edi, %eax
               	shrq	$0x20, %rdi
               	movq	%r8, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x48(%rsp)
               	imulq	%r9, %rax
               	addq	0x48(%rsp), %rax
               	movl	%eax, %r10d
               	movq	%r10, 0x48(%rsp)
               	shrq	$0x20, %rax
               	imulq	%rdi, %r8
               	addq	0x48(%rsp), %r8
               	shrq	$0x20, %r8
               	imulq	%r9, %rdi
               	addq	%rdi, %rax
               	addq	%rax, %r8
               	movl	%esi, %eax
               	shrq	$0x20, %rsi
               	movq	%rax, %rdi
               	imulq	%rbx, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %r9
               	imulq	%rbx, %r9
               	addq	%r9, %rdi
               	movl	%edi, %r9d
               	shrq	$0x20, %rdi
               	imulq	%r12, %rax
               	addq	%r9, %rax
               	shrq	$0x20, %rax
               	imulq	%r12, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rax
               	testq	%r8, %r8
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rsi, %r10
               	movq	0x50(%rsp), %rsi
               	orq	%r10, %rsi
               	orq	%rsi, %rax
               	orq	%r15, %rax
               	movq	%rax, %rdi
               	orq	0x58(%rsp), %rdi
               	xorq	%rax, %rax
               	movq	%r14, %rsi
               	xorq	%rax, %rsi
               	xorq	%rcx, %rax
               	testq	%rsi, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	$0x0, %rsi
               	subq	$0x0, %rax
               	subq	%r8, %rax
               	movq	%r14, %r8
               	xorq	%rdx, %r8
               	xorq	%rdx, %rcx
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	andq	$0x0, %rcx
               	orq	%rcx, %rdi
               	movq	%rsi, (%r13)
               	movq	%rax, 0x8(%r13)
               	leaq	-0x450(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0xd, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x3, %edx
               	leaq	-0x130(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x140(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movq	%rax, %rsi
               	orq	$0x5, %rsi
               	movq	%rdx, %rdi
               	orq	%rax, %rdi
               	leaq	-0x150(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movl	$0x1, %edx
               	leaq	-0x160(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rdx, %r8
               	shlq	$0x3f, %r8
               	movq	%rax, %rcx
               	shlq	$0x3f, %rcx
               	movq	%rdx, %r9
               	shrq	%r9
               	orq	%rcx, %r9
               	leaq	-0x170(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	leaq	-0x450(%rbp), %r14
               	movq	%rsi, %rcx
               	xorq	%rax, %rcx
               	movq	%rdi, %rsi
               	xorq	%rax, %rsi
               	testq	%rcx, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	$0x0, %rcx
               	subq	$0x0, %rsi
               	subq	%rdi, %rsi
               	movq	%r8, %rdi
               	xorq	%rax, %rdi
               	movq	%r9, %r8
               	xorq	%rax, %r8
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %rdi
               	subq	$0x0, %r8
               	subq	%r9, %r8
               	movq	%rcx, %r15
               	imulq	%rdi, %r15
               	movl	%ecx, %r9d
               	movq	%rcx, %rbx
               	shrq	$0x20, %rbx
               	movl	%edi, %r12d
               	movq	%rdi, %r13
               	shrq	$0x20, %r13
               	movq	%r9, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbx, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r8, %rcx
               	imulq	%rsi, %rdi
               	movq	%rcx, %r10
               	movq	0x58(%rsp), %rcx
               	addq	%r10, %rcx
               	cmpq	0x58(%rsp), %rcx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	addq	%rcx, %rdi
               	cmpq	%rcx, %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	testq	%rsi, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%r8, %r8
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rcx, %r10
               	andq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	%r8d, %ecx
               	shrq	$0x20, %r8
               	movq	%r9, %r10
               	imulq	%rcx, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	%rbx, %rcx
               	addq	0x40(%rsp), %rcx
               	movl	%ecx, %r10d
               	movq	%r10, 0x40(%rsp)
               	shrq	$0x20, %rcx
               	imulq	%r8, %r9
               	addq	0x40(%rsp), %r9
               	shrq	$0x20, %r9
               	imulq	%rbx, %r8
               	addq	%r8, %rcx
               	addq	%rcx, %r9
               	movl	%esi, %ecx
               	shrq	$0x20, %rsi
               	movq	%rcx, %r8
               	imulq	%r12, %r8
               	shrq	$0x20, %r8
               	movq	%rsi, %rbx
               	imulq	%r12, %rbx
               	addq	%rbx, %r8
               	movl	%r8d, %ebx
               	shrq	$0x20, %r8
               	imulq	%r13, %rcx
               	addq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	imulq	%r13, %rsi
               	addq	%r8, %rsi
               	addq	%rsi, %rcx
               	testq	%r9, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	orq	%r10, %rsi
               	orq	%rsi, %rcx
               	orq	0x58(%rsp), %rcx
               	movq	%rcx, %r8
               	orq	0x50(%rsp), %r8
               	xorq	%rcx, %rcx
               	movq	%r15, %rsi
               	xorq	%rcx, %rsi
               	xorq	%rdi, %rcx
               	testq	%rsi, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %rsi
               	subq	$0x0, %rcx
               	subq	%r9, %rcx
               	movq	%r15, %r9
               	xorq	%rax, %r9
               	xorq	%rdi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	$0x0, %rax
               	movq	%r8, %rdi
               	orq	%rax, %rdi
               	movq	%rsi, (%r14)
               	movq	%rcx, 0x8(%r14)
               	leaq	-0x450(%rbp), %rsi
               	movabsq	$-0x7ffffffffffffffe, %rcx # imm = 0x8000000000000002
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x10, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x440(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rcx
               	movl	$0x1, %edx
               	leaq	-0x180(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%r8, %r8
               	movq	%r8, 0x8(%rax)
               	leaq	-0x460(%rbp), %rsi
               	movq	%rcx, %rbx
               	sarq	$0x3f, %rbx
               	movq	%r8, %r12
               	sarq	$0x3f, %r12
               	leaq	(%rdi,%rdx), %r9
               	cmpq	%rdi, %r9
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rcx,%r8), %rax
               	addq	%rdi, %rax
               	cmpq	%rcx, %rax
               	setb	%r13b
               	movzbq	%r13b, %r13
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rdi, %rcx
               	orq	%r13, %rcx
               	leaq	(%rbx,%r12), %rdi
               	addq	%rdi, %rcx
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	cmpq	%rdi, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r9, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x460(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x13, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x430(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1, %r8
               	leaq	-0x190(%rbp), %rax
               	movq	%r8, (%rax)
               	movq	%r8, 0x8(%rax)
               	leaq	-0x460(%rbp), %rdx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movq	%r8, %rbx
               	sarq	$0x3f, %rbx
               	leaq	(%rsi,%r8), %rdi
               	cmpq	%rsi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rcx,%r8), %rax
               	addq	%rsi, %rax
               	cmpq	%rcx, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rsi, %rcx
               	orq	%r12, %rcx
               	leaq	(%r9,%rbx), %rsi
               	addq	%rsi, %rcx
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	cmpq	%rsi, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rdi, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x1, %edx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x16, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %rdi
               	movq	%r8, %r9
               	movq	%rax, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x440(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdx
               	movabsq	$-0x1, %rax
               	leaq	-0x1a0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x460(%rbp), %rcx
               	movq	%rdx, %r8
               	sarq	$0x3f, %r8
               	movq	%rax, %r9
               	sarq	$0x3f, %r9
               	leaq	(%rsi,%rax), %rdi
               	cmpq	%rsi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	cmpq	%rdx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rsi, %rdx
               	orq	%rbx, %rdx
               	leaq	(%r8,%r9), %rsi
               	addq	%rsi, %rdx
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x460(%rbp), %rsi
               	xorq	%rax, %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x2, %r8
               	movl	$0x19, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rdi
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rax, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x430(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rdx
               	movl	$0x1, %esi
               	leaq	-0x1b0(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x460(%rbp), %rax
               	movq	%rdx, %r9
               	sarq	$0x3f, %r9
               	movq	%rcx, %rbx
               	sarq	$0x3f, %rbx
               	cmpq	%rsi, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %r12
               	subq	%rsi, %r12
               	movq	%rdx, %rdi
               	subq	%rcx, %rdi
               	subq	%r8, %rdi
               	cmpq	%rcx, %rdx
               	setb	%r13b
               	movzbq	%r13b, %r13
               	cmpq	%rcx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%r8, %rcx
               	orq	%r13, %rcx
               	movq	%r9, %rdx
               	subq	%rbx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rdi, %rdx
               	sarq	$0x3f, %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%r12, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x460(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x1, %r8
               	movl	$0x1c, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %rdi
               	movq	%r8, %r9
               	movq	%rdx, %r8
               	movq	%rsi, %rcx
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x430(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1, %rdx
               	leaq	-0x1c0(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x460(%rbp), %r14
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rax, %rdi
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movq	%r8, %rdi
               	subq	%rax, %rdi
               	subq	%r9, %rdi
               	movq	%rdx, %r8
               	xorq	%rcx, %r8
               	movq	%rdx, %r9
               	xorq	%rcx, %r9
               	cmpq	%rcx, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%r8, %rdx
               	subq	%rcx, %rdx
               	movq	%r9, %r8
               	subq	%rcx, %r8
               	subq	%rbx, %r8
               	movq	%rsi, %r15
               	imulq	%rdx, %r15
               	movl	%esi, %r9d
               	movq	%rsi, %rbx
               	shrq	$0x20, %rbx
               	movl	%edx, %r12d
               	movq	%rdx, %r13
               	shrq	$0x20, %r13
               	movq	%r9, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbx, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r8, %rsi
               	imulq	%rdi, %rdx
               	movq	%rsi, %r10
               	movq	0x58(%rsp), %rsi
               	addq	%r10, %rsi
               	cmpq	0x58(%rsp), %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	addq	%rsi, %rdx
               	cmpq	%rsi, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	testq	%r8, %r8
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	%r8d, %r10d
               	movq	%r10, 0x58(%rsp)
               	shrq	$0x20, %r8
               	movq	%r9, %r10
               	imulq	0x58(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %r10
               	imulq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r8, %r9
               	addq	0x38(%rsp), %r9
               	shrq	$0x20, %r9
               	imulq	%rbx, %r8
               	addq	0x58(%rsp), %r8
               	leaq	(%r8,%r9), %rbx
               	movl	%edi, %r8d
               	shrq	$0x20, %rdi
               	movq	%r8, %r9
               	imulq	%r12, %r9
               	shrq	$0x20, %r9
               	imulq	%rdi, %r12
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	imulq	%r13, %r8
               	addq	%r12, %r8
               	shrq	$0x20, %r8
               	imulq	%r13, %rdi
               	addq	%r9, %rdi
               	addq	%r8, %rdi
               	testq	%rbx, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	orq	%r10, %r8
               	orq	%r8, %rdi
               	orq	0x50(%rsp), %rdi
               	orq	0x48(%rsp), %rdi
               	xorq	%rcx, %rax
               	movq	%r15, %rcx
               	xorq	%rax, %rcx
               	movq	%rdx, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rbx
               	subq	%rax, %rbx
               	movq	%r8, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %r8
               	subq	%r9, %r8
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	cmpq	%rdx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rdx, %rcx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%r15, %r15
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %r9
               	movq	%r15, %r12
               	xorq	%rsi, %r12
               	xorq	%rcx, %rdx
               	orq	%r12, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	incq	%rax
               	andq	%rdx, %rax
               	orq	%r9, %rax
               	orq	%rax, %rdi
               	movq	%rbx, (%r14)
               	movq	%r8, 0x8(%r14)
               	leaq	-0x460(%rbp), %rax
               	movl	$0x1, %edx
               	movl	$0x1f, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rsi, %r9
               	movq	%rax, %rsi
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x1d0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x24, %rsi
               	leaq	-0x1e0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x1f0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x1b, %rcx
               	movq	%rdx, %rdi
               	shlq	$0x1b, %rdi
               	shrq	$0x25, %rax
               	orq	%rax, %rdi
               	leaq	-0x200(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	testq	%rcx, %rcx
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r9
               	subq	%rcx, %r9
               	movq	%rdx, %rcx
               	subq	%rdi, %rcx
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	leaq	-0x210(%rbp), %rax
               	movq	%r9, (%rax)
               	movq	%r8, 0x8(%rax)
               	leaq	-0x460(%rbp), %r15
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%r8, %rcx
               	sarq	$0x3f, %rcx
               	movq	%rdx, %rdi
               	xorq	%rax, %rdi
               	movq	%rsi, %rbx
               	xorq	%rax, %rbx
               	cmpq	%rax, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movq	%rbx, %rdi
               	subq	%rax, %rdi
               	subq	%r12, %rdi
               	xorq	%rcx, %r9
               	movq	%r8, %rbx
               	xorq	%rcx, %rbx
               	cmpq	%rcx, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%r9, %r8
               	subq	%rcx, %r8
               	movq	%rbx, %r9
               	subq	%rcx, %r9
               	subq	%r12, %r9
               	movq	%rsi, %r10
               	imulq	%r8, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	%esi, %ebx
               	movq	%rsi, %r12
               	shrq	$0x20, %r12
               	movl	%r8d, %r13d
               	movq	%r8, %r14
               	shrq	$0x20, %r14
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r12, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r12, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	imulq	%r9, %rsi
               	movq	%rdi, %r10
               	imulq	%r8, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r8
               	addq	%rsi, %r8
               	cmpq	0x50(%rsp), %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r8, %rsi
               	addq	0x48(%rsp), %rsi
               	cmpq	%r8, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r9, %r9
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r8, %r10
               	andq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	%r9d, %r8d
               	shrq	$0x20, %r9
               	movq	%rbx, %r10
               	imulq	%r8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	imulq	%r12, %r8
               	addq	0x38(%rsp), %r8
               	movl	%r8d, %r10d
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x20, %r8
               	imulq	%r9, %rbx
               	addq	0x38(%rsp), %rbx
               	shrq	$0x20, %rbx
               	imulq	%r12, %r9
               	addq	%r9, %r8
               	addq	%r8, %rbx
               	movl	%edi, %r8d
               	shrq	$0x20, %rdi
               	movq	%r8, %r9
               	imulq	%r13, %r9
               	shrq	$0x20, %r9
               	movq	%rdi, %r12
               	imulq	%r13, %r12
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	imulq	%r14, %r8
               	addq	%r12, %r8
               	shrq	$0x20, %r8
               	imulq	%r14, %rdi
               	addq	%r9, %rdi
               	addq	%r8, %rdi
               	testq	%rbx, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	orq	%r10, %r8
               	orq	%r8, %rdi
               	orq	0x50(%rsp), %rdi
               	orq	0x48(%rsp), %rdi
               	xorq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	xorq	%rax, %rcx
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rbx
               	subq	%rax, %rbx
               	movq	%r8, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %r8
               	subq	%r9, %r8
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	cmpq	%rsi, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rcx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	0x58(%rsp), %r13
               	testq	%r13, %r13
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %r9
               	movq	0x58(%rsp), %r12
               	xorq	%rdx, %r12
               	xorq	%rcx, %rsi
               	orq	%r12, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	incq	%rax
               	andq	%rsi, %rax
               	orq	%r9, %rax
               	orq	%rax, %rdi
               	movq	%rbx, (%r15)
               	movq	%r8, 0x8(%r15)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x22, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x220(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%r8, %r8
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rsi
               	shlq	$0x24, %rsi
               	leaq	-0x230(%rbp), %rax
               	movq	%r8, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x240(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rbx
               	shlq	$0x1b, %rbx
               	movq	%r8, %rax
               	shlq	$0x1b, %rax
               	movq	%rdx, %rcx
               	shrq	$0x25, %rcx
               	movq	%rax, %r9
               	orq	%rcx, %r9
               	leaq	-0x250(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%r9, 0x8(%rax)
               	leaq	-0x460(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%r9, %rcx
               	sarq	$0x3f, %rcx
               	movq	%r8, %rdi
               	xorq	%rax, %rdi
               	movq	%rsi, %r12
               	xorq	%rax, %r12
               	cmpq	%rax, %rdi
               	setb	%r13b
               	movzbq	%r13b, %r13
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movq	%r12, %rdi
               	subq	%rax, %rdi
               	subq	%r13, %rdi
               	xorq	%rcx, %rbx
               	movq	%r9, %r12
               	xorq	%rcx, %r12
               	cmpq	%rcx, %rbx
               	setb	%r13b
               	movzbq	%r13b, %r13
               	movq	%rbx, %r9
               	subq	%rcx, %r9
               	movq	%r12, %rbx
               	subq	%rcx, %rbx
               	subq	%r13, %rbx
               	movq	%rsi, %r10
               	imulq	%r9, %r10
               	movq	%r10, 0x50(%rsp)
               	movl	%esi, %r12d
               	movq	%rsi, %r13
               	shrq	$0x20, %r13
               	movl	%r9d, %r14d
               	movq	%r9, %r15
               	shrq	$0x20, %r15
               	movq	%r12, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r13, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r12, %r10
               	imulq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r13, %r10
               	imulq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	imulq	%rbx, %rsi
               	movq	%rdi, %r10
               	imulq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r9
               	addq	%rsi, %r9
               	cmpq	0x48(%rsp), %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r9, %rsi
               	addq	0x40(%rsp), %rsi
               	cmpq	%r9, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	testq	%rdi, %rdi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%rbx, %rbx
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r9, %r10
               	andq	0x38(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	%ebx, %r9d
               	shrq	$0x20, %rbx
               	movq	%r12, %r10
               	imulq	%r9, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x30(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x30(%rsp)
               	imulq	%r13, %r9
               	addq	0x30(%rsp), %r9
               	movl	%r9d, %r10d
               	movq	%r10, 0x30(%rsp)
               	shrq	$0x20, %r9
               	imulq	%rbx, %r12
               	addq	0x30(%rsp), %r12
               	shrq	$0x20, %r12
               	imulq	%r13, %rbx
               	addq	%rbx, %r9
               	addq	%r9, %r12
               	movl	%edi, %r9d
               	shrq	$0x20, %rdi
               	movq	%r9, %rbx
               	imulq	%r14, %rbx
               	shrq	$0x20, %rbx
               	movq	%rdi, %r13
               	imulq	%r14, %r13
               	addq	%r13, %rbx
               	movl	%ebx, %r13d
               	shrq	$0x20, %rbx
               	imulq	%r15, %r9
               	addq	%r13, %r9
               	shrq	$0x20, %r9
               	imulq	%r15, %rdi
               	addq	%rbx, %rdi
               	addq	%r9, %rdi
               	testq	%r12, %r12
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r9, %r10
               	movq	0x38(%rsp), %r9
               	orq	%r10, %r9
               	orq	%r9, %rdi
               	orq	0x48(%rsp), %rdi
               	orq	0x40(%rsp), %rdi
               	xorq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	xorq	%rax, %rcx
               	movq	%rsi, %r9
               	xorq	%rax, %r9
               	cmpq	%rax, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rcx, %r12
               	subq	%rax, %r12
               	movq	%r9, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %r9
               	subq	%rbx, %r9
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	cmpq	%rsi, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rsi, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	movq	0x50(%rsp), %r14
               	testq	%r14, %r14
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %rbx
               	movq	0x50(%rsp), %r13
               	xorq	%r8, %r13
               	xorq	%rcx, %rsi
               	orq	%r13, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	incq	%rax
               	andq	%rsi, %rax
               	orq	%rbx, %rax
               	orq	%rax, %rdi
               	movq	0x58(%rsp), %r10
               	movq	%r12, (%r10)
               	movq	0x58(%rsp), %r10
               	movq	%r9, 0x8(%r10)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x25, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x430(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	xorq	%rdx, %rdx
               	leaq	-0x260(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x460(%rbp), %r15
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rax, %rdi
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movq	%r8, %rdi
               	subq	%rax, %rdi
               	subq	%r9, %rdi
               	movq	%rdx, %r8
               	xorq	%rcx, %r8
               	movq	%rdx, %r9
               	xorq	%rcx, %r9
               	cmpq	%rcx, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rcx, %r8
               	subq	%rcx, %r9
               	subq	%rbx, %r9
               	movq	%rsi, %r10
               	imulq	%r8, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	%esi, %ebx
               	movq	%rsi, %r12
               	shrq	$0x20, %r12
               	movl	%r8d, %r13d
               	movq	%r8, %r14
               	shrq	$0x20, %r14
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r12, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r12, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	imulq	%r9, %rsi
               	movq	%rdi, %r10
               	imulq	%r8, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r8
               	addq	%rsi, %r8
               	cmpq	0x50(%rsp), %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r8, %rsi
               	addq	0x48(%rsp), %rsi
               	cmpq	%r8, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r9, %r9
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r8, %r10
               	andq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	%r9d, %r8d
               	shrq	$0x20, %r9
               	movq	%rbx, %r10
               	imulq	%r8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	imulq	%r12, %r8
               	addq	0x38(%rsp), %r8
               	movl	%r8d, %r10d
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x20, %r8
               	imulq	%r9, %rbx
               	addq	0x38(%rsp), %rbx
               	shrq	$0x20, %rbx
               	imulq	%r12, %r9
               	addq	%r9, %r8
               	addq	%r8, %rbx
               	movl	%edi, %r8d
               	shrq	$0x20, %rdi
               	movq	%r8, %r9
               	imulq	%r13, %r9
               	shrq	$0x20, %r9
               	movq	%rdi, %r12
               	imulq	%r13, %r12
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	imulq	%r14, %r8
               	addq	%r12, %r8
               	shrq	$0x20, %r8
               	imulq	%r14, %rdi
               	addq	%r9, %rdi
               	addq	%r8, %rdi
               	testq	%rbx, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	orq	%r10, %r8
               	orq	%r8, %rdi
               	orq	0x50(%rsp), %rdi
               	orq	0x48(%rsp), %rdi
               	xorq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	xorq	%rax, %rcx
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rbx
               	subq	%rax, %rbx
               	movq	%r8, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %r8
               	subq	%r9, %r8
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	cmpq	%rsi, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rcx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	0x58(%rsp), %r13
               	testq	%r13, %r13
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %r9
               	movq	0x58(%rsp), %r12
               	xorq	%rdx, %r12
               	xorq	%rsi, %rcx
               	orq	%r12, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	incq	%rax
               	andq	%rcx, %rax
               	orq	%r9, %rax
               	orq	%rax, %rdi
               	movq	%rbx, (%r15)
               	movq	%r8, 0x8(%r15)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x28, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%rdx, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	leaq	-0x270(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	shlq	$0x3f, %rcx
               	leaq	-0x280(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$-0x1, %r9
               	leaq	-0x450(%rbp), %rax
               	leaq	-0x1(%rdx), %rdi
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	leaq	-0x1(%rcx), %rsi
               	addq	%r8, %rsi
               	cmpq	%rcx, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rcx, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%r8, %rcx
               	orq	%rbx, %rcx
               	decq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x450(%rbp), %rsi
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x2b, %edi
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rcx, %rdi
               	movq	%rax, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rdx
               	movabsq	$-0x1, %rax
               	leaq	-0x290(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x450(%rbp), %rcx
               	xorq	%rsi, %rsi
               	movq	%rax, %r9
               	sarq	$0x3f, %r9
               	cmpq	%rax, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %rbx
               	subq	%rax, %rbx
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	movq	%rdi, %r12
               	subq	%r8, %r12
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	andq	%r8, %rax
               	orq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%r9, %rdx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rbx, (%rcx)
               	movq	%r12, 0x8(%rcx)
               	leaq	-0x450(%rbp), %rax
               	movl	$0x1, %edx
               	movl	$0x2e, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%rsi, %r9
               	movq	%rsi, %r8
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdx
               	xorq	%rax, %rax
               	leaq	-0x2a0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x460(%rbp), %rcx
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	leaq	(%rsi,%rax), %rdi
               	cmpq	%rsi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	cmpq	%rdx, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rsi, %rdx
               	orq	%r9, %rdx
               	leaq	(%r8), %rsi
               	addq	%rsi, %rdx
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x1, %eax
               	movabsq	$-0x1, %rcx
               	movl	$0x31, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rdi
               	movq	%rcx, %r9
               	movq	%rcx, %r8
               	movq	%rax, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1, %rcx
               	leaq	-0x2b0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x460(%rbp), %r14
               	xorq	%rdx, %rdx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rdx, %rsi
               	xorq	%rdx, %rdi
               	testq	%rsi, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	$0x0, %rsi
               	subq	$0x0, %rdi
               	subq	%r8, %rdi
               	movq	%rcx, %r8
               	xorq	%rax, %r8
               	movq	%rcx, %r9
               	xorq	%rax, %r9
               	cmpq	%rax, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%r8, %rcx
               	subq	%rax, %rcx
               	movq	%r9, %r8
               	subq	%rax, %r8
               	subq	%rbx, %r8
               	movq	%rsi, %r15
               	imulq	%rcx, %r15
               	movl	%esi, %r9d
               	movq	%rsi, %rbx
               	shrq	$0x20, %rbx
               	movl	%ecx, %r12d
               	movq	%rcx, %r13
               	shrq	$0x20, %r13
               	movq	%r9, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbx, %r10
               	imulq	%r12, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r8, %rsi
               	imulq	%rdi, %rcx
               	movq	%rsi, %r10
               	movq	0x58(%rsp), %rsi
               	addq	%r10, %rsi
               	cmpq	0x58(%rsp), %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	addq	%rsi, %rcx
               	cmpq	%rsi, %rcx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	testq	%rdi, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%r8, %r8
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r10
               	andq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	%r8d, %esi
               	shrq	$0x20, %r8
               	movq	%r9, %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	%rbx, %rsi
               	addq	0x40(%rsp), %rsi
               	movl	%esi, %r10d
               	movq	%r10, 0x40(%rsp)
               	shrq	$0x20, %rsi
               	imulq	%r8, %r9
               	addq	0x40(%rsp), %r9
               	shrq	$0x20, %r9
               	imulq	%rbx, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %r9
               	movl	%edi, %esi
               	shrq	$0x20, %rdi
               	movq	%rsi, %r8
               	imulq	%r12, %r8
               	shrq	$0x20, %r8
               	movq	%rdi, %rbx
               	imulq	%r12, %rbx
               	addq	%rbx, %r8
               	movl	%r8d, %ebx
               	shrq	$0x20, %r8
               	imulq	%r13, %rsi
               	addq	%rbx, %rsi
               	shrq	$0x20, %rsi
               	imulq	%r13, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rsi
               	testq	%r9, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r10
               	movq	0x48(%rsp), %rdi
               	orq	%r10, %rdi
               	orq	%rdi, %rsi
               	orq	0x58(%rsp), %rsi
               	movq	%rsi, %rdi
               	orq	0x50(%rsp), %rdi
               	xorq	%rdx, %rax
               	movq	%r15, %rsi
               	xorq	%rax, %rsi
               	movq	%rcx, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rsi, %rbx
               	subq	%rax, %rbx
               	movq	%r8, %rsi
               	subq	%rax, %rsi
               	movq	%rsi, %r8
               	subq	%r9, %r8
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	cmpq	%rcx, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rcx, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%r15, %r15
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %r9
               	movq	%r15, %r12
               	xorq	%rdx, %r12
               	xorq	%rsi, %rcx
               	orq	%r12, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	incq	%rax
               	andq	%rcx, %rax
               	orq	%r9, %rax
               	orq	%rax, %rdi
               	movq	%rbx, (%r14)
               	movq	%r8, 0x8(%r14)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x1, %eax
               	movl	$0x34, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rax, %rcx
               	movq	%rax, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x64, %ecx
               	leaq	-0x2c0(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	movl	$0x17, %esi
               	leaq	-0x2d0(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x480(%rbp), %rdi
               	leaq	(%rcx,%rsi), %rax
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rdx,%rdx), %rcx
               	addq	%rsi, %rcx
               	cmpq	%rdx, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rdx, %rcx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rsi
               	orq	%r8, %rsi
               	addq	$0x0, %rsi
               	testq	%rsi, %rsi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movl	%eax, %esi
               	movl	%esi, (%rdi)
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	xorq	$0x1, %rax
               	movq	%r8, %rdi
               	orq	%rax, %rdi
               	movl	-0x480(%rbp), %eax
               	leaq	-0x2e0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdx, 0x8(%rsi)
               	movl	$0x7b, %r8d
               	movl	$0x37, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	leaq	-0x2f0(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	-0x300(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x480(%rbp), %r8
               	leaq	(%rdx,%rdi), %rax
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rcx,%rcx), %rdx
               	addq	%rsi, %rdx
               	cmpq	%rcx, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rcx, %rdx
               	sete	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rsi
               	orq	%r9, %rsi
               	addq	$0x0, %rsi
               	testq	%rsi, %rsi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movl	%eax, %esi
               	movl	%esi, (%r8)
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	xorq	$0x1, %rax
               	orq	%r9, %rax
               	movl	-0x480(%rbp), %edx
               	leaq	-0x310(%rbp), %rsi
               	movq	%rdx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x3a, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x5, %ecx
               	leaq	-0x320(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	movl	$0x7, %esi
               	leaq	-0x330(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x478(%rbp), %r8
               	movq	%rdx, %r9
               	sarq	$0x3f, %r9
               	movq	%rdx, %rbx
               	sarq	$0x3f, %rbx
               	cmpq	%rsi, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	subq	%rsi, %rax
               	movq	%rdx, %rcx
               	subq	%rdx, %rcx
               	subq	%rdi, %rcx
               	cmpq	%rdx, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rdx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rdi
               	orq	%rdi, %rsi
               	movq	%r9, %rdi
               	subq	%rbx, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	%rcx, %rdi
               	sarq	$0x3f, %rdi
               	cmpq	%rdi, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movslq	%eax, %rsi
               	movl	%eax, (%r8)
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	cmpq	%rax, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %r8
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	xorq	$0x1, %rax
               	orq	%rax, %rdi
               	movslq	-0x478(%rbp), %rax
               	leaq	-0x340(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x2, %r8
               	movl	$0x3d, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x10000, %esi          # imm = 0x10000
               	leaq	-0x350(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x360(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x478(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	movq	%rsi, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rdi
               	subq	%rax, %r8
               	subq	%r9, %r8
               	xorq	%rdx, %rsi
               	movq	%rcx, %r9
               	xorq	%rdx, %r9
               	cmpq	%rdx, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rdx, %rsi
               	subq	%rdx, %r9
               	subq	%rbx, %r9
               	movq	%rdi, %r15
               	imulq	%rsi, %r15
               	movl	%edi, %ebx
               	movq	%rdi, %r12
               	shrq	$0x20, %r12
               	movl	%esi, %r13d
               	movq	%rsi, %r14
               	shrq	$0x20, %r14
               	movq	%rbx, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r12, %r10
               	imulq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x58(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbx, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r12, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	imulq	%r9, %rdi
               	imulq	%r8, %rsi
               	movq	%rdi, %r10
               	movq	0x58(%rsp), %rdi
               	addq	%r10, %rdi
               	cmpq	0x58(%rsp), %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	addq	%rdi, %rsi
               	cmpq	%rdi, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	testq	%r8, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%r9, %r9
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rdi, %r10
               	andq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	%r9d, %edi
               	shrq	$0x20, %r9
               	movq	%rbx, %r10
               	imulq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	imulq	%r12, %rdi
               	addq	0x38(%rsp), %rdi
               	movl	%edi, %r10d
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x20, %rdi
               	imulq	%r9, %rbx
               	addq	0x38(%rsp), %rbx
               	shrq	$0x20, %rbx
               	imulq	%r12, %r9
               	addq	%r9, %rdi
               	addq	%rdi, %rbx
               	movl	%r8d, %edi
               	shrq	$0x20, %r8
               	movq	%rdi, %r9
               	imulq	%r13, %r9
               	shrq	$0x20, %r9
               	movq	%r8, %r12
               	imulq	%r13, %r12
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	imulq	%r14, %rdi
               	addq	%r12, %rdi
               	shrq	$0x20, %rdi
               	imulq	%r14, %r8
               	addq	%r9, %r8
               	addq	%r8, %rdi
               	testq	%rbx, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	orq	%r10, %r8
               	orq	%r8, %rdi
               	orq	0x58(%rsp), %rdi
               	movq	%rdi, %r8
               	orq	0x48(%rsp), %r8
               	xorq	%rdx, %rax
               	movq	%r15, %rdx
               	xorq	%rax, %rdx
               	movq	%rsi, %rdi
               	xorq	%rax, %rdi
               	cmpq	%rax, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rdx
               	subq	%rax, %rdi
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	cmpq	%rsi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rsi, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%r15, %r15
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %rbx
               	movq	%r15, %r12
               	xorq	%rcx, %r12
               	xorq	%rdi, %rsi
               	orq	%r12, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	incq	%rax
               	andq	%rsi, %rax
               	orq	%rbx, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movslq	%edx, %rax
               	movq	0x50(%rsp), %r10
               	movl	%edx, (%r10)
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r9, %rdi
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	xorq	$0x1, %rax
               	movq	%rsi, %rdi
               	orq	%rax, %rdi
               	movslq	-0x478(%rbp), %rax
               	leaq	-0x370(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x1, %edx
               	movl	$0x40, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	leaq	-0x380(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %edx
               	leaq	-0x390(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x470(%rbp), %rdi
               	cmpq	%rdx, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	movq	%rcx, %r8
               	subq	%rcx, %r8
               	subq	%rsi, %r8
               	cmpq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rcx, %rcx
               	sete	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rsi
               	orq	%r9, %rsi
               	xorq	%r9, %r9
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	subq	%r10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, (%rdi)
               	cmpq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%r8, %r8
               	sete	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	xorq	$0x1, %rax
               	movq	%rsi, %rdi
               	orq	%rax, %rdi
               	movq	-0x470(%rbp), %rax
               	leaq	-0x3a0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movabsq	$-0x1, %r8
               	movl	$0x43, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rsi
               	leaq	-0x3b0(%rbp), %rax
               	movq	%rsi, (%rax)
               	movabsq	$-0x1, %rdi
               	movq	%rdi, 0x8(%rax)
               	movl	$0x5, %r9d
               	leaq	-0x3c0(%rbp), %rax
               	movq	%r9, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x468(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rax, %rsi
               	movq	%rdi, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rax, %rsi
               	subq	%rax, %r8
               	subq	%rbx, %r8
               	xorq	%rcx, %r9
               	movq	%rdx, %rbx
               	xorq	%rcx, %rbx
               	cmpq	%rcx, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%rcx, %r9
               	subq	%rcx, %rbx
               	subq	%r12, %rbx
               	movq	%rsi, %r10
               	imulq	%r9, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	%esi, %r12d
               	movq	%rsi, %r13
               	shrq	$0x20, %r13
               	movl	%r9d, %r14d
               	movq	%r9, %r15
               	shrq	$0x20, %r15
               	movq	%r12, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r13, %r10
               	imulq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r12, %r10
               	imulq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r13, %r10
               	imulq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	imulq	%rbx, %rsi
               	movq	%r8, %r10
               	imulq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x50(%rsp), %r9
               	addq	%rsi, %r9
               	cmpq	0x50(%rsp), %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r9, %rsi
               	addq	0x40(%rsp), %rsi
               	cmpq	%r9, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	testq	%r8, %r8
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%rbx, %rbx
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r9, %r10
               	andq	0x38(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	%ebx, %r9d
               	shrq	$0x20, %rbx
               	movq	%r12, %r10
               	imulq	%r9, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x30(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x30(%rsp)
               	imulq	%r13, %r9
               	addq	0x30(%rsp), %r9
               	movl	%r9d, %r10d
               	movq	%r10, 0x30(%rsp)
               	shrq	$0x20, %r9
               	imulq	%rbx, %r12
               	addq	0x30(%rsp), %r12
               	shrq	$0x20, %r12
               	imulq	%r13, %rbx
               	addq	%rbx, %r9
               	addq	%r9, %r12
               	movl	%r8d, %r9d
               	shrq	$0x20, %r8
               	movq	%r9, %rbx
               	imulq	%r14, %rbx
               	shrq	$0x20, %rbx
               	movq	%r8, %r13
               	imulq	%r14, %r13
               	addq	%r13, %rbx
               	movl	%ebx, %r13d
               	shrq	$0x20, %rbx
               	imulq	%r15, %r9
               	addq	%r13, %r9
               	shrq	$0x20, %r9
               	imulq	%r15, %r8
               	addq	%rbx, %r8
               	addq	%r9, %r8
               	testq	%r12, %r12
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r8, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r9, %r10
               	movq	0x38(%rsp), %r9
               	orq	%r10, %r9
               	orq	%r9, %r8
               	orq	0x50(%rsp), %r8
               	movq	%r8, %r9
               	orq	0x40(%rsp), %r9
               	xorq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	xorq	%rax, %rcx
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rax, %rcx
               	subq	%rax, %r8
               	movq	%rbx, %r10
               	movq	%r8, %rbx
               	subq	%r10, %rbx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	cmpq	%rsi, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rsi, %r8
               	sete	%r13b
               	movzbq	%r13b, %r13
               	movq	0x58(%rsp), %r14
               	testq	%r14, %r14
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r12
               	movq	0x58(%rsp), %r13
               	xorq	%rdx, %r13
               	xorq	%r8, %rsi
               	orq	%r13, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	incq	%rax
               	andq	%rsi, %rax
               	orq	%r12, %rax
               	orq	%r9, %rax
               	movq	0x48(%rsp), %r10
               	movq	%rcx, (%r10)
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	cmpq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rbx, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rcx
               	xorq	$0x1, %rcx
               	orq	%rcx, %rax
               	movq	-0x468(%rbp), %rcx
               	leaq	-0x3d0(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	sarq	$0x3f, %rcx
               	movq	%rcx, 0x8(%rsi)
               	movabsq	$-0xf, %r8
               	movl	$0x46, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rdi, %r8
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	leaq	-0x3e0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	movq	%rsi, %rdi
               	shlq	$0x3f, %rdi
               	movq	%rax, %rcx
               	shlq	$0x3f, %rcx
               	movq	%rsi, %rdx
               	shrq	%rdx
               	orq	%rdx, %rcx
               	leaq	-0x3f0(%rbp), %rdx
               	movq	%rdi, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	leaq	-0x400(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x468(%rbp), %r8
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movq	%rax, %rbx
               	sarq	$0x3f, %rbx
               	leaq	(%rdi,%rax), %rdx
               	cmpq	%rdi, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	cmpq	%rcx, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rdi, %rcx
               	orq	%r12, %rcx
               	leaq	(%r9,%rbx), %rdi
               	addq	%rdi, %rcx
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	cmpq	%rdi, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rdx, (%r8)
               	movq	%rdx, %rdi
               	sarq	$0x3f, %rdi
               	cmpq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rax, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	andq	%rdx, %rax
               	xorq	$0x1, %rax
               	movq	%rcx, %rdi
               	orq	%rax, %rdi
               	movq	-0x468(%rbp), %rcx
               	leaq	-0x410(%rbp), %rax
               	movq	%rcx, (%rax)
               	sarq	$0x3f, %rcx
               	movq	%rcx, 0x8(%rax)
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x49, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	leaq	-0x460(%rbp), %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorq	%rsi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x4c, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	leaq	-0x450(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x450(%rbp), %rsi
               	movl	$0x4f, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %rdi
               	movq	%rdx, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x450(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x1, %rsi
               	movl	$0x1, %edi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x450(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	movl	$0x52, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
