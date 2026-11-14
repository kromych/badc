
ssa_fp_compare_nan.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movl	$0x1, %ecx
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	cmovbeq	%rax, %rcx
               	movq	%rcx, %rdx
               	orq	$0x2, %rdx
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm0
               	cmovaq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x4, %rdx
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	cmovaeq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x8, %rdx
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm0
               	cmovaeq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x10, %rdx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rdx, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movq	%rcx, %rdx
               	orq	$0x20, %rdx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	orq	$0x40, %rax
               	comisd	%xmm0, %xmm0
               	cmovaq	%rax, %rcx
               	movq	%rcx, %rsi
               	orq	$0x80, %rsi
               	ucomisd	%xmm0, %xmm0
               	cmovneq	%rcx, %rsi
               	cmovpq	%rcx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
