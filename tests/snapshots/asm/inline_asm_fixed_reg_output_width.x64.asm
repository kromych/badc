
inline_asm_fixed_reg_output_width.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rdx)
               	movq	%rax, (%rsi)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	rdtsc
               	movq	-0x40(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x38(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movq	%rax, (%rcx)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x18(%rbp), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	rdtsc
               	movq	-0x40(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x38(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rdx
               	movl	-0x18(%rbp), %eax
               	shlq	$0x20, %rax
               	movl	-0x10(%rbp), %ecx
               	orq	%rax, %rcx
               	movq	-0x20(%rbp), %rax
               	shrq	$0x30, %rax
               	movq	%rcx, %rdx
               	shrq	$0x30, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movabsq	$-0x2152411021524111, %rcx # imm = 0xDEADBEEFDEADBEEF
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movl	$0x99, %eax
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x99, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movw	%cx, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movw	%ax, 0x2(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0xfeed, %edx           # imm = 0xFEED
               	movw	%dx, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x2, %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movq	-0x48(%rbp), %r10
               	movw	%ax, (%r10)
               	movq	-0x50(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	xorq	$0xbeef, %rcx           # imm = 0xBEEF
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzwq	0x2(%rax), %rax
               	xorq	$0x3344, %rax           # imm = 0x3344
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	xorq	$0xfeed, %rax           # imm = 0xFEED
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
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
