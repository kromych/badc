
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rdi)
               	movq	%rax, (%rcx)
               	movq	%rax, (%rdx)
               	movq	%rax, (%rsi)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	leaq	<rip>, %r10
               	movq	%rax, (%r10)
               	leaq	<rip>, %r10
               	movq	%rbx, (%r10)
               	leaq	<rip>, %r10
               	movq	%rcx, (%r10)
               	leaq	<rip>, %r10
               	movq	%rdx, (%r10)
               	movq	(%rdi), %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<cpuid_int_outputs_agree>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x20(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x20(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	-0x10(%rbp), %ecx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x8(%rbp), %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<xgetbv_long_outputs_fill_all_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x30(%rbp)
               	movl	%ebx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x18(%rbp)
               	movl	-0x20(%rbp), %eax
               	testl	$0x8000000, %eax        # imm = 0x8000000
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, (%rsi)
               	movq	%rax, (%rdi)
               	xorl	%esi, %esi
               	xorl	%ecx, %ecx
               	xgetbv
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
