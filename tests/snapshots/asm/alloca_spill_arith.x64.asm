
alloca_spill_arith.x64:	file format elf64-x86-64

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
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x10000, %eax          # imm = 0x10000
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	decq	%rcx
               	addq	%rcx, %rax
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	movq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, -0x18(%rbp)
               	movzbq	0x1(%rax), %rcx
               	movq	%rcx, -0x20(%rbp)
               	movzbq	0x2(%rax), %rcx
               	movq	%rcx, -0x28(%rbp)
               	movzbq	0x3(%rax), %rcx
               	movq	%rcx, -0x30(%rbp)
               	movzbq	0x4(%rax), %rcx
               	movq	%rcx, -0x38(%rbp)
               	movzbq	0x5(%rax), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x50(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x58(%rbp)
               	movq	-0x48(%rbp), %rax
               	leaq	(%rax,%rax,2), %rcx
               	movq	%rcx, -0x60(%rbp)
               	movq	-0x50(%rbp), %rcx
               	leaq	(%rcx,%rcx,4), %rdx
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x58(%rbp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rdx, -0x70(%rbp)
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0x78(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0xc8(%rbp)
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	movq	-0x58(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0xd0(%rbp)
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x88(%rbp)
               	movq	-0x18(%rbp), %r12
               	movq	-0x20(%rbp), %rax
               	leaq	(%r12,%rax), %rdx
               	movq	-0x28(%rbp), %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	-0x30(%rbp), %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	-0x38(%rbp), %rsi
               	addq	%rsi, %rdi
               	movq	-0x40(%rbp), %r13
               	addq	%r13, %rdi
               	movq	-0x48(%rbp), %r14
               	leaq	(%rdi,%r14), %r8
               	movq	-0x50(%rbp), %rdi
               	addq	%rdi, %r8
               	movq	-0x58(%rbp), %r15
               	leaq	(%r8,%r15), %r9
               	movq	-0x60(%rbp), %r8
               	leaq	(%r9,%r8), %rbx
               	movq	-0x68(%rbp), %r9
               	leaq	(%rbx,%r9), %r10
               	movq	%r10, -0xf8(%rbp)
               	movq	-0x70(%rbp), %rbx
               	movq	-0xf8(%rbp), %r10
               	addq	%rbx, %r10
               	movq	%r10, -0xf8(%rbp)
               	movq	-0x78(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	-0xf8(%rbp), %r10
               	addq	-0x100(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	movq	-0x80(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	-0xf8(%rbp), %r10
               	addq	-0x100(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	movq	-0x88(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	-0xf8(%rbp), %r10
               	addq	-0x100(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	movq	-0xf8(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	cmpq	%rax, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	addq	%r12, %rax
               	cmpq	%rdx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%rsi, %rdx
               	setl	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%r13, %rsi
               	setl	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%rdi, %r14
               	setg	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%r15, %rdi
               	setg	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%r9, %r8
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%rbx, %r9
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	cmpq	%r8, %rbx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x98(%rbp)
               	movq	-0x90(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0xa0(%rbp)
               	movq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movzbq	(%rax), %rdx
               	movq	-0x8(%rbp), %rsi
               	decq	%rsi
               	addq	%rax, %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0xa8(%rbp)
               	movzbq	0x2(%rax), %rdx
               	movzbq	0x3(%rax), %rax
               	addq	%rdx, %rax
               	movq	%rax, -0xb0(%rbp)
               	movq	-0xa0(%rbp), %rax
               	cmpq	$0xe0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rcx, -0xe0(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0xb0(%rbp), %rax
               	cmpq	$0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd8(%rbp)
               	movq	-0xd8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	movq	%rax, -0xe8(%rbp)
               	movq	-0xe8(%rbp), %rax
               	movslq	%eax, %rax
               	leaq	-0x130(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	<addr>
