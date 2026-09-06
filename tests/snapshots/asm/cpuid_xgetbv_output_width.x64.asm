
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
               	subq	$0x40, %rsp
               	movq	%r12, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	leaq	<rip>, %r9
               	leaq	<rip>, %r12
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rdi)
               	movq	%rax, (%r8)
               	movq	%rax, (%r9)
               	movq	%rax, (%r12)
               	xorq	%rsi, %rsi
               	movq	%rdi, -0x30(%rbp)
               	movq	%r8, -0x28(%rbp)
               	movq	%r9, -0x20(%rbp)
               	movq	%r12, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
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
               	movq	(%rdi), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%r8), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%r9), %rcx
               	shrq	$0x20, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%r12), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>

<cpuid_int_outputs_agree>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
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
               	movl	-0x20(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	-0x10(%rbp), %ecx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movl	%edx, %edx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x8(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>

<xgetbv_long_outputs_fill_all_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
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
               	movl	-0x20(%rbp), %eax
               	andq	$0x8000000, %rax        # imm = 0x8000000
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rsi)
               	movq	%rax, (%rdi)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	xorq	%rsi, %rsi
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	-0x60(%rbp), %rcx
               	xgetbv
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x68(%rbp), %r10
               	movq	%rdx, (%r10)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	shrq	$0x20, %rax
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
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
