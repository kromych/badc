
cpuid_xgetbv_output_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<cpuid_long_outputs_fill_all_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rcx)
               	movq	%rax, (%rdx)
               	movq	%rax, (%rsi)
               	movq	%rax, (%rdi)
               	xorq	%rax, %rax
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	cpuid
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x28(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x20(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x18(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rdx
               	movq	-0x38(%rbp), %rbx
               	movq	(%rcx), %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rdx), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsi), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rdi), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<cpuid_int_outputs_agree>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	cpuid
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x50(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x48(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rbx
               	movl	-0x20(%rbp), %ecx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movl	%edx, %edx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x10(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x8(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<xgetbv_long_outputs_fill_all_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x18(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	%rdi, -0x60(%rbp)
               	movq	%r8, -0x58(%rbp)
               	movq	%r9, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	cpuid
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x68(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x60(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %eax
               	andq	$0x8000000, %rax        # imm = 0x8000000
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rcx)
               	movq	%rax, (%rdx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	-0x68(%rbp), %rcx
               	xgetbv
               	movq	-0x78(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x10(%rbp), %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
