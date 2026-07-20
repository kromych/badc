
slot_coalesce_alloca.x64:	file format elf64-x86-64

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
               	subq	$0x170, %rsp            # imm = 0x170
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x3, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x30(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, -0x38(%rbp)
               	movl	$0x6, %eax
               	movq	%rax, -0x40(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x48(%rbp)
               	movl	$0x7, %eax
               	movq	%rax, -0x50(%rbp)
               	movl	$0x8, %eax
               	movq	%rax, -0x58(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x60(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x60(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x68(%rbp)
               	movl	$0x40, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x70(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rcx
               	movslq	-0x78(%rbp), %rax
               	movq	-0x68(%rbp), %rdx
               	addq	%rax, %rdx
               	movq	%rdx, (%rcx,%rax,8)
               	movslq	-0x78(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x78(%rbp)
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	movq	-0x68(%rbp), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movq	%rdx, %r8
               	shlq	$0x3, %r8
               	addq	%rsi, %r8
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rsi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x18, %rdx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x18, %rdx
               	jl	<addr>
               	movq	%rcx, -0x80(%rbp)
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rcx
               	movslq	-0x88(%rbp), %rax
               	movq	(%rcx,%rax,8), %rcx
               	movq	-0x68(%rbp), %rdx
               	addq	%rdx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movslq	-0x88(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x88(%rbp)
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
