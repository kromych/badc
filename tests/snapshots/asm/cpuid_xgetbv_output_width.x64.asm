
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpl	%edi, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	%eax, %ebx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	%eax, %edx
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	testl	$0x8000000, %ecx        # imm = 0x8000000
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x2152411021524111, %rax # imm = 0xDEADBEEFDEADBEEF
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	xorl	%esi, %esi
               	xorl	%ecx, %ecx
               	xgetbv
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
