
inline_asm_clobber_live_values.x64:	file format elf64-x86-64

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

<spread>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0x2(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	0x3(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0x4(%rdi), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0x5(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x6(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0x7(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0x8(%rdi), %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	movq	0x60(%rsp), %rax
               	shlq	%rax
               	movq	%rax, %r10
               	movq	0x68(%rsp), %rax
               	addq	%r10, %rax
               	movq	0x58(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	shlq	$0x6, %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	shlq	$0x7, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<branchy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	movq	0x38(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<carried>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	cmpq	%r13, %rbx
               	jge	<addr>
               	movq	%rbx, %rax
               	imulq	%rbx, %rax
               	addq	%rax, %r12
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	incq	%rbx
               	cmpq	%r13, %rbx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<jumped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rbx
               	pushq	%r12
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rdi,4), %rax
               	leaq	0x3(%rax), %r12
               	movq	%rsi, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movq	%r12, %rax
               	popq	%r12
               	popq	%rbx
               	popq	%rbp
               	retq
               	leaq	0x1(%r12), %rax
               	popq	%r12
               	popq	%rbx
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	movq	%rbx, %rax
               	imulq	%rbx, %rax
               	addq	%rax, %r12
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	incq	%rbx
               	cmpl	$0xa, %ebx
               	jl	<addr>
               	cmpq	$0x11d, %r12            # imm = 0x11D
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%ebx, %ebx
               	testl	%ebx, %ebx
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movl	$0x1, %ebx
               	testl	%ebx, %ebx
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	jmp	<addr>
